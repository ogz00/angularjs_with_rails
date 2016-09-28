'use strict'

###*
 # @ngdoc service
 # @name puzzles.VoteWebService
 # @description
 # # VoteWebService
 # Factory in the puzzles.
###

angular.module('puzzles').factory 'VoteWebService', (RequestService) ->

  VoteWebService = {}

  VoteWebService.create = (vote) ->
    RequestService.post 'votes', vote

  VoteWebService.update = (vote) ->
    RequestService.patch 'votes', vote, vote.id


  VoteWebService.delete = (id) ->
    RequestService.delete 'votes', id

  VoteWebService.getVotes = () ->
    RequestService.get null, 'votes'

  VoteWebService.getCurrent = (params) ->
    RequestService.get params, 'currentVotes'

  VoteWebService.getPopularities = () ->
    RequestService.get null, 'getPopularities'


  VoteWebService
