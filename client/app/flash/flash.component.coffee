template = require './flash.html'
require './flash.scss'

class FlashController
  constructor: (@FlashService, $stateParams) ->
    if $stateParams.errorMessage
      @FlashService.flash($stateParams.errorMessage, "error")

  close: ->
    @FlashService.close()

  visible: ->
    @FlashService.visible

  message: ->
    @FlashService.message

  type: ->
    'flash-' + @FlashService.type


angular.module('flash').component 'flash',
  restrict: 'E'
  bindings: {}
  template: template
  controller: FlashController


