require '../references.coffee'

describe "referenceThumbnail", ->
  beforeEach(window.module('references'))

  beforeEach inject (
    @$rootScope,
    @$componentController,
    @$compile,
    ) ->

  describe "Controller", -> 
    beforeEach ->
      @reference = {}
      @controller = @$componentController 'referenceThumbnail', 
        $scope: @$rootScope.$new()
      @controller.reference = @reference
        
    describe "constructor", ->
      it "sets the spin state variables", ->
        expect(@controller.spinning).toBe(false)

    describe "delete", ->
      beforeEach ->
        spyOn(@controller.ReferenceService, 'delete')
        
      it "Activates the spin state", ->
        @controller.spinning = false
        @controller.delete()
        expect(@controller.spinning).toBe(true)

      it "Deactivates the hover state", ->
        @controller.hovering = true
        @controller.delete()
        expect(@controller.hovering).toBe(false)

      it "Calls ReferenceService's delete", ->
        @controller.delete()
        expect(@controller.ReferenceService.delete)
         .toHaveBeenCalledWith(@reference)
         
    describe "hover", ->
      it "Activates the hover state", ->
        @controller.hovering = false
        @controller.hover()
        expect(@controller.hovering).toBe(true)

    describe "unhover", ->
      it "Deactivates the hover state", ->
        @controller.hovering = true
        @controller.unhover()
        expect(@controller.hovering).toBe(false)

      it "Deactivates the deleting state", ->
        @controller.deleting = true
        @controller.unhover()
        expect(@controller.deleting).toBe(false)
