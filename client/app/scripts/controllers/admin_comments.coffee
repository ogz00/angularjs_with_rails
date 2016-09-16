'use strict'

###*
 # @ngdoc function
 # @name puzzles.controller:AdminCommentsController
 # @description
 # # AdminCommentsController
 # Controller of the puzzles
###
angular.module 'puzzles'
.controller 'AdminCommentsController', ($scope, $controller, PuzzleWebService, $log, $state, $modal, CommentWebService) ->
  angular.extend this, $controller 'BaseController', $scope: $scope

  $scope.open =
    id: null

  $scope.comments = []

  getPuzzles = ()->
    PuzzleWebService.getPuzzles().then(
      (puzzles) ->
        $log.info 'puzzles: ', puzzles
        $scope.puzzles = puzzles
        return
      (error) ->
        $log.error 'puzzles error: ', error
        $scope.showErrorNotification error
        return
    )

  getPuzzles()

  $scope.showCommentsForPuzzle = (puzzleId)->
    param =
      puzzleId: puzzleId
    CommentWebService.getCommentsForAdmin(param).then(
      (comments) ->
        $log.info 'comments: ', comments
        $scope.comments = comments
        return
      (error) ->
        $log.error 'puzzles error: ', error
        $scope.showErrorNotification error
        return
    )

  $scope.toggleOpened = (puzzleId) ->
    if $scope.open.id != puzzleId
      $scope.open.id = puzzleId
    else
      $scope.open.id = null






