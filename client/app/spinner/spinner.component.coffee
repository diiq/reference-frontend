template = require './spinner.html'
require './spinner.scss'

class spinnerController
  constructor: () ->

angular.module('spinner').component 'spinner',
  restrict: 'E'
  bindings: {}
  template: template
  controller: spinnerController


