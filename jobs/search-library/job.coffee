http = require 'http'

class GetVolume
  constructor: ({@connector}) ->
    throw new Error 'GetVolume requires connector' unless @connector?

  do: ({data}, callback) =>
    return callback @_userError(422, 'data.searchType is required') unless data?.searchType?
    return callback @_userError(422, 'data.searchTerm is required') unless data?.searchTerm?
    return callback @_userError(422, 'data.limit is required') unless data?.limit?
    return callback @_userError(422, 'data.offset is required') unless data?.offset?

    { searchType, searchTerm, limit, offset } = data
    @connector.setVolume { searchType, searchTerm, limit, offset }, (error, {returned, total, items}) =>
      metadata =
        code: 200
        status: http.STATUS_CODES[200]

      data = {returned, total, items}
      callback null, {metadata, data}

  _userError: (code, message) =>
    error = new Error message
    error.code = code
    return error

module.exports = GetVolume
