template = require './home.html';
require './home.scss';
_ = require 'lodash'

class HomeController
  constructor: ($scope, @$state, @ReferenceService) ->
    @perPage = 36
    @show = @perPage
    $scope.$watch '$ctrl.chosenTags', @resetFilteredReferences, true
    $scope.$watch '$ctrl.references.length', @setFilteredReferences
    document.getElementById('tag-search-input').focus()

  updateURL: ->
    @$state.go('home', {chosenTags: _.map(@chosenTags, 'id')})

  referenceFilter: (reference) =>
    for tag in @chosenTags
      if reference.tagIDs.indexOf(tag.id) == -1
        return false
    return true

  resetFilteredReferences: =>
    @show = @perPage
    @filteredReferences = []
    @setFilteredReferences()

  setFilteredReferences: =>
    @filteredReferences = @allFilteredReferences().slice(0, @show)

  showMore: () ->
    @show += @perPage
    @setFilteredReferences()

  tagAll: (tags) ->
    # TODO: this is v. expensive, yo
    for ref in @allFilteredReferences()
      for tag in tags
        ref.spin = true # TODO: be a counter
        @ReferenceService.addTag(ref, tag).then (newRef) ->
          newRef.spin = false

  untagAll: (tags) ->
    # TODO: this is v. expensive, yo
    for ref in @allFilteredReferences()
      for tag in tags
        ref.spin = true # TODO: be a counter
        @ReferenceService.removeTag(ref, tag).then (newRef) ->
          newRef.spin = false

  allFilteredReferences: ->
    _.filter @references, @referenceFilter

      
angular.module('home').component 'home',
  restrict: 'E'
  bindings:
    references: '='
    tags: '='
    chosenTags: '='
  template: template,
  controller: HomeController


