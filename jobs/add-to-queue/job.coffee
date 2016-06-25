http = require 'http'

class AddToQueue
  constructor: ({@connector}) ->
    throw new Error 'AddToQueue requires connector' unless @connector?

  do: ({data}, callback) =>
    return callback @_userError(422, 'data.uri is required') unless data?.uri?
    return callback @_userError(422, 'data.positionInQueue is required') unless data?.positionInQueue?

    {uri, positionInQueue} = data
    @connector.addToQueue {uri, positionInQueue}, callback

  _userError: (code, message) =>
    error = new Error message
    error.code = code
    return error

module.exports = AddToQueue
