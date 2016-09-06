template = require './referenceUploader.html'
css = require './referenceUploader.scss'

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
    console.log("over");
    ok = (event.dataTransfer &&
          event.dataTransfer.types &&
          event.dataTransfer.types.indexOf('Files') >= 0)
    @dropClass = ok ? 'over' : 'not-available'

  drop: (event) =>
    console.log 'drop evt:', JSON.parse(JSON.stringify(event.dataTransfer))
    @dropText = 'Drop files here...'
    @dropClass = ''

    for file in event.dataTransfer.files
      @ReferenceService.newReferenceFromFile(file)

    @dropping = false
        
  uploadProgress: (event) =>
    @$scope.$apply =>
      if (event.lengthComputable) 
        @progress = Math.round(event.loaded * 100 / event.total)
      else 
        @progress = 'unable to compute'

  uploadComplete: (event) =>
    @$scope.$apply =>
      @progressVisible = false
      
    alert(event.target.responseText)

  uploadFailed: (event) =>
    @$scope.$apply =>
      @progressVisible = false
        
    alert("There was an error attempting to upload the file.")

  uploadCanceled: (event) =>
    @$scope.$apply =>
      @progressVisible = false

    alert("The upload has been canceled by the user or the browser dropped the connection.")




angular.module('references').component 'referenceUploader',
  restrict: 'E'
  template: template
  controller: ReferenceUploaderController
