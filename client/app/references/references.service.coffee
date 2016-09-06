_ = require 'lodash'

class ReferenceService 
  constructor: (@$http, @$rootScope) ->
    this.url = 'http://localhost:5000/api/v1/references'
    @cachedReferences = []

  references: () ->
    @$http.get(@url).then (response) =>
      # This looks very silly and non-performant --- but
      # what it does is allow us to display the reference list instantly
      # if we already have one, but refresh it from the server once we
      # get a response.
      @cachedReferences.length = 0
      for reference in  response.data.references
        @cachedReferences.push reference
    @cachedReferences

  reference: (id) ->
    reference = _.find(@cachedReferences, {id: id}) || {}
    @$http.get(@url + "/#{id}").then (response) -> 
      _.update reference, response.data
    reference
      
  newReference: () ->
    @$http.post @url, 
      reference: { notes: null }
    .then (response) => 
      response.data

  newReferenceFromFile: (file) ->
    @newReference().then (reference) =>
      @$http.put reference.presigned_put, file,
        headers:
          'If-Modified-Since': undefined
      .then =>
        # the default url is the s3 upload url
        @setFromURL(reference).then (response) =>
          # Tell everyone to add it to their list of refs
          @$rootScope.$broadcast 'reference:new',
            reference: response.data

  setFromURL: (reference, url) ->
    @$http.post @url + "/#{reference.id}/set_from_url",
      url: url


angular.module('references').service('ReferenceService', ReferenceService)


