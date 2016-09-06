class ReferenceService 
  constructor: (@$http, @$rootScope) ->
    this.url = 'http://localhost:5000/api/v1/references'

  references: () ->
    @$http.get(@url).then (response) => 
      response.data.references

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


