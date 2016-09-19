'use strict'

###*
 # @ngdoc service
 # @name puzzles.AnswerWebService
 # @description
 # # AnswerWebService
 # Factory in the puzzles.
###

angular.module('puzzles').factory 'CommentWebService', (RequestService) ->

  CommentWebService = {}

  CommentWebService.create = (comment) ->
    RequestService.post 'comments', comment

  CommentWebService.update = (comment) ->
    RequestService.patch 'comments', comment, comment.id


  CommentWebService.delete = (id) ->
    RequestService.delete 'comments', id


  CommentWebService.getCurrent = (params) ->
    RequestService.get params, 'currentComments'

  CommentWebService.getCommentsForAdmin = (params) ->
    RequestService.get params, 'adminComments'

  CommentWebService.getComments = () ->
    RequestService.get null, 'comment'


  CommentWebService
