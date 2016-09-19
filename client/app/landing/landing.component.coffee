logoURL = require '../common/logo.svg'
template = require './landing.html'
require './landing.scss'

class landingController
  constructor: () ->
    @logoURL = logoURL

  gotoSignup: ->
    document.getElementById('signup').scrollIntoView()


angular.module('landing').component 'landing',
  restrict: 'E'
  bindings: {}
  template: template
  controller: landingController
