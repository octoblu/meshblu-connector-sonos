http = require 'http'

class GetCurrentTrack
  constructor: ({@connector}) ->
    throw new Error 'GetCurrentTrack requires connector' unless @connector?

  do: (message, callback) =>
    @connector.getCurrentTrack (error, {currentTrack}) =>
      return callback error if error?

      metadata =
        code: 200
        status: http.STATUS_CODES[200]

      data = {currentTrack}
      callback null, {metadata, data}

module.exports = GetCurrentTrack
