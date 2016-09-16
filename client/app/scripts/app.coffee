'use strict';

#Created by Oguzhan on 06/ 09 / 16

###*
 # @ngdoc overview
 # @name puzzles
 # @description
 # # puzzles
 #
 # Main module of the application.
###
angular
.module('puzzles', [
  'Devise'
  'ngAnimate'
  'ngAria'
  'ngCookies'
  'ngMessages'
  'ngResource'
  'ngRoute'
  'ngSanitize'
  'ngTouch'
  'ng-token-auth'
  'ui.bootstrap'
  'ui-notification'
  'ngFileUpload'
  'ui.router'
  'LocalStorageModule'
  'angular-spinkit'
  'angular-google-analytics'
])

.config ($locationProvider, $stateProvider, $urlRouterProvider, localStorageServiceProvider, AuthProvider, AuthInterceptProvider) ->

#  Customize login
  #AuthProvider.loginMethod('POST');
  AuthProvider.loginPath('/api/users/sign_in')

  #  Customize logout
  #AuthProvider.logoutMethod('DELETE');
  AuthProvider.logoutPath('/api/users/sign_out')

  # Intercept 401 Unauthorized everywhere
  # Enables `devise:unauthorized` interceptor
  AuthInterceptProvider.interceptAuth(true)


  $urlRouterProvider.otherwise '/'
  #Route and States
  $stateProvider
  .state 'index',
    url: '/'
    templateUrl: 'views/home.html'
    controller: 'HomeController'
  .state 'login',
    url: '/login'
    templateUrl: 'views/_login.html'
    controller: 'AuthController'
    onEnter:
      ($state, Auth) ->
        Auth.currentUser().then(
          ()->
            $state.go('home')
        )
  .state 'register',
    url: '/register',
    templateUrl: 'views/_register.html'
    controller: 'AuthController'
    onEnter:
      ($state, Auth) ->
        Auth.currentUser().then(
          ()->
            $state.go('home')
        )
  .state 'home',
    url: '/home'
    templateUrl: 'views/home.html'
    controller: 'HomeController'
  .state 'rules',
    url: '/rules'
    templateUrl: 'views/rules.html'
    controller: 'RulesController'
  .state 'admin',
    url: '/admin'
    templateUrl: '../views/admin.html'
    controller: 'AdminController'
  .state 'adminPuzzles',
    url: '/admin/puzzles',
    templateUrl: '../views/admin_puzzles.html'
    controller: 'AdminPuzzlesController'
  .state 'adminComments',
    url: '/admin/comments',
    templateUrl: '../views/admin_comments.html'
    controller: 'AdminCommentsController'

  localStorageServiceProvider.setPrefix 'puzzles'

  return



