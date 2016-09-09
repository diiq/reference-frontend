template = require './referenceUploader.html'
css = require './referenceUploader.scss'
he = require 'he'

class ReferenceUploaderController
  constructor: (@$scope, @ReferenceService, @$http) ->
    document.body.addEventListener 'dragenter', @eventHandler(@dragEnter), false

    dropbox = document.getElementById 'reference-uploader-drop'
    if dropbox
      dropbox.addEventListener 'dragleave', @eventHandler(@dragLeave), false
      dropbox.addEventListener 'dragover', @eventHandler(@dragOver), false
      dropbox.addEventListener 'drop', @eventHandler(@drop), false
      
  dragEnter: =>
    @dropping = true

  dragLeave: =>
    @dropping = false

  dragOver: (event) =>
    # This looks silly, but we need an event handler here to stop
    # propogation so that the drag-n-drop will behave.
    
  drop: (event) =>
    @dropping = false
    
    data = event.dataTransfer
    unless (@transferHTML(@html(data)) ||
            @transferURL(@url(data)) ||
            @transferFiles(@files(data)))
      alert("whoopes")

  files: (data) ->
    data.files
  
  transferFiles: (files) ->
    for file in files
      @ReferenceService.newReferenceFromFile(file)
    files.length
      
  html: (data) ->
    data.getData('text/html')

  srcRegex: /src=.([^\'\"]*)/i
  
  transferHTML: (html) ->
    match = html.match(@srcRegex)
    if match
      url = he.decode(match[1])
      @ReferenceService.newReferenceFromURL(url)
      true

  url: (data) ->
    data.getData('text/plain')

  urlRegex: /^https?:\/\/.*/i

  transferURL: (url) ->
    if url.match(@urlRegex)
      @ReferenceService.newReferenceFromURL(url)
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
  controller: ReferenceUploaderController

