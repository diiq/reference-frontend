_ = require 'lodash'
Cache = require '../common/cache.coffee'

class ReferenceService 
  constructor: (@$http, @$rootScope, config) ->
    this.url = config.apiBase + '/api/v1/references'
    @cache = new Cache()

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

  newReference: (ref) ->
    @$http.post @url, 
      reference: ref || {}
    .then (response) =>
      @cache.add(response.data)

  newReferenceFromFile: (file, ref) ->
    @newReference(ref).then (reference) =>
      @$http.put reference.presigned_put, file,
        headers:
          'If-Modified-Since': undefined
      .then =>
        # the default url is the s3 upload url
        @setFromURL(reference)

  newReferenceFromURL: (url, ref) ->
    @newReference(ref).then (reference) =>
      @setFromURL(reference, url)

  setFromURL: (reference, url) ->
    @$http.post @urlFor(reference) + "/set_from_url",
      url: url
    .then (response) =>
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


