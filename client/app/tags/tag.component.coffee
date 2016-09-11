template = require './tag.html'
require './tag.scss'

class tagController
  constructor: () ->

angular.module('MODULE').component 'tag',
  restrict: 'E'
  bindings: {}
  template: template
  controller: tagController


