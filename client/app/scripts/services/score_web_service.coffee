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


  ScoreWebService.calculateUsersCurrentScores = () ->
    RequestService.get null, 'calculateUserScores'


  ScoreWebService
