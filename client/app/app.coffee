require 'angular'
require 'angular-ui-router'

# TODO: better bower integration pls
require '../bower_components/angular-cookie/angular-cookie'
require '../bower_components/ng-token-auth/dist/ng-token-auth'

require './spinner/spinner.coffee'
require './references/references.coffee'
require './tags/tags.coffee'
require './home/home.coffee'
require './users/users.coffee'
require './actionMenu/actionMenu.coffee'

require 'font-awesome/css/font-awesome.css'

angular.module('app', [
  'ui.router'
  'home'
  'references'
  'users'
  'spinner'
])

.config ($locationProvider) -> 
  $locationProvider.hashPrefix('!')

.config ($authProvider, config) -> 
  $authProvider.configure
    apiUrl: config.apiBase + '/api/v1'

.config ($transitionsProvider) ->
  authorizeTransition = (transition) ->
    $auth = transition.injector().get('$auth')
    $state = transition.injector().get('$state')
    $auth.validateUser().catch () ->
      $state.go('login')
      
  $transitionsProvider.onStart({
      to: (state) -> !state.data || state.data.requiresAuth
    }, authorizeTransition)

  startSpin = (transition) ->
    spinner = transition.injector().get('SpinnerService')
    spinner.spin()

  stopSpin = (transition) ->
    spinner = transition.injector().get('SpinnerService')
    spinner.stop()
      
  $transitionsProvider.onStart({}, startSpin);
  $transitionsProvider.onSuccess({}, stopSpin);

.run (SpinnerService) ->
  SpinnerService.spin()
  
require './app.component.coffee'
