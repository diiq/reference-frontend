require '../references.coffee'

describe "referenceUploader", ->
  beforeEach(window.module('references'))

  beforeEach inject (@$rootScope, @$componentController) ->

  describe "Controller", -> 
    beforeEach ->
      @controller = @$componentController 'referenceUploader', 
        $scope: @$rootScope.$new()

    describe "dragEnter", ->
      it "Activates the dropping state", ->
        @controller.dropping = false
        @controller.dragEnter()
        expect(@controller.dropping).toBe(true)

    describe "dragLeave", ->
      it "Deactivates the dropping state", ->
        @controller.dropping = true
        @controller.dragLeave()
        expect(@controller.dropping).toBe(false)

    describe "files", ->
      it "extracts files from the dataTransfer", ->
        files = [1, 2, 3]
        dataTransfer = { files: files }
        expect(@controller.files(dataTransfer)).toBe(files)

    describe "transferFiles", ->
      it "returns falsy if there are no files", ->
        files = []
        expect(@controller.transferFiles(files)).toBeFalsy()

      it "calls ReferenceService for each file", ->
        files = [1, 2, 3]
        refService = @controller.ReferenceService
        spyOn(refService, 'newReferenceFromFile')
        @controller.transferFiles(files)
        expect(refService.newReferenceFromFile.calls.count()).toBe(3)

    describe "srcRegex", ->
      it "matches urls that are image srcs", ->
        image = "<img src='http://goo/bar/ban.jpg'>"
        notImage = "squggly giggle oode bar stanke"
        match = image.match(@controller.srcRegex)
        expect(match).toBeTruthy
        expect(match[1]).toBe 'http://goo/bar/ban.jpg'
        expect(notImage.match(@controller.srcRegex)).toBeFalsy()

    describe "transferHTML", ->
      it "returns falsy if there are no urls", ->
        html = ""
        expect(@controller.transferHTML(html)).toBeFalsy()

      it "calls ReferenceService with the source URL", ->
        html = "<img src='http://goo/bar/ban.jpg'>"
        refService = @controller.ReferenceService
        spyOn(refService, 'newReferenceFromURL')
        @controller.transferHTML(html)
        expect(refService.newReferenceFromURL)
          .toHaveBeenCalledWith('http://goo/bar/ban.jpg')

    describe "urlRegex", ->
      it "matches urls", ->
        url = "http://goo/bar/ban.jpg"
        notURL = "squggly giggle oode bar stanke"
        expect(url.match(@controller.urlRegex)).toBeTruthy()
        expect(notURL.match(@controller.urlRegex)).toBeFalsy()

    describe "transferURL", ->
      it "returns falsy if there are no urls", ->
        url = ""
        expect(@controller.transferURL(url)).toBeFalsy()

      it "calls ReferenceService with the source URL", ->
        url = 'http://goo/bar/ban.jpg'
        refService = @controller.ReferenceService
        spyOn(refService, 'newReferenceFromURL')
        @controller.transferURL(url)
        expect(refService.newReferenceFromURL)
          .toHaveBeenCalledWith('http://goo/bar/ban.jpg')


    describe "eventHandler", ->
      it "turns a function into an event handler", ->
        fn = jasmine.createSpy('handler');
        event = jasmine.createSpyObj('event', ['stopPropagation', 'preventDefault']);
        handler = @controller.eventHandler(fn)
        handler(event)
        expect(event.stopPropagation).toHaveBeenCalled()
        expect(event.preventDefault).toHaveBeenCalled()
        expect(fn).toHaveBeenCalled()
