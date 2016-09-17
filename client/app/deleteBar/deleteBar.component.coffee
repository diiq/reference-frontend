template = require './deleteBar.html'
require './deleteBar.scss'

class deleteBarController
  constructor: () ->

  delete: () ->
    @deleting = false
    if @onDelete
      @onDelete()

angular.module('deleteBar').component 'deleteBar',
  restrict: 'E'
  bindings:
    onDelete: '&'
    deleting: '<'
  template: template
  controller: deleteBarController


