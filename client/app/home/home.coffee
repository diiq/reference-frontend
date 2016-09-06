angular.module('home', [
  'ui.router',
  'references'
])

.config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise('/');

  $stateProvider.state 'home',
    url: '/'
    component: 'home'
    resolve: 
      references: (ReferenceService) -> 
        ReferenceService.references()
      
require './home.component.coffee'

