'use strict'

###*
 # @ngdoc service
 # @name puzzles.PuzzleWebService
 # @description
 # # PuzzleWebService
 # Factory in the puzzles.
###

angular.module('puzzles').factory 'ScoreWebService', (RequestService) ->

  ScoreWebService = {}


  ScoreWebService.calculateUsersScores = () ->
    RequestService.get null, 'calculateUsersScores'

  ScoreWebService.calculateTabledScores = (puzzleIds) ->
    RequestService.post 'calculateTabledScores', puzzleIds

  ScoreWebService.publishTabledScores = (userScores) ->
    RequestService.post 'tabledUserScores', userScores


  ScoreWebService
