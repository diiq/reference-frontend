template = require './referenceThumbnail.html'
css = require './referenceThumbnail.scss'

class ReferenceThumbnailController
  constructor: (@ReferenceService) ->
    @url = "https://s3-us-west-2.amazonaws.com/diiq-reference-dev/#{@reference.id}/original"
    @spinning = false

  delete: () ->
    @spinning = true
    @unhover()
    @ReferenceService.delete(@reference)

  hover: () ->
    @hovering = true

  unhover: () ->
    @hovering = false
    @deleting = false

angular.module('references').component 'referenceThumbnail',
  restrict: 'E'
  bindings:
     reference: '='
  template: template
  controller: ReferenceThumbnailController
