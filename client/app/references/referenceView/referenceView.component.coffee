template = require './referenceView.html'
require './referenceView.scss'

class referenceViewController
  constructor: () ->

angular.module('references').component 'referenceView',
  restrict: 'E'
  bindings:
    reference: "="
  template: template
  controller: referenceViewController


