http = require 'http'

class Previous
  constructor: ({@connector}) ->
    throw new Error 'Previous requires connector' unless @connector?

  do: (message, callback) =>
    @connector.previous callback

module.exports = Previous
