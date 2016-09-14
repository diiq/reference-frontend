template = require './referenceUploader.html'
css = require './referenceUploader.scss'
he = require 'he'
_ = require 'lodash'

class ReferenceUploaderController
  constructor: (@$scope, @ReferenceService, @$http) ->
    @dropping = 0

    document.body.addEventListener 'dragenter', @eventHandler(@dragEnter), false
    document.body.addEventListener 'dragleave', @eventHandler(@dragLeave), false
      
    taggedDrop = document.getElementById 'reference-uploader-drop-tagged'
    untaggedDrop = document.getElementById 'reference-uploader-drop-untagged'
    overlay = document.getElementById 'reference-uploader-overlay'
    # These ifs are here for tests; that's the only time they'll be falsy.
    # TODO: write a directive for these listeners.
    if taggedDrop
      taggedDrop.addEventListener 'dragover', @eventHandler(@dragOver), false
      taggedDrop.addEventListener 'drop', @eventHandler(@dropTagged), false
      taggedDrop.addEventListener 'dragenter', @eventHandler(@dragEnter), false
      taggedDrop.addEventListener 'dragleave', @eventHandler(@dragLeave), false

    if untaggedDrop
      untaggedDrop.addEventListener 'dragover', @eventHandler(@dragOver), false
      untaggedDrop.addEventListener 'drop', @eventHandler(@dropUntagged), false
      untaggedDrop.addEventListener 'dragenter', @eventHandler(@dragEnter), false
      untaggedDrop.addEventListener 'dragleave', @eventHandler(@dragLeave), false

  dragEnter: =>
    @dropping += 1

  dragLeave: =>
    @dropping = Math.max(@dropping - 1, 0)

  dragOver: (event) =>
    # This looks silly, but we need an event handler here to stop
    # propogation so that the drag-n-drop will behave.

  dropTagged: (event) =>
    @uploadTags = _.map(@chosenTags, 'id')
    @drop(event)

  dropUntagged: (event) =>
    @uploadTags = []
    @drop(event)
    
  drop: (event) =>
    @dropping = false
    
    data = event.dataTransfer
    unless (@transferHTML(@html(data)) ||
            @transferURL(@url(data)) ||
            @transferFiles(@files(data)))
      alert("whoopes")

  manualUpload: (files) ->
    @uploadTags = _.map(@chosenTags, 'id')
    @transferFiles(files)

  files: (data) ->
    data.files
  
  transferFiles: (files) ->
    for file in files
      @ReferenceService.newReferenceFromFile(file, tag_ids: @uploadTags)
    files.length
      
  html: (data) ->
    data.getData('text/html')

  srcRegex: /src=.([^\'\"]*)/i
  
  transferHTML: (html) ->
    match = html.match(@srcRegex)
    if match
      url = he.decode(match[1])
      @ReferenceService.newReferenceFromURL(url, tag_ids: @uploadTags)
      true

  url: (data) ->
    data.getData('text/plain')

  urlRegex: /^https?:\/\/.*/i

  transferURL: (url) ->
    if url.match(@urlRegex)
      @ReferenceService.newReferenceFromURL(url, tag_ids: @uploadTags)
      true
      
  eventHandler: (fn) ->
    (event) =>
      event.stopPropagation()
      event.preventDefault()
      @$scope.$apply ->
        fn(event)


angular.module('references').component 'referenceUploader',
  restrict: 'E'
  template: template
  bindings:
    chosenTags: '='
  controller: ReferenceUploaderController

