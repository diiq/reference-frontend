template = require './tagSearch.html'

require './tagSearch.scss'
_ = require 'lodash'

class tagSearchController
  constructor: (@TagService, @$filter) ->

  getSuggestedTags: () ->
    results = @$filter('filter')(@tags, {name: @tagInput}, false)
    results = results.slice(0, 10)
    results.push({name: "New tag: #{@tagInput}", id: -1})
    @suggestedTags = results
    @highlightedTag = 0
    @removableTag = -1

  manageKeys: ($event) ->
    if $event.keyCode == 38
        @highlightPrevious()
    else if $event.keyCode == 40
        @highlightNext()
    else if $event.keyCode == 13
        @select()
    else if $event.keyCode == 8
        @maybeRemoveTag()
        
  highlightNext: () ->
    @highlightedTag = Math.min(@highlightedTag + 1, @suggestedTags.length - 1)

  highlightPrevious: () ->
    @highlightedTag = Math.max(@highlightedTag - 1, 0)

  select: () ->
    tag = @suggestedTags[@highlightedTag]
    if tag.id != -1
      @chosenTags.push(tag)
    else
      @TagService.newTag({name: @tagInput}).then (tag) =>
        @chosenTags.push(tag)
    @tagInput = ""

  maybeRemoveTag: () ->
    # If they're typing, do nothing.
    if @tagInput
      return

    # If they're not typing, and there are tage, select the last one.
    else if @removableTag == -1 && @chosenTags.length
      @removableTag = @chosenTags.length - 1

    # If a tag is already selected, remove it. 
    else if @removableTag >= 0
      @removeTag()
      @removableTag = Math.min(@removableTag, @chosenTags.length - 1)
        
  removeTag: () ->
    @chosenTags.splice(@removableTag, 1);

angular.module('tags').component 'tagSearch',
  restrict: 'E'
  bindings: 
    tags: '='
    chosenTags: '='
  template: template
  controller: tagSearchController

