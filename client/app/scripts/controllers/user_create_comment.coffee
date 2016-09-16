# Created by Oguzhan on 06/09/16.


'use strict';

angular.module 'puzzles'
.controller 'UserCreateCommentController', ($rootScope, $controller, $modalInstance, $scope, $http, $log, $timeout, CommentWebService, puzzle, parent, VoteWebService) ->
  angular.extend this, $controller 'BaseController', $scope: $scope

  $scope.puzzle = puzzle;

  $scope.parent = parent;

  $scope.newComment =
    subject: ''
    message: ''
    puzzleId: puzzle.id

  $scope.newVote =
    popularity: ''
    difficulty: ''
    puzzleId: puzzle.id

  $scope.create = () ->
    $scope.newVote.popularity = parseInt($scope.newComment.popularity)
    $scope.newVote.difficulty = parseInt($scope.newComment.difficulty)
    $scope.actionState = $scope.actionStates.onAction
    if puzzle
      CommentWebService.create($scope.newComment).then(
        (result) ->
          VoteWebService.create($scope.newVote).then(
            (result) ->
              onSuccess $scope.newVote
            (error) ->
              onError error
          )
        (error) ->
          onError error
      )
    else
      CommentWebService.createTop($scope.newComment).then(
        (result) ->
          onSuccess(result)
        (error) ->
          onError(error)
      )


  onSuccess = (comment) ->
    $log.info 'create comment: ', comment
    $scope.actionOnSuccess()
    $modalInstance.close $scope.newComment

  $scope.dismiss = ->
    $modalInstance.dismiss 'cancel'


  onError = (error) ->
    $log.error 'create comment Error: ', error
    $scope.actionOnError error
    $scope.dismiss()

