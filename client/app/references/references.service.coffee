class ReferenceService 
  constructor: (@$http) ->
    this.url = "http://localhost:5000/api/v1/references"

  references: () ->
    @$http.get(@url).then (response) => 
      response.data.references

  newReference: () ->
    @$http.post @url, 
      reference: { notes: null }
    .then (response) => 
      response.data

  uploadFile: (reference, file) ->
    @$http.put reference.presigned_put, file, 
      headers:
        'If-Modified-Since': undefined

angular.module('references').service('ReferenceService', ReferenceService)


