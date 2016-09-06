template = require './referenceThumbnail.html'
css = require './referenceThumbnail.scss'

class ReferenceThumbnailController
  constructor: () ->
    @url = "https://s3-us-west-2.amazonaws.com/diiq-reference-dev/#{@reference.id}/original"

angular.module('references').component 'referenceThumbnail',
  restrict: 'E'
  bindings:
     reference: '='
  template: template
  controller: ReferenceThumbnailController
