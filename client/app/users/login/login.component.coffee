template = require './login.html'
logoURL = require '../../common/logo.svg'
require './login.scss'

class LoginController 
  constructor: (@$auth, @$http, @$state, @FlashService) ->
    @logoURL = logoURL
    
  submit: () ->
    success = =>
      @FlashService.close()
      @$state.go 'home'

    failure = (response) =>
      if response.reason == 'unauthorized'
        message = "Sorry, that's not a email and password " +
                  "combination I recognize."
      else
        message = "Sorry, the reference-board.com api is down " +
                  "right now. Please try again in a little while."

      @FlashService.flash(message, "error")

    @$auth.submitLogin
        email: this.email
        password: this.password
    .then success, failure

angular.module('users').component 'login',
  restrict: 'E'
  bindings: {}
  template: template
  controller: LoginController

