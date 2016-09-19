angular.module('landing', ['users'])

.config ($stateProvider, $urlRouterProvider) ->
  $stateProvider.state 'landing',
    url: '/hello'
    component: 'landing'
    data:
      requiresAuth: false

require './landing.component.coffee'
