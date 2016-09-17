template = require './tagView.html'
require './tagView.scss'
_ = require 'lodash'


class TagViewController
  constructor: (@$state, @TagService) ->

  refCount: (tag) ->
    refs = _.filter @references, (ref) -> ref.tagIDs.indexOf(tag.id) != -1
    refs.length

  back: ->
    if @$state.previous.name
      @$state.go(@$state.previous.name, @$state.previous.params)
    else
      @$state.go('home')

  delete: (tag) ->
    @TagService.delete(tag)


angular.module('tags').component 'tagView',
  restrict: 'E'
  bindings:
    tags: '='
    references: '='
  template: template
  controller: TagViewController


