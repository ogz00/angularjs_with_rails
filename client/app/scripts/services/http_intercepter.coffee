'use strict'

###*
 # @ngdoc service
 # @name zekaOyunlariApp.httpIntercepter
 # @description
 # # httpIntercepter
 # Factory in the zekaOyunlariApp.
###
angular.module('puzzles').factory 'httpInterceptor', ($q, $rootScope, $log) ->
  loadingCount = 0
  {
  request: (config) ->
    if ++loadingCount == 1
      $rootScope.$broadcast 'loading:progress'
    config or $q.when(config)
  response: (response) ->
    if --loadingCount == 0
      $rootScope.$broadcast 'loading:finish'
    response or $q.when(response)
  responseError: (response) ->
    if --loadingCount == 0
      $rootScope.$broadcast 'loading:finish'
    $q.reject response

  }
