http = require 'http'

class SetVolume
  constructor: ({@connector}) ->
    throw new Error 'SetVolume requires connector' unless @connector?

  do: ({data}, callback) =>
    return callback @_userError(422, 'data.volume is required') unless data?.volume?

    {volume} = data
    @connector.setVolume {volume}, callback

  _userError: (code, message) =>
    error = new Error message
    error.code = code
    return error

module.exports = SetVolume
