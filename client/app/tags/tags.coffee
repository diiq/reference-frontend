angular.module('tags', [])

.config ($stateProvider, $urlRouterProvider) ->
  $stateProvider.state 'tags',
    url: '/tags'
    component: 'tagView'
    resolve:
      tags: (TagService) ->
        TagService.tags()

      references: (ReferenceService) ->
        ReferenceService.references()


require './tag.service.coffee'
require './taglet/taglet.component.coffee'
require './tagSearch/tagSearch.component.coffee'
require './tagView/tagView.component.coffee'
