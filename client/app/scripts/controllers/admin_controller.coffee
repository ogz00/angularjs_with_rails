'use strict'

###*
 # @ngdoc function
 # @name puzzles.controller:AdminController
 # @description
 # # AdminController
 # Controller of the puzzles
###
angular.module 'puzzles'
.controller 'AdminController', ($scope, $q, $log, $controller, $location, $state, $modal, PuzzleWebService) ->

  angular.extend this, $controller 'BaseController', $scope:$scope



