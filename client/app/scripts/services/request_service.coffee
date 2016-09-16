'use strict'

###*
 # @ngdoc service
 # @name puzzles.RequestService
 # @description
 # # RequestService
 # Factory in the puzzles.
###

angular.module('puzzles').factory 'RequestService', ($http,$resource, $q, $controller, $log, APIUrls) ->
  RequestService = {}
  requestMethods =
    get: 'GET'
    post: 'POST'
    patch: 'PATCH'
    put: 'PUT'
    delete: 'DELETE'

  getConfig = (requestMethod, url, param) ->
    if requestMethod == requestMethods.get
      config =
        method: requestMethod
        url: url
        params: param
    else
      config =
        method: requestMethod
        url: url
        data: param
    config

  callRequest = (requestMethod, params, method, urlExtra) ->
    deferred = $q.defer()
    #var param={params:params}
    url = APIUrls.getUrl(method, urlExtra)
#    $log.info 'url: ', url
#    if requestMethod == requestMethods.post
#      params=Object.removeNullsAndEmpties(params)
#      params = Object.toUnderscoreKeys(params)
#      $log.info 'underscore: ', params

    if params
#      params=Object.removeNullsAndEmpties(params, Object.keys(params))
      params = Object.toUnderscoreKeys(params)

    config = getConfig(requestMethod, url, params)

    $http(config).then ((result) ->
      data = Object.toCamelKeys(result.data)
#      $log.info method, data
      deferred.resolve data
      return
    ), (data) ->
      $log.error method + ' Error: ', data.data
      data = Object.toCamelKeys(data)
      deferred.reject data.data
      return
    deferred.promise

  RequestService.get = (params, method, id) ->
#    $log.info "requestService.get #{params}", params
    callRequest requestMethods.get, params, method, id

  RequestService.post = (method, params, id) ->
    callRequest requestMethods.post, params, method, id

  RequestService.put = (method, params, id) ->
    callRequest requestMethods.put, params, method, id

  RequestService.patch = (method, params, id) ->
    callRequest requestMethods.patch, params, method, id

  RequestService.delete = (method, id) ->
    callRequest requestMethods.delete, null, method, id
#
  RequestService.download = (method, params, urlExtra)->
    deferred = $q.defer()
    #var param={params:params}
    url = APIUrls.getUrl(method, urlExtra)
    #    $log.info 'url: ', url
    #    if requestMethod == requestMethods.post
    #      params=Object.removeNullsAndEmpties(params)
    #      params = Object.toUnderscoreKeys(params)
    #      $log.info 'underscore: ', params

    if params
#      params=Object.removeNullsAndEmpties(params, Object.keys(params))
      params = Object.toUnderscoreKeys(params)

    config = getConfig(requestMethods.get, url, params)
    config['responseType']="arraybuffer"
#    {responseType: "arraybuffer"}

    $http(config).then ((result) ->
      #      $log.info method, data
      deferred.resolve result
      return
    ), (data) ->
      $log.error method + ' Error: ', data
#      data = Object.toCamelKeys(data)
      deferred.reject data
      return
    deferred.promise

  RequestService
