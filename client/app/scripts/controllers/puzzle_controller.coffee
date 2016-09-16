'use strict'

###*
 # @ngdoc function
 # @name puzzles.controller:PuzzleController
 # @description
 # # ProductCtrl
 # Controller of the puzzles
###
angular.module 'puzzles'
.controller 'PuzzleController', ($scope, $location, $log, $controller, PuzzleWebService) ->
  angular.extend this, $controller 'BaseCtrl', $scope: $scope

  getCurrentProducts = ->
    PuzzleWebService.getPuzzles().then(
      (result) ->
        $log.info result
        $scope.currentPuzzles = result
    , (error) ->
      $log.error 'error', error
      $scope.showErrorNotification error.errors[0]
    )

  getCurrentProducts()

