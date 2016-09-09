template = require './referenceThumbnail.html'
require './referenceThumbnail.scss'
spinner = require '../../common/spinner.svg'

class ReferenceThumbnailController
  constructor: (@ReferenceService) ->
    @spinning = false
    @spinnerURL = spinner

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
