'use strict'

###*
 # @ngdoc function
 # @name puzzles.controller:BaseCtrl
 # @description
 # # BaseController
 # Controller of the puzzles
###
angular.module 'puzzles'
.controller 'BaseController', ($rootScope, $scope, $location, Auth, $q, $modal, $log, constants, Notification) ->

  $scope.actionStates = constants.actionStates
  $scope.actionState = constants.actionStates.onIdle
  $scope.formValidations = constants.formValidations
  $scope.signedIn = Auth.isAuthenticated
  $scope.logout = Auth.logout



  Auth.currentUser().then(
    (user) ->
      $scope.user = user
  )

  $scope.$on('devise:new-registration', (e, user) ->
    $scope.user = user
  )

  $scope.$on('devise:login', (e, user) ->
    $scope.user = user
    console.log($scope.user)
  )

  $scope.$on('devise:logout', (e, user) ->
    $scope.user = {}
  )

  $scope.$on('devise:new-session',(event, currentUser) ->
    console.log(currentUser, "user logged in by Auth.login({...})")
  )

  $scope.actionStates=constants.actionStates
  $scope.actionState=constants.actionStates.onIdle

  $scope.formValidations=constants.formValidations

  $scope.setActionState = (state=constants.actionStates.onIdle) ->
    $scope.actionState=state

  $scope.redirect2Root= ->
    $log.info 'redirectToRoot'
    $location.url('/')

  $scope.actionOnStart= () ->
    $scope.setActionState(constants.actionStates.onAction)

  $scope.actionOnSuccess= (shouldNotificationShow=false, message) ->
    $scope.setActionState()
    $scope.showSuccessNotification message if shouldNotificationShow

  $scope.actionOnError= (error) ->
    $scope.setActionState()
    $scope.showErrorNotification(error)

  $scope.showSuccessNotification = (text='Your operation was carried out successfully', duration=5000) ->
    Notification.success
      message: text
      delay: duration
    return

  $scope.showErrorNotification = (error='Unknown error has occurred.', duration=5000) ->

    text=error if typeof error is 'string'

    if error.errorCode
      errorDescription=constants.errorCodes[error.errorCode]
    if errorDescription
      text=errorDescription
    else if error.errorDescription
      text=error.errorDescription

    if  error.data? and error.data.errors?
      text=error.data.errors.full_messages[0]

    Notification.error
      message: text
      delay: duration

    return

  $scope.getCurrentDate= ->
    new Date()

  $scope.dateAsString = (date, shouldWithTime=false) ->

    date=new Date(date)
    $log.info 'date: ', date
    day = date.getDate()
    month = date.getMonth()+1
    year = date.getFullYear()

    if day.toString().length is 1
      day="0#{day}"

    if month.toString().length is 1
      month="0#{month}"


    if shouldWithTime
      hr = date.getHours()

      if hr.toString().length is 1
        hr="0#{hr}"

      min = date.getMinutes()
      if min.toString().length is 1
        $log.info 'length 1', min
        min="0#{min}"
#        hr="00"

      $log.info 'length', min
      $log.info "#{day}.#{month}.#{year} #{hr}:#{min}"
      "#{day}.#{month}.#{year} #{hr}:#{min}"
    else
      "#{day}.#{month}.#{year}"



  $scope.dateOptions =
    startingDay: 1


  $scope.dateFormat = 'dd.MM.yyyy'

  $scope.delete = (modelId, deleteMethod ) ->
    deferred = $q.defer()
    modalInstance=$modal.open
      animation: true
      backdrop: 'static'
      keyboard: false
      templateUrl: 'views/admin_delete_modal.html'
      controller: 'AdminDeleteModalController'
      size: 'md'
      resolve:
        modelId: ->
          modelId
        deleteMethod: ->
          deleteMethod
    modalInstance.result.then(
      () ->
        deferred.resolve()
        return
      () ->
        deferred.reject()
        return
    )
    deferred.promise
