template = require './login.html'
logoURL = require '../../common/logo.svg'
require './login.scss'

class LoginController 
  constructor: (@$auth, @$http, @$state) ->
    @logoURL = logoURL
    
  submit: () ->
    @$auth.submitLogin
        email: this.email
        password: this.password
    .then () =>
      @$state.go 'home'

angular.module('users').component 'login',
  restrict: 'E'
  bindings: {}
  template: template
  controller: LoginController

