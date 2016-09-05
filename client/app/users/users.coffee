angular.module('users', [
  'ng-token-auth'
])

.config ($stateProvider, $urlRouterProvider) ->
  $stateProvider
    .state 'login',
      url: '/login'
      component: 'login'
      data: 
        requiresAuth: false

require './login/login.component.coffee'

