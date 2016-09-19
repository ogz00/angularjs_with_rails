# Created by Oguzhan on 06/09/16.


'use strict';

angular.module 'puzzles'
.controller 'HomeController', ($rootScope, $scope, $controller, $http, $modal, $log, Auth, PuzzleWebService, CommentWebService, VoteWebService, AnswerWebService) ->
  angular.extend this, $controller 'BaseController', $scope: $scope

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


  getVotes = (puzzleId) ->
    $scope.votes = [0.0,0.0]
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

  #$scope.comment = {}
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
      if puzzles[selected.value].answer
        answer =
          answer : puzzles[selected.value].answer
          puzzle_id: puzzles[selected.value].id

        AnswerWebService.create(answer).then(
          (result) ->
            onSuccess(result)
          (error) ->
            onError(error)
        )
