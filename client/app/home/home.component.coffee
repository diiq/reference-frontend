template = require './home.html';
require './home.scss';
_ = require 'lodash'

class HomeController
  constructor: ($scope, @$state) ->
    @filteredReferences = []
    @perPage = 36
    @show = @perPage
    $scope.$watch '$ctrl.chosenTags', @setFilteredReferences, true
    $scope.$watch '$ctrl.references.length', @setFilteredReferences


  updateURL: ->
    @$state.go('home', {chosenTags: _.map(@chosenTags, 'id')})

  referenceFilter: (reference) =>
    for tag in @chosenTags
      if reference.tagIDs.indexOf(tag.id) == -1
        return false
    return true

  setFilteredReferences: =>
    @show = @perPage
    @filteredReferences = []
    @referenceIndex = 0
    @setMoreFilteredReferences()

  setMoreFilteredReferences: =>
    for i in [@referenceIndex...@references.length]
      @referenceIndex = i
      if @filteredReferences.length >= @show
          return

      reference = @references[@referenceIndex]
      if @referenceFilter(reference)
        @filteredReferences.push reference

  showMore: () ->
    @show += @perPage
    console.log(@show)
    @setMoreFilteredReferences()
    
      
angular.module('home').component 'home',
  restrict: 'E'
  bindings:
    references: '='
    tags: '='
    chosenTags: '='
  template: template,
  controller: HomeController


