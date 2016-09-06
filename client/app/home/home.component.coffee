template = require './home.html';
require './home.scss';

class HomeController
  constructor: (@ReferenceService, $scope) ->
    $scope.$on 'reference:new', (event, data) =>
      console.log(data, @references.length)
      @references.push(data.reference)
      console.log(@references.length)
    
angular.module('home').component 'home',
  restrict: 'E'
  bindings:
     references: '='
  template: template,
  controller: HomeController


