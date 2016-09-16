template = require './actionMenu.html'
require './actionMenu.scss'

class actionMenuController
  constructor: (TagService, @$rootScope) ->
    @earmarkState = "home({chosenTags:['#{TagService.earmarkTag.id}']})"
    @shouldShowMenu = false
    
  showMenu: ->
    @$rootScope.showOverlay = true
    @$rootScope.onOverlayClick = @hideMenu

    # TODO very sloppy use a state var instead pls
    @shouldShowMenu = true
    @shouldShowEntries = true
    @shouldShowTagAll = false
    @shouldShowUntagAll = false

  hideMenu: =>
    @shouldShowMenu = false
    @$rootScope.showOverlay = false

  showTagAll: ->
    @shouldShowMenu = true
    @shouldShowEntries = false
    @shouldShowTagAll = true
    @shouldShowUntagAll = false
    @tagsToAdd = []

  showUntagAll: ->
    @shouldShowMenu = true
    @shouldShowEntries = false
    @shouldShowTagAll = false
    @shouldShowUntagAll = true
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


