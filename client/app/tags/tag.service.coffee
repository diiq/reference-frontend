_ = require 'lodash'
Cache = require '../common/cache.coffee'

class TagService
  constructor: (@$http, config) ->
    this.url = config.apiBase + '/api/v1/tags'
    @cache = new Cache()

  urlFor: (tag) ->
    @url + "/" + tag.id

  tags: () ->
    if @cache.stale()
      @$http.get(@url).then (response) =>
        @cache.refresh response.data.tags
        @creatorTag = response.data.creatorTag
        @earmarkTag = response.data.earmarkTag
        @cache.array
    else
      @cache.array

  tag: (id) ->
    if @cache.stale()
      @tags().then ->
        @cache.find(id)
    else
      @cache.find(id)

  newTag: (tag) ->
    @$http.post @url,
      tag: tag
    .then (response) =>
      @cache.add(response.data)

  delete: (tag) ->
    @$http.delete(@urlFor(tag)).then =>
      @cache.remove(tag.id)

  tagsForReference: (reference) ->
    goodTags = _.filter reference.tagIDs, (id) -> id != @creatorTag
    _.map goodTags, (id) => @tag(id)


angular.module('tags').service('TagService', TagService)
