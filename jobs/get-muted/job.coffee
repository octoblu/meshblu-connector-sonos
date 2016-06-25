http = require 'http'

class GetMuted
  constructor: ({@connector}) ->
    throw new Error 'GetMuted requires connector' unless @connector?

  do: (message, callback) =>
    @connector.getMuted (error, {muted}) =>
      return callback error if error?

      metadata =
        code: 200
        status: http.STATUS_CODES[200]

      data = {muted}
      callback null, {metadata, data}

module.exports = GetMuted
