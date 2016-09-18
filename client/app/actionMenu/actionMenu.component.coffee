template = require './actionMenu.html'
require './actionMenu.scss'

class actionMenuController
  constructor: (TagService, @$rootScope) ->
    @earmarkState = "home({chosenTags:['#{TagService.earmarkTag.id}']})"
    @state = 'hidden'
    
  showMenu: ->
    @$rootScope.showOverlay = true
    @$rootScope.onOverlayClick = @hideMenu
    @state = 'showEntries'

  hideMenu: =>
    @state = 'hidden'
    @$rootScope.showOverlay = false

  showTagAll: ->
    @state = 'tagAll'
    @tagsToAdd = []

  showUntagAll: ->
    @state = 'untagAll'
    @tagsToRemove = []

  tagAll: ->
    if @onTagAll
      @onTagAll(tags: @tagsToAdd)
    @hideMenu()

  untagAll: ->
    if @onUntagAll
      @onUntagAll(tags: @tagsToRemove)
    @hideMenu()

angular.module('actionMenu').component 'actionMenu',
  restrict: 'E'
  bindings:
    onTagAll: '&'
    onUntagAll: '&'
  template: template
  controller: actionMenuController


