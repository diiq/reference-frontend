template = require './referenceThumbnail.html'
css = require './referenceThumbnail.scss'

class ReferenceThumbnailController
  constructor: () ->

angular.module('references').component 'referenceThumbnail',
  restrict: 'E'
  bindings:
     reference: '='
  template: template
  controller: ReferenceThumbnailController
