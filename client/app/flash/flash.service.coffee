class FlashService
  message: ""
  visible: false
  type: "notice"

  flash: (message, type) ->
    @type = type
    @message = message
    @visible = true

  close: () ->
    @visible = false


angular.module('flash').service 'FlashService', FlashService


