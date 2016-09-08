angular.module('references', ['ui.router', 'config'])

.config ($stateProvider, $urlRouterProvider) ->
  $stateProvider.state 'reference',
    url: '/reference/:id'
    component: 'referenceView'
    resolve: 
      reference: (ReferenceService, $stateParams) -> 
        ReferenceService.reference($stateParams.id)
      

require './references.service.coffee'
require './referenceThumbnail/referenceThumbnail.component.coffee'
require './referenceUploader/referenceUploader.component.coffee'
require './referenceView/referenceView.component.coffee'
