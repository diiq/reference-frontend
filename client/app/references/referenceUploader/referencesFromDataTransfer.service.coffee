he = require 'he'
_ = require 'lodash'


class ReferencesFromDataTransfer
  constructor: (@ReferenceService, @$q) ->

  files: (data) ->
    data.files

  transferFiles: (files, tags) ->
    promises = _.map files, (file) =>
      @ReferenceService.newReferenceFromFile(file, tag_ids: tags)
    if promises.length
      @$q.all(promises)


  html: (data) ->
    data.getData('text/html')

  srcRegex: /src=.([^\'\"]*)/i

  transferHTML: (html, tags) ->
    match = html.match(@srcRegex)
    if match
      url = he.decode(match[1])
      @ReferenceService.newReferenceFromURL(url, tag_ids: tags)

  url: (data) ->
    data.getData('text/plain')

  urlRegex: /^https?:\/\/.*/i

  transferURL: (url, tags) ->
    if url.match(@urlRegex)
      @ReferenceService.newReferenceFromURL(url, tag_ids: tags)

  references: (dataTransfer, tags) ->
    @transferHTML(@html(dataTransfer), tags) ||
    @transferURL(@url(dataTransfer), tags) ||
    @transferFiles(@files(dataTransfer), tags)

angular.module('references').service 'ReferencesFromDataTransfer', ReferencesFromDataTransfer
