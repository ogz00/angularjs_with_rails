'use strict'

###*
 # @ngdoc function
 # @name puzzles.controller:AdminDeleteModalController
 # @description
 # # AdminDeleteModalController
 # Controller of the puzzles
###
angular.module 'puzzles'
.controller 'AdminDeleteModalController', ($scope, $rootScope, $controller, $modalInstance, $log, deleteMethod, modelId) ->
  angular.extend this, $controller 'BaseController', $scope:$scope

  $scope.delete = ->
    $scope.setActionState($scope.actionStates.onAction)
    deleteMethod(modelId).then(
      (result) ->
        $modalInstance.close result
        $scope.showSuccessNotification result
        $scope.setActionState()
      (error) ->
        $scope.showErrorNotification error
        $modalInstance.dismiss()
        $scope.setActionState()
    )

  $scope.dismiss = ->
    $modalInstance.dismiss 'cancel'


