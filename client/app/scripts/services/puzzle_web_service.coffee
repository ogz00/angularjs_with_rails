'use strict'

###*
 # @ngdoc service
 # @name puzzles.PuzzleWebService
 # @description
 # # PuzzleWebService
 # Factory in the puzzles.
###

angular.module('puzzles').factory 'PuzzleWebService', (RequestService) ->

  PuzzleWebService = {}

  PuzzleWebService.create = (puzzle) ->
    RequestService.post 'puzzles', puzzle

  PuzzleWebService.update = (puzzle) ->
    RequestService.patch 'puzzles', puzzle, puzzle.id


  PuzzleWebService.delete = (id) ->
    RequestService.delete 'puzzles', id


  PuzzleWebService.getCurrent = () ->
    RequestService.get null, 'currentPuzzles'

  PuzzleWebService.getPuzzles = () ->
    RequestService.get null, 'puzzles'


  PuzzleWebService
