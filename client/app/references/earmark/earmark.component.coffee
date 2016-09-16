template = require './earmark.html'
require './earmark.scss'

class earmarkController
  constructor: () ->

angular.module('references').component 'earmark',
  restrict: 'E'
  bindings:
    marked: '='
  template: template
  controller: earmarkController


