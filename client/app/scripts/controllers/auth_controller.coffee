'use strict';

angular.module 'puzzles'
.controller 'AuthController', ($scope, $state, Auth, $controller) ->
  angular.extend this, $controller 'BaseController', $scope: $scope

  $scope.loginUser = {}
  $scope.newUser = {}

  login_config = {
    headers: {
      'X-HTTP-Method-Override': 'POST'
    }
  }

  $scope.login = () ->
    Auth.login($scope.loginUser, login_config).then(
      () ->
        $state.go('home')
    );


  $scope.register = () ->
    Auth.register($scope.newUser).then(
      () ->
        $state.go('home')
    )
