http = require 'http'

class Mute
  constructor: ({@connector}) ->
    throw new Error 'Mute requires connector' unless @connector?

  do: (message, callback) =>
    @connector.mute callback

module.exports = Mute
