# Created by Oguzhan on 06/09/16.


'use strict';

angular.module 'puzzles'
.controller 'AdminCreatePuzzleController', ($rootScope, $controller, $modalInstance, $scope, Upload, $auth, $log, $timeout, PuzzleWebService, puzzle, parent, APIUrls) ->
  angular.extend this, $controller 'BaseController', $scope: $scope

  $scope.parent = parent;
  $scope.puzzleImage=null;
  $timeout(expand, 0);

  $scope.autoExpand = (e) ->
    element = if typeof e == 'object' then e.target else document.getElementById(e)
    element.style.height = "30px";
    element.style.height = (25+element.scrollHeight)+"px"

  expand = () ->
    $scope.autoExpand('question')

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

  $scope.create = () ->
    $scope.setActionState($scope.actionStates.onAction)
    $scope.newPuzzle.publish_date = $scope.dateAsString($scope.newPuzzle.publishDate, true)
    if $scope.puzzleImage?
      createOrUpdateWithImage()
    else
      createWithOutImage()


  createWithOutImage = () ->
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


  createOrUpdateWithImage = ()->
    method = if puzzle then 'PUT' else 'POST'
    url= APIUrls.getUrl 'puzzles'

    if method is 'PUT'
      url+="/#{puzzle.id}"
    puzzle=Object.toUnderscoreKeys($scope.newPuzzle)

    Upload.upload({
      url:url
      method:method
      data: {puzzle: puzzle}
      file: $scope.puzzleImage
      fileFormDataName: 'puzzle[image]'
    }).progress((evt)->
      $log.info 'progress', evt
    ).success(
      (data, status, headers, config) ->
        onSuccess data
    ).error(
      (data, status, headers, config) ->
        onError data
    )


  onSuccess = (puzzle) ->
    $log.info 'create puzzle: ', puzzle
    $scope.actionOnSuccess(true, 'puzzle creation is successfull')
    $modalInstance.close $scope.newPuzzle

  $scope.dismiss = ->
    $modalInstance.dismiss 'cancel'


  onError = (error) ->
    $log.error 'create puzzle Error: ', error
    $scope.actionOnError error
    $scope.dismiss()



