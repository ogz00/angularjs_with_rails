'use strict'

###*
 # @ngdoc function
 # @name puzzles.controller:AdminPuzzlesController
 # @description
 # # AdminPuzzlesController
 # Controller of the puzzles
###
angular.module 'puzzles'
.controller 'AdminUserScoresController', ($scope, $controller, $log, $state, $filter, $modal, ScoreWebService, PuzzleWebService) ->
  angular.extend this, $controller 'BaseController', $scope: $scope

  calculateAllScores = ()->
    ScoreWebService.calculateUsersScores().then(
      (userScores) ->
        $log.info 'userScores: ', userScores
        $scope.userScores = userScores
        $scope.actionOnSuccess(true, 'score calculation is successfull')
        return
      (error) ->
        $log.error 'userScores error: ', error
        $scope.actionOnError error
        return
    )

  if($state.current.name == 'adminScores')
    calculateAllScores()

  $scope.refresh = () ->
    calculateAllScores()

  getPuzzles = ->
    PuzzleWebService.getCurrent().then(
      (puzzles) ->
        $scope.puzzles = puzzles
        $scope.selectedPuzzles()
        $log.info $scope.puzzles
    )

  $scope.selectedPuzzles = ()->
    $scope.puzzleList = $filter('filter')($scope.puzzles, {isTabled: true})

  if($state.current.name == 'adminTabledScores')
    getPuzzles()

  $scope.getTabledUserScores = ()->
    puzzleIdList = $scope.puzzleList.map((puzzle) ->
      return puzzle.id
    )

    ScoreWebService.calculateTabledScores({puzzleIds: puzzleIdList}).then(
      (scoreList)->
        $log.info "score list: ", scoreList
        $scope.scores = scoreList
      (error) ->
        $log.error "score list: error", error
    )

  $scope.publishTabledUserScores = () ->
    tabledUserScores = $scope.scores
#    for i in [0 ...$scope.scores.length]
#      tabledUserScores[i] = $scope.scores[i]

    console.log tabledUserScores
    ScoreWebService.publishTabledScores({tabled_user_scores: tabledUserScores}).then(

    )



  #$scope.getTabledUserScores()
