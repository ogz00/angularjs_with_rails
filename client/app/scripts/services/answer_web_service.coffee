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
    RequestService.patch 'answers', answer, answer.id


  AnswerWebService.delete = (id) ->
    RequestService.delete 'answers', id

  AnswerWebService.getAnswers = () ->
    RequestService.get null, 'answers'


  CommentWebService
