template = require './referenceView.html'
require './referenceView.scss'
_ = require 'lodash'

class referenceViewController
  constructor: (@ReferenceService) ->
    
  addTag: (tag) ->
    @ReferenceService.addTag(@reference, tag)

  removeTag: (tag) ->
    @ReferenceService.removeTag(@reference, tag)

    
angular.module('references').component 'referenceView',
  restrict: 'E'
  bindings:
    chosenTags: "="
    reference: "="
    tags: "="
  template: template
  controller: referenceViewController


