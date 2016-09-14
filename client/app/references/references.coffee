_ = require 'lodash'
require 'ng-file-upload'

angular.module('references', ['ui.router', 'config', 'tags', 'ngFileUpload'])

.config ($stateProvider, $urlRouterProvider) ->
  $stateProvider.state 'reference',
    url: '/reference/:id'
    component: 'referenceView'
    resolve: 
      reference: (ReferenceService, $stateParams) -> 
        ReferenceService.reference($stateParams.id)
        
      tags: (TagService) ->
        TagService.tags()
        
      chosenTags: (TagService, reference, tags) ->
        _.map reference.tagIDs, (id) -> TagService.tag(id) 
      

require './references.service.coffee'
require './referenceThumbnail/referenceThumbnail.component.coffee'
require './referenceUploader/referenceUploader.component.coffee'
require './referenceView/referenceView.component.coffee'
