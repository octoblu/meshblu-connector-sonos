Sonos          = require 'sonos'
{EventEmitter} = require 'events'

class SonosManager extends EventEmitter
  constructor: ->
    # hooks for testing
    @Sonos = Sonos

  close: (callback) =>
    return callback() unless @sonos?
    @sonos.destroy callback

  addToQueue: ({uri, positionInQueue}, callback) =>
    return callback new Error 'Sonos not connected' unless @sonos?
    @sonos.queue uri, positionInQueue, callback

  connect: ({@ipAddress}, callback) =>
    @_getSonos (error, @sonos) =>
      callback error

  _getSonos: (callback) =>
    return callback null, new @Sonos.Sonos(@ipAddress) if @ipAddress?
    @Sonos.search (device) =>
      callback null, device

  getCurrentTrack: (callback) =>
    return callback new Error 'Sonos not connected' unless @sonos?
    @sonos.currentTrack (error, currentTrack) =>
      return callback error if error?
      callback null, {currentTrack}

  getMuted: (callback) =>
    return callback new Error 'Sonos not connected' unless @sonos?
    @sonos.getMuted (error, muted) =>
      return callback error if error?
      callback null, {muted}

  getVolume: (callback) =>
    return callback new Error 'Sonos not connected' unless @sonos?
    @sonos.getVolume (error, volume) =>
      return callback error if error?
      callback null, {volume}

  next: (callback) =>
    return callback new Error 'Sonos not connected' unless @sonos?
    @sonos.next callback

  mute: (callback) =>
    return callback new Error 'Sonos not connected' unless @sonos?
    @sonos.setMuted true, callback

  play: (callback) =>
    return callback new Error 'Sonos not connected' unless @sonos?
    @sonos.play callback

  playImmediately: ({uri}, callback) =>
    return callback new Error 'Sonos not connected' unless @sonos?
    @sonos.play uri, callback

  playNext: ({uri}, callback) =>
    return callback new Error 'Sonos not connected' unless @sonos?
    @sonos.queueNext uri, callback

  previous: (callback) =>
    return callback new Error 'Sonos not connected' unless @sonos?
    @sonos.previous callback

  pause: (callback) =>
    return callback new Error 'Sonos not connected' unless @sonos?
    @sonos.pause callback

  searchLibrary: ({ searchType, searchTerm, limit, offset }, callback) =>
    return callback new Error 'Sonos not connected' unless @sonos?
    options =
      start: offset
      total: limit
    @sonos.searchMusicLibrary searchType, searchTerm, options, (error, data) =>
      callback null, data

  setVolume: ({volume}, callback) =>
    return callback new Error 'Sonos not connected' unless @sonos?
    @sonos.setVolume volume, callback

  unmute: (callback) =>
    return callback new Error 'Sonos not connected' unless @sonos?
    @sonos.setMuted false, callback

module.exports = SonosManager
