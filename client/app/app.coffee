require 'angular'
require 'angular-ui-router'

# TODO: better bower integration pls
require '../bower_components/angular-cookie/angular-cookie'
require '../bower_components/ng-token-auth/dist/ng-token-auth'

require './references/references.coffee'
require './home/home.coffee'
require './users/users.coffee'

angular.module('app', [
  'ui.router',
  'home',
  'references',
  'users'
])

.config ($locationProvider) -> 
  $locationProvider.html5Mode(true).hashPrefix('!');

.config ($authProvider) -> 
  $authProvider.configure
    apiUrl: 'http://localhost:5000/api/v1'

.config ($transitionsProvider) ->
  authorizeTransition = (transition) ->
    $auth = transition.injector().get('$auth')
    $state = transition.injector().get('$state')
    $auth.validateUser().catch () ->
      $state.go('login')
      
  $transitionsProvider.onStart({
      to: (state) -> !state.data || state.data.requiresAuth
    }, authorizeTransition)


require './app.component.coffee'
