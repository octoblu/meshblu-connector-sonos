http = require 'http'

class Play
  constructor: ({@connector}) ->
    throw new Error 'Play requires connector' unless @connector?

  do: (message, callback) =>
    @connector.play callback

module.exports = Play
