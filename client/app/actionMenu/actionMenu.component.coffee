template = require './actionMenu.html'
require './actionMenu.scss'

class actionMenuController
  constructor: (TagService, @$rootScope, @$auth, @$state) ->
    @earmarkState = "home({chosenTags:['#{TagService.earmarkTag.id}']})"
    @state = 'hidden'

  showMenu: ->
    @log 'open'
    @$rootScope.showOverlay = true
    @$rootScope.onOverlayClick = @hideMenu
    @state = 'showEntries'

  hideMenu: =>
    @state = 'hidden'
    @$rootScope.showOverlay = false

  showTagAll: ->
    @log 'open tag all'
    @state = 'tagAll'
    @tagsToAdd = []

  showUntagAll: ->
    @log 'open untag all'
    @state = 'untagAll'
    @tagsToRemove = []

  tagAll: ->
    @log 'tag all'
    if @onTagAll
      @onTagAll(tags: @tagsToAdd)
    @hideMenu()

  untagAll: ->
    @log 'untag all'
    if @onUntagAll
      @onUntagAll(tags: @tagsToRemove)
    @hideMenu()

  logout: ->
    @$auth.signOut()
    @$state.go('login')

  log: (name) ->
    ga 'send',
      hitType: 'event'
      eventCategory: 'action menu'
      eventAction: 'click'
      eventLabel: name

angular.module('actionMenu').component 'actionMenu',
  restrict: 'E'
  bindings:
    onTagAll: '&'
    onUntagAll: '&'
  template: template
  controller: actionMenuController
