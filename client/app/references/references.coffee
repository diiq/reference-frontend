_ = require 'lodash'
require 'ng-file-upload'

angular.module('references', ['ui.router', 'config', 'tags', 'ngFileUpload', 'deleteBar'])

.config ($stateProvider, $urlRouterProvider) ->
  $stateProvider.state 'reference',
    url: '/reference/:id'
    component: 'referenceView'
    resolve: 
      reference: (ReferenceService, $stateParams) -> 
        ReferenceService.reference($stateParams.id)
        
      tags: (TagService) ->
        TagService.tags()


require './references.service.coffee'
require './referenceThumbnail/referenceThumbnail.component.coffee'
require './referenceUploader/referenceUploader.component.coffee'
require './referenceView/referenceView.component.coffee'
require './earmark/earmark.component.coffee'

