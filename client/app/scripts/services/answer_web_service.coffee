'use strict'

###*
 # @ngdoc service
 # @name puzzles.AnswerWebService
 # @description
 # # AnswerWebService
 # Factory in the puzzles.
###

angular.module('puzzles').factory 'AnswerWebService', (RequestService) ->

  AnswerWebService = {}

  AnswerWebService.create = (answer) ->
    RequestService.post 'answers', answer

  AnswerWebService.update = (answer) ->
    RequestService.put 'answers_update', answer, answer.id


  AnswerWebService.delete = (id) ->
    RequestService.delete 'answers', id

  AnswerWebService.getAnswers = () ->
    RequestService.get null, 'answers'

  AnswerWebService.getUserAnswer = (puzzleId) ->
    RequestService.get {puzzle_id:puzzleId}, 'getUserAnswer', puzzleId


  AnswerWebService
