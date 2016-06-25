http = require 'http'

class Next
  constructor: ({@connector}) ->
    throw new Error 'Next requires connector' unless @connector?

  do: (message, callback) =>
    @connector.next callback

module.exports = Next
