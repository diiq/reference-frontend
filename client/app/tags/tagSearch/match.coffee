_ = require 'lodash'

Bonuses =
  wordBoundary: 30,
  consecutiveLetters: 15,
  separation: -1,
  distanceFromFilename: -10,
  repeatedSelection: 10,
  recentSelection: 10

class Match
  @search: (search, list, key) ->
    search = search.toLowerCase()
    regex = new RegExp("(.*?)(" + search.split("").join(")(.*?)(") + ")(.*)")
    matches = for item in list
      new Match item, key, regex
    matches = _.filter matches, (m) -> m.matched
    matches = _.sortBy(matches, (m)-> m.score()).reverse()
    _.map matches, 'value'

  constructor: (value, key, searchRegex) ->
    @value = value
    @name = value[key]
    if !@name
      @matched = false
      return
    @regex = searchRegex
    @matchList = @name.toLowerCase().match(searchRegex)
    if !@matchList
      @matched = false
      return
    @matched = true
    @matchList = @matchList[1..]
    @parts = @getParts()

  totalLength: ->
    @parts[@parts.length - 1].index - @parts[0].index + 1

  matchedLength: ->
    (@matchList.length - 1) / 2

  getParts: ->
    ind = -1
    ret = for i in [0...@matchedLength()]
      ind += @matchList[i*2].length + @matchList[i*2 + 1].length
      {
        match: @matchList[i*2 + 1],
        index: ind
      }
    ret

  wordBoundaryBonus: ->
    bonus = 0
    for part in @parts
      if part.index == 0 || @name[part.index - 1] == "-" || @name[part.index - 1] == " "
        bonus += Bonuses.wordBoundary
    bonus

  separationBonus: (match) ->
    (@totalLength() - @matchedLength()) * Bonuses.separation

  consecutiveLettersBonus: (match) ->
    bonus = 0
    for i in [1...@parts.length]
      if @parts[i].index - @parts[i-1].index == 1
        bonus += Bonuses.consecutiveLetters
    bonus

  score: ->
    @separationBonus() + @wordBoundaryBonus() + @consecutiveLettersBonus()


module.exports = Match
