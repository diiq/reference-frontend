_ = require 'lodash'
Cache = require '../common/cache.coffee'

class ReferenceService
  constructor: (@$http, @$rootScope, config, @FlashService) ->
    this.url = config.apiBase + '/api/v1/references'
    @cache = new Cache()

  urlFor: (reference) ->
    @url + "/" + reference.id

  references: () ->
    if @cache.stale()
      promise = @$http.get(@url).then (response) =>
        @cache.refresh response.data.references
    if @cache.new()
      promise
    else
      @cache.array

  reference: (id) ->
    reference = @cache.findOrCreate(id)
    if @cache.stale()
      @$http.get(@url + "/#{id}").then (response) ->
        _.assign reference, response.data
        reference
    else
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
      _.assign reference, response.data
      reference
    ,  =>
      @FlashService.flash("Sorry, I couldn't convert that file.", "error")
      @delete(reference)

  delete: (reference) ->
    @$http.delete(@urlFor(reference)).then =>
      @cache.remove(reference.id)

  addTag: (reference, tag) ->
    @$http.post @urlFor(reference) + "/add_tag",
      tag_id: tag.id
    .then (response) =>
      _.assign @cache.find(reference.id), response.data

  removeTag: (reference, tag) ->
    @$http.post @urlFor(reference) + "/remove_tag",
      tag_id: tag.id
    .then (response) =>
      _.assign @cache.find(reference.id), response.data



angular.module('references').service('ReferenceService', ReferenceService)
