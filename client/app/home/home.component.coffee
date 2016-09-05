template = require './home.html';

class HomeController
  constructor: (@ReferenceService) ->
    
  newRef: () ->
    @ReferenceService.newReference().then(
      (ref) => @references.push(ref)
    )

  upload: (reference) ->
    @ReferenceService.uploadFile(reference, @file)

angular.module('home').component 'home',
  restrict: 'E'
  bindings:
     references: '='
  template: template,
  controller: HomeController


