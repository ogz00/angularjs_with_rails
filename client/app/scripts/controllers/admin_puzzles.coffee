'use strict'

###*
 # @ngdoc function
 # @name puzzles.controller:AdminPuzzlesController
 # @description
 # # AdminPuzzlesController
 # Controller of the puzzles
###
angular.module 'puzzles'
.controller 'AdminPuzzlesController', ($scope, $controller, $log, $modal, PuzzleWebService) ->
  angular.extend this, $controller 'BaseController', $scope: $scope

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


  $scope.addPuzzle = (puzzle) ->
    modalInstance = $modal.open
      animation: true
      backdrop: 'static'
      keyboard: false
      templateUrl: 'views/admin_create_puzzle.html'
      controller: 'AdminCreatePuzzleController'
      size: 'md'
      resolve:
        puzzle: ->
          puzzle
        parent: ->
          $scope
    modalInstance.result.then(
      (result) ->
        if puzzle
          for a, i in $scope.puzzles
            if a.id == puzzle.id
              $scope.puzzles[i] = puzzle
        else
          if $scope.puzzles is null
            $scope.puzzles = []
          $scope.puzzles.push result
          return
      () ->
        $log.info 'Modal dismissed at: ' + new Date
        return
    )
    return

  $scope.deletePuzzle = (puzzle) ->
    $scope.delete(puzzle.id, PuzzleWebService.delete).then(
      () ->
        for a, i in $scope.puzzles
          if a.id == puzzle.id
            $scope.puzzles.splice(i,1)
      () ->
    )

  $scope.calculateScore = (id) ->
    PuzzleWebService.calculateScore(id).then(
      (result) ->
        onSuccessCalculate(result)
      (error) ->
        onErrorCalculate(error)
    )

  onSuccessCalculate = (puzzle) ->
    $log.info 'puzzle: ', puzzle
    $scope.actionOnSuccess(true, 'puzzle score calculation is successfull')


  onErrorCalculate = (error) ->
    $log.error 'puzzle score calculation error: ', error
    $scope.actionOnError error




  getPuzzles()

