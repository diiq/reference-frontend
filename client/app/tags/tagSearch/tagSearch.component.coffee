_ = require 'lodash'

Match = require './match.coffee'

template = require './tagSearch.html'
require './tagSearch.scss'


class tagSearchController
  constructor: (@TagService, @$filter) ->
    @tags = @TagService.tags()
    @highlightedTag = 0
    @removableTag = -1

  getSuggestedTags: () ->
    if @tagInput
      results = Match.search(@tagInput, @tags, 'name')
      if results[0]?.name != @tagInput
        results.push {name: "New tag: #{@tagInput}", id: -1}
    else
      results = []
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
        
    if @tagAdded then @tagAdded(tag: tag)

  maybeRemoveTag: () ->
    # If they're typing, do nothing.
    if @tagInput
      return

    # If they're not typing, and there are tage, select the last one.
    else if @removableTag == -1 && @chosenTags.length
      @removableTag = @chosenTags.length - 1

    # If a tag is already selected, remove it. 
    else if @removableTag >= 0
      @removeTag(@removableTag)
      @removableTag = Math.min(@removableTag, @chosenTags.length - 1)
        
  removeTag: (index) ->
    tag = @chosenTags[index]
    @chosenTags.splice(index, 1)
    if @tagRemoved then @tagRemoved(tag: tag)
    
angular.module('tags').component 'tagSearch',
  restrict: 'E'
  bindings: 
    chosenTags: '='
    tagAdded: '&'
    tagRemoved: '&'
  template: template
  controller: tagSearchController


