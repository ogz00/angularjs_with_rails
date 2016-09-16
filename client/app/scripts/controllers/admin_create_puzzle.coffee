# Created by Oguzhan on 06/09/16.


'use strict';

angular.module 'puzzles'
.controller 'AdminCreatePuzzleController', ($rootScope, $controller, $modalInstance, $scope, $http, $log, $timeout, PuzzleWebService, puzzle, parent) ->
  angular.extend this, $controller 'BaseController', $scope: $scope

  $scope.parent = parent;

  $timeout(expand, 0);

  $scope.autoExpand = (e) ->
    element = if typeof e == 'object' then e.target else document.getElementById(e)
    scrollHeight = element.scrollHeight -40
    element.style.height =  scrollHeight + "px"

  expand = () ->
    $scope.autoExpand('TextArea')

  currentDate = $scope.getCurrentDate()

  datetime = currentDate.getDate() + "/" + (currentDate.getMonth() + 1)  + "/" + currentDate.getFullYear() + " " + currentDate.getHours() + ":" + currentDate.getMinutes()



  $scope.newPuzzle =
    no:  if puzzle then puzzle.no else parent.puzzles.length + 1
    name: ''
    question: ''
    answer: ''
    year: currentDate.getFullYear()


  if puzzle
    puzzle.publishDate = new Date(puzzle.publishDate)
    $scope.newPuzzle = puzzle
  #"2016-08-03T00:00:00.000+03:00"
  #"14.09.2016 00:01"
  #Wed Sep 14 2016 11:11:00 GMT+0300 (EEST)

  $scope.create = () ->
    $scope.actionState = $scope.actionStates.onAction
    $scope.newPuzzle.publish_date = $scope.dateAsString($scope.newPuzzle.publishDate, true)
    if puzzle
      PuzzleWebService.update($scope.newPuzzle).then(
        (result) ->
          onSuccess $scope.newPuzzle
        (error) ->
          onError error
      )
    else
      PuzzleWebService.create($scope.newPuzzle).then(
        (result) ->
          onSuccess(result)
        (error) ->
          onError(error)
      )


  onSuccess = (puzzle) ->
    $log.info 'create puzzle: ', puzzle
    $scope.actionOnSuccess()
    $modalInstance.close $scope.newPuzzle

  $scope.dismiss = ->
    $modalInstance.dismiss 'cancel'


  onError = (error) ->
    $log.error 'create puzzle Error: ', error
    $scope.actionOnError error
    $scope.dismiss()



