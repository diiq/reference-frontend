template = require './taglet.html'
require './taglet.scss'

class tagletController
  constructor: () ->

angular.module('tags').component 'taglet',
  restrict: 'E'
  bindings:
    tag: "="
  template: template
  controller: tagletController


