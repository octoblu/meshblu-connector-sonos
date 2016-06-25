http = require 'http'

class Unmute
  constructor: ({@connector}) ->
    throw new Error 'Unmute requires connector' unless @connector?

  do: (message, callback) =>
    @connector.unmute callback

module.exports = Unmute
