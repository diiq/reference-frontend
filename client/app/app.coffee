require 'angular'
require 'angular-ui-router'
require 'angular-touch'

# TODO: better bower integration pls
require '../bower_components/angular-cookie/angular-cookie'
require '../bower_components/ng-token-auth/dist/ng-token-auth'

require './spinner/spinner.coffee'
require './references/references.coffee'
require './tags/tags.coffee'
require './home/home.coffee'
require './users/users.coffee'
require './flash/flash.coffee'
require './actionMenu/actionMenu.coffee'
require './deleteBar/deleteBar.coffee'

require 'font-awesome/css/font-awesome.css'

angular.module('app', [
  'ui.router'
  'ngTouch'
  'home'
  'references'
  'users'
  'spinner'
  'flash'
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

  hideOverlay = (transition) ->
    rootScope = transition.injector().get('$rootScope')
    rootScope.showOverlay = false

  saveHistory = (transition) ->
    state = transition.injector().get('$state')
    state.previous =
      name: transition.from().name
      params: transition.params('from')

  logChange = (transition) ->
    ga 'send', 'pageview',
      page: transition.to().name


  $transitionsProvider.onStart({}, startSpin);
  $transitionsProvider.onStart({}, saveHistory);
  $transitionsProvider.onSuccess({}, stopSpin);
  $transitionsProvider.onSuccess({}, hideOverlay);
  $transitionsProvider.onSuccess({}, logChange);


.run (SpinnerService) ->
  SpinnerService.spin()

require './app.component.coffee'
require './dragTarget.directive.coffee'
