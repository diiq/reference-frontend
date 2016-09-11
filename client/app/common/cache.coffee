class Cache
  # It's a shared array and a hash, together
  constructor: () ->
    @array = []
    @hash = {}

  find: (id) ->
    @hash[id] || @add({id :id})

  remove: (id) ->
    delete @hash[id]
    _.remove @array, {id: id}

  add: (thing) ->
    @array.push(thing)
    @hash[thing.id] = thing
    thing

  refresh: (things) ->
    @hash = {}
    @array.length = 0
    for thing in things
      @add(thing)

module.exports = Cache
