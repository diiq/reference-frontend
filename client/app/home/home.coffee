require 'ng-infinite-scroll'

angular.module('home', [
  'ui.router',
  'references',
  'tags',
  'infinite-scroll'
])

.config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise('/');

  $stateProvider.state 'home',
    url: '/'
    component: 'home'
    resolve: 
      references: (ReferenceService) -> 
        ReferenceService.references()
        
      tags: (TagService) ->
        TagService.tags()
      
require './home.component.coffee'

