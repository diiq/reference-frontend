require 'ng-infinite-scroll'
_ = require 'lodash'

angular.module('home', [
  'ui.router'
  'references'
  'tags'
  'infinite-scroll'
  'actionMenu'
])

.config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise('/');

  $stateProvider.state 'home',
    url: '/?chosenTags',
    params:
      chosenTags:
        value: []
    component: 'home'
    resolve:
      references: (ReferenceService) ->
        ReferenceService.references()

      tags: (TagService) ->
        TagService.tags()

      chosenTags: (tags, TagService, $stateParams) ->
        tagIDs = _.castArray($stateParams.chosenTags)
        _.compact _.map tagIDs, (id) -> TagService.tag(id)


require './home.component.coffee'
