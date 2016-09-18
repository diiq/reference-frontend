template = require './referenceView.html'
require './referenceView.scss'
_ = require 'lodash'

class referenceViewController
  constructor: (@ReferenceService,
                @TagService,
                $scope,
                @$state,
                @SpinnerService) ->
    $scope.$watch '$ctrl.reference.tagIDs', @setChosenTags, true

  addTag: (tag) ->
    @ReferenceService.addTag(@reference, tag)

  removeTag: (tag) ->
    @ReferenceService.removeTag(@reference, tag)

  toggleEarmark: ->
    if @earmarked()
      @ReferenceService.removeTag(@reference, @TagService.earmarkTag)
    else
      @ReferenceService.addTag(@reference, @TagService.earmarkTag)

  earmarked: ->
    @reference.tagIDs.indexOf(@TagService.earmarkTag.id) != -1

  setChosenTags: =>
    @chosenTags = @TagService.tagsForReference(@reference)

  back: =>
    if @$state.previous.name
      @$state.go(@$state.previous.name, @$state.previous.params)
    else
      @$state.go('home')

  delete: ->
    @SpinnerService.spin("DELETING")
    @ReferenceService.delete(@reference).then @back

angular.module('references').component 'referenceView',
  restrict: 'E'
  bindings:
    reference: "="
    tags: "="
  template: template
  controller: referenceViewController
