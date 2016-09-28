'use strict'

###*
 # @ngdoc service
 # @name zekaOyunlariApp.APIUrls
 # @description
 # # APIUrls
 # Provider in the zekaOyunlariApp.
###

angular.module('puzzles').provider 'APIUrls', ->
  hostname = ''
  port = ''
  urls =
    puzzles: 'puzzles'
    comments: 'comments'
    votes: 'votes'
    getPopularities : 'votes/getPopularities'
    answers: 'answers'
    tabledUserScores: 'tabled_user_scores'
    answersUpdate: 'answers/update'
    puzzlesUpdate: 'puzzles/update'
    currentPuzzles: 'puzzles/current'
    currentComments: 'comments/current'
    adminComments: 'comments/admin'
    currentVotes: 'votes/current'
    calculatePuzzleScore: 'puzzles/calculate'
    calculateAllPuzzleScore: 'puzzles/calculateAll'
    getUserAnswer: 'answers/getUserAnswer'
    calculateUsersScores: 'user_scores/calculateScores'
    calculateTabledScores: 'user_scores/calculateTabledScores'
  # Private constructor

  APIUrls = ->
    @hostname = hostname
    @port = port
    @urls = urls

    @getUrl = (key, arg) ->
      console.log 'hostName: ', @hostname
      console.log 'hostName: ', hostname
      url = @urls[key]
      argsArray = undefined
      # allow the user to use a function which generates the url depending on some params
      if angular.isFunction(url)
        argsArray = Array::slice.call(arguments)
        argsArray.splice 0, 1
        url = url.apply(null, argsArray)
      #var result= location.protocol + "//" + this.hostname+':'+this.port + '/api/' + url;
      result = hostname+'/api/' + url
      if arg
        result += '/' + arg
#      result += '.json'
      console.log 'api url: ', result
      result

    return

  @setHostname = (name) ->
    hostname = name
    return

  @setPort = (portNumber) ->
    port = portNumber
    return

  # Method for instantiating

  @$get = ->
    new APIUrls

  return
