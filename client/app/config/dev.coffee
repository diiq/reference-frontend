require './dev/tracking.coffee'

angular.module('config', []).constant "config",
  apiBase: "http://localhost:5000"
