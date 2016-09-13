template = require './referenceThumbnail.html'
require './referenceThumbnail.scss'
spinner = require '../../common/spinner.svg'

class ReferenceThumbnailController
  constructor: (@ReferenceService, @TagService) ->
    @spinning = false
    @spinnerURL = spinner

  delete: ->
    @spinning = true
    @ReferenceService.delete(@reference)

  toggleEarmark: ->
    if @earmarked()
      @ReferenceService.removeTag(@reference, @TagService.earmarkTag)
    else
      @ReferenceService.addTag(@reference, @TagService.earmarkTag)

  earmarked: ->
    @reference.tagIDs.indexOf(@TagService.earmarkTag.id) != -1

angular.module('references').component 'referenceThumbnail',
  restrict: 'E'
  bindings:
     reference: '='
  template: template
  controller: ReferenceThumbnailController
