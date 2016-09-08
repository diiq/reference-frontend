template = require './referenceUploader.html'
css = require './referenceUploader.scss'
he = require 'he'

class ReferenceUploaderController
  constructor: (@$scope, @ReferenceService, @$http) ->

   # http://www.webappers.com/2011/09/28/drag-drop-file-upload-with-html5-javascript/
    @dropbox = document.getElementById 'reference-uploader-drop'
    body = document.body
    @dropText = 'Drop files here...'
          
    body.addEventListener 'dragenter', @eventHandler(@dragEnter), false
    @dropbox.addEventListener 'dragenter', @eventHandler(@dragEnter), false
    @dropbox.addEventListener 'dragleave', @eventHandler(@dragLeave), false
    @dropbox.addEventListener 'dragover', @eventHandler(@dragOver), false
    @dropbox.addEventListener 'drop', @eventHandler(@drop), false

  eventHandler: (fn) ->
    (event) =>
      event.stopPropagation()
      event.preventDefault()
      @$scope.$apply ->
        fn(event)
      
  dragEnter: =>
    console.log("enter");
    @dropping = true

  dragLeave: =>
    console.log("leave");
    @dropping = false

  dragOver: (event) =>

  drop: (event) =>
    @dropping = false

    data = event.dataTransfer
    if data.types.indexOf('text/html') != -1
      @transferHTML(data.getData('text/html'))
    else if data.types.indexOf('text/plain') != -1
      @transferURL(data.getData('text/plain'))
    else if data.files.length > 0
      @transferFiles(data.files)
    else
      debugger
      alert("whoopes")

  srcRegex: /src=.([^\'\"]*)/ig
  urlRegex: /^https?:\/\/.*/i

  transferFiles: (files) ->
    for file in event.dataTransfer.files
      @ReferenceService.newReferenceFromFile(file)

  transferHTML: (html) ->
    while(match = @srcRegex.exec(html))
      url = he.decode(match[1])
      @ReferenceService.newReferenceFromURL(url)

  transferURL: (url) ->
    if url.match(@urlRegex)
      @ReferenceService.newReferenceFromURL(url)


angular.module('references').component 'referenceUploader',
  restrict: 'E'
  template: template
  controller: ReferenceUploaderController
