template = require './referenceUploader.html'
css = require './referenceUploader.scss'
_ = require 'lodash'

class ReferenceUploaderController
  constructor: (@$scope, @ReferenceService, @$http, @FlashService, @ReferencesFromDataTransfer) ->
    @dropping = 0

  $onInit: ->
    @bodyEnter = @eventHandler(@dragEnter)
    @bodyLeave = @eventHandler(@dragLeave)
    document.body.addEventListener 'dragenter', @bodyEnter, false
    document.body.addEventListener 'dragleave', @bodyLeave, false
    window.onbeforeunload = @pageLeave

  $onDestroy: ->
    document.body.removeEventListener 'dragenter', @bodyEnter
    document.body.removeEventListener 'dragleave', @bodyLeave
    window.onbeforeunload = null

  dragEnter: =>
    @dropping += 1

  dragLeave: (event) =>
    @dropping = Math.max(@dropping - 1, 0)
    event.target.classList.remove('dragover')

  dragOver: (event) =>
    event.target.classList.add('dragover')
    # This looks silly, but we need an event handler here to stop
    # propogation so that the drag-n-drop will behave.

  dropTagged: (event) =>
    event.target.classList.remove('dragover')
    @uploadTags = _.map(@chosenTags, 'id')
    @drop(event)

  dropUntagged: (event) =>
    event.target.classList.remove('dragover')
    @uploadTags = []
    @drop(event)

  drop: (event) =>
    @dropping = false
    @uploading = true

    data = event.dataTransfer
    promise = @ReferencesFromDataTransfer.references(data, @uploadTags)
    if !promise
      @FlashService.flash("Sorry, I don't know how to upload that!", "error")
    promise.then =>
      @uploading = false

  manualUpload: (files) ->
    @uploadTags = _.map(@chosenTags, 'id')
    @transferFiles(files)

  eventHandler: (fn) ->
    (event) =>
      event.stopPropagation()
      event.preventDefault()
      @$scope.$apply ->
        fn(event)

  pageLeave: (event) =>
    if !@uploading
      return undefined

    message = 'Files are still uploading. ' +
              'If you leave now, they will be lost.'

    (event || window.event).returnValue = message; #Gecko + IE
    return message;

angular.module('references').component 'referenceUploader',
  restrict: 'E'
  template: template
  bindings:
    chosenTags: '='
    showButton: '<'
  controller: ReferenceUploaderController
