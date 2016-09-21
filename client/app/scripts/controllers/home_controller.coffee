# Created by Oguzhan on 06/09/16.


'use strict';

angular.module 'puzzles'
.controller 'HomeController', ($rootScope, $scope, $controller, $http, $modal, $log, $state, Auth, PuzzleWebService, CommentWebService, VoteWebService, AnswerWebService) ->
  angular.extend this, $controller 'BaseController', $scope: $scope
  $rootScope.$state = $state;
  Auth.currentUser().then(
    (user) ->
      $scope.user = user
  )

  getPuzzles = ->
    PuzzleWebService.getCurrent().then(
      (puzzles) ->
        $scope.puzzles = puzzles
        $log.info $scope.puzzles
        getComments()
    )

  getComments = (puzzleId)->
    if(!puzzleId)
      param = puzzle_id: $scope.puzzles[$scope.selected.value].id
      puzzleId = param.puzzle_id
    else
      param =
        puzzle_id: puzzleId

    CommentWebService.getCurrent(param).then(
      (comments) ->
        $scope.comments = comments
    )
    getVotes()
    $scope.currentPuzzle = $scope.puzzles[$scope.selected.value]
    calculateBonus($scope.currentPuzzle)
    getUserAnswer($scope.currentPuzzle.id)


  getVotes = (puzzleId) ->
    $scope.votes = [0.0, 0.0]
    if(!puzzleId)
      param = puzzle_id: $scope.puzzles[$scope.selected.value].id
      puzzleId = param.puzzle_id
    else
      param =
        puzzle_id: puzzleId
    console.log(param)
    VoteWebService.getCurrent(param).then(
      (votes) ->
        votes[0] = parseFloat(votes[0]).toFixed(1)
        votes[1] = parseFloat(votes[1]).toFixed(1)
        $scope.votes = votes
    )

  getPuzzles()

  $scope.selected =
    value: 0

  $scope.comments = []


  getUsers = () ->
    url = 'http://jsonplaceholder.typicode.com/users'
    $http.get(url).then(
      (response) ->
        console.log('response ' + response)
        $scope.users = response.data
    )


  getUsers()

  $scope.changePuzzle = () ->
    $scope.userAnswer = null
    getComments()


  $scope.addComment = (puzzle) ->
    modalInstance = $modal.open
      animation: true
      backdrop: 'static'
      keyboard: false
      templateUrl: 'views/user_create_comment.html'
      controller: 'UserCreateCommentController'
      size: 'md'
      resolve:
        puzzle: ->
          puzzle
        parent: ->
          $scope
    modalInstance.result.then(
      (result) ->
        getComments(puzzle.id)
        return
      () ->
        $log.info 'Modal dismissed at: ' + new Date
        return
    )
    return

  $scope.sendAnswer = () ->
    currentPuzzle = $scope.puzzles[$scope.selected.value]
    if currentPuzzle.answer
      answered =
        answer: currentPuzzle.answer
        puzzle_id: currentPuzzle.id
      $log.info "answered: ", answered
      if $scope.userAnswer == null
        AnswerWebService.create({answered: answered}).then(
          (result) ->
            onAnswerSuccess(result)
          (error) ->
            onAnswerError(error)
        )
      else
        answered.id = $scope.userAnswer.id
        AnswerWebService.update({answered: answered}).then(
          (result) ->
            onAnswerSuccess(result)
          (error) ->
            onAnswerError(error)
        )

  calculateBonus = (currentPuzzle) ->
    currentDate = new Date()
    timeDiff = Math.abs(currentDate.getTime() - new Date(currentPuzzle.publishDate).getTime());
    diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));
    bonus = if diffDays < 6 then 6 - diffDays else 0
    currentPuzzle.bonus = bonus


  onAnswerSuccess = (answer) ->
    $scope.userAnswer = answer
    $log.info 'answer: ', answer
    $scope.actionOnSuccess(true, 'answer creation is successfull')


  onAnswerError = (error) ->
    $log.error 'create answer Error: ', error
    $scope.actionOnError error

  getUserAnswer = (puzzleId) ->
    AnswerWebService.getUserAnswer(puzzleId).then(
      (answer) ->
        if(answer.length > 0)
          $scope.userAnswer = answer[0]
          $log.info 'user answer: ' + $scope.userAnswer
        else
          $scope.userAnswer = null
      (error) ->
        $scope.userAnswer = null
    )
