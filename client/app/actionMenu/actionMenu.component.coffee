template = require './actionMenu.html'
require './actionMenu.scss'

class actionMenuController
  constructor: (TagService, @$rootScope) ->
    @earmarkState = "home({chosenTags:['#{TagService.earmarkTag.id}']})"
    @shouldShowMenu = false
    
  showMenu: ->
    @$rootScope.showOverlay = true
    @$rootScope.onOverlayClick = @hideMenu
    @shouldShowMenu = true
    @shouldShowEntries = true
    @shouldShowTagAll = false

  hideMenu: =>
    @shouldShowMenu = false
    @$rootScope.showOverlay = false

  showTagAll: ->
    @shouldShowMenu = true
    @shouldShowEntries = false
    @shouldShowTagAll = true
    @tagsToAdd = []

  tagAll: ->
    if @onTagAll
      @onTagAll(tags: @tagsToAdd)
    @hideMenu()


angular.module('actionMenu').component 'actionMenu',
  restrict: 'E'
  bindings:
    onTagAll: '&'
  template: template
  controller: actionMenuController


