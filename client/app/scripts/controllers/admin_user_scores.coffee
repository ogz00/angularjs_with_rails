'use strict'

###*
 # @ngdoc function
 # @name puzzles.controller:AdminPuzzlesController
 # @description
 # # AdminPuzzlesController
 # Controller of the puzzles
###
angular.module 'puzzles'
.controller 'AdminUserScoresController', ($scope, $controller, $log, $modal, ScoreWebService) ->
  angular.extend this, $controller 'BaseController', $scope: $scope

  calculateAllScores = ()->
    ScoreWebService.calculateUsersCurrentScores().then(
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



  calculateAllScores()

  $scope.refresh = () ->
    calculateAllScores()
