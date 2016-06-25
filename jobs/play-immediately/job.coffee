http = require 'http'

class PlayImmediately
  constructor: ({@connector}) ->
    throw new Error 'PlayImmediately requires connector' unless @connector?

  do: ({data}, callback) =>
    return callback @_userError(422, 'data.uri is required') unless data?.uri?

    {uri} = data
    @connector.playImmediately {uri}, callback

  _userError: (code, message) =>
    error = new Error message
    error.code = code
    return error

module.exports = PlayImmediately
