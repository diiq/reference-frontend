require 'ng-infinite-scroll'
_ = require 'lodash'

angular.module('home', [
  'ui.router',
  'references',
  'tags',
  'infinite-scroll'
])

.config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise('/');

  $stateProvider.state 'home',
    url: '/?chosenTags',
    params: { chosenTags: { dynamic: true, value: [] } },
    component: 'home'
    resolve: 
      references: (ReferenceService) -> 
        ReferenceService.references()
        
      tags: (TagService) ->
        TagService.tags()

      chosenTags: (tags, TagService, $stateParams) ->
        tagIDs = _.castArray($stateParams.chosenTags)
        console.log(tagIDs)
        _.map tagIDs, (id) -> TagService.tag(id)
        
      
require './home.component.coffee'

