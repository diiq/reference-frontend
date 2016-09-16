class SpinnerService
  constructor: (@$rootScope) ->

  spin: (message) ->
    @$rootScope.bigSpinnerSpinning = true
    @$rootScope.spinnerMessage = message || "LOADING"

  stop: () ->
    @$rootScope.bigSpinnerSpinning = false


angular.module('spinner').service('SpinnerService', SpinnerService)


