template = require './signup.html'
logoURL = require '../../common/logo.svg'
require './signup.scss'

class signupController
  constructor: (@$auth, @$http, @$state, @FlashService) ->
    @logoURL = logoURL

  submit: () ->
    success = =>
      @FlashService.close()
      @$state.go 'home'

    failure = (response) =>
      message = response?.data?.errors?.full_messages?[0] ||
        "Sorry, the reference-board.com api is down " +
        "right now. Please try again in a little while."

      @FlashService.flash(message, "error")

    @$auth.submitRegistration
        email: this.email
        password: this.password
    .then success, failure

angular.module('users').component 'signup',
  restrict: 'E'
  bindings: {}
  template: template
  controller: signupController
