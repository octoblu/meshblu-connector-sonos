http = require 'http'

class GetVolume
  constructor: ({@connector}) ->
    throw new Error 'GetVolume requires connector' unless @connector?

  do: (message, callback) =>
    @connector.getVolume (error, {volume}) =>
      return callback error if error?

      metadata =
        code: 200
        status: http.STATUS_CODES[200]

      data = {volume}
      callback null, {metadata, data}

module.exports = GetVolume
