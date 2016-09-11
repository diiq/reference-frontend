_ = require 'lodash'
Cache = require '../common/cache.coffee'

class TagService 
  constructor: (@$http, config) ->
    this.url = config.apiBase + '/api/v1/tags'
    @cache = new Cache()

  urlFor: (tag) ->
    @url + "/" + tag.id

  tags: () ->
    @$http.get(@url).then (response) =>
      @cache.refresh response.data.tags
    @cache.array

  tag: (id) ->
    tag = @cache.find(id)
    @$http.get(@url + "/#{id}").then (response) -> 
      _.update tag, response.data
    tag

  newTag: (tag) ->
    @$http.post @url, 
      tag: tag
    .then (response) =>
      @cache.add(response.data)

  delete: (tag) ->
    @$http.delete(@urlFor(tag)).then =>
      @cache.remove(tag.id)


      
angular.module('tags').service('TagService', TagService)


