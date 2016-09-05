template = require './app.html'
require './app.scss'

angular.module('app').component 'app',
  template: template
  restrict: 'E'

