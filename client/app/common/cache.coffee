class Cache
  # It's a shared array and a hash, together
  constructor: () ->
    @array = []
    @hash = {}
    @staleTime = 2 * 60 * 1000 # 2 minutes
    @refreshedAt = 0

  findOrCreate: (id) ->
    @hash[id] || @add({id :id})

  find: (id) ->
    @hash[id]

  remove: (id) ->
    delete @hash[id]
    _.remove @array, {id: id}

  add: (thing) ->
    @array.unshift(thing)
    @hash[thing.id] = thing
    thing

  refresh: (things) ->
    @refreshedAt = Date.now()
    @hash = {}
    @array.length = 0
    for thing in things
      @add(thing)

  stale: ->
    Date.now() - @refreshedAt > @staleTime

module.exports = Cache
