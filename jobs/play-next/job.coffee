http = require 'http'

class PlayNext
  constructor: ({@connector}) ->
    throw new Error 'PlayNext requires connector' unless @connector?

  do: ({data}, callback) =>
    return callback @_userError(422, 'data.uri is required') unless data?.uri?

    {uri} = data
    @connector.playNext {uri}, callback

  _userError: (code, message) =>
    error = new Error message
    error.code = code
    return error

module.exports = PlayNext
