template = require './<%= name %>.html'
require './<%= name %>.scss'

class <%= name %>Controller
  constructor: () ->

angular.module('MODULE').component '<%= name %>',
  restrict: 'E'
  bindings: {}
  template: template
  controller: <%= name %>Controller


