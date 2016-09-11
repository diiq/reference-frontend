template = require './home.html';
require './home.scss';

class HomeController
  constructor: () ->
    @chosenTags = []

  referenceFilter: (reference) =>
    for tag in @chosenTags
      if reference.tagIDs.indexOf(tag.id) == -1
        return false
    return true
      
angular.module('home').component 'home',
  restrict: 'E'
  bindings:
     references: '='
     tags: '='
  template: template,
  controller: HomeController


