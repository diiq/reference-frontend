_ = require 'lodash'

class ReferenceService 
  constructor: (@$http, @$rootScope) ->
    this.url = 'http://localhost:5000/api/v1/references'
    @cache = new ReferenceCache()

  urlFor: (reference) ->
    @url + "/" + reference.id

  references: () ->
    @$http.get(@url).then (response) =>
      @cache.refresh response.data.references
    @cache.array

  reference: (id) ->
    reference = @cache.find(id)
    @$http.get(@url + "/#{id}").then (response) -> 
      _.update reference, response.data
    reference

  newReference: () ->
    @$http.post @url, 
      reference: { notes: null }
    .then (response) =>
      @cache.add(response.data)

  newReferenceFromFile: (file) ->
    @newReference().then (reference) =>
      @$http.put reference.presigned_put, file,
        headers:
          'If-Modified-Since': undefined
      .then =>
        # the default url is the s3 upload url
        @setFromURL(reference)

  newReferenceFromURL: (url) ->
    @newReference().then (reference) =>
      @setFromURL(reference, url)

  setFromURL: (reference, url) ->
    @$http.post @urlFor(reference) + "/set_from_url",
      url: url
    .then (response) =>
      console.log @cache
      reference = @cache.find(reference.id)
      _.merge reference, response.data
      reference

  delete: (reference) ->
    @$http.delete(@urlFor(reference)).then =>
      @cache.remove(reference.id)


class ReferenceCache
  # It's a shared array and a hash, together
  constructor: () ->
    @array = []
    @hash = {}

  find: (id) ->
    @hash[id] || @add({id :id})

  remove: (id) ->
    delete @hash[id]
    _.remove @array, {id: id}

  add: (reference) ->
    @array.push(reference)
    @hash[reference.id] = reference
    reference

  refresh: (references) ->
    @hash = {}
    @array.length = 0
    for reference in references
      @add(reference)
      
angular.module('references').service('ReferenceService', ReferenceService)


