http = require 'http'

class Pause
  constructor: ({@connector}) ->
    throw new Error 'Pause requires connector' unless @connector?

  do: (message, callback) =>
    @connector.pause callback

module.exports = Pause
