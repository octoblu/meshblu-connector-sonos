{EventEmitter}  = require 'events'
debug           = require('debug')('meshblu-connector-sonos:index')
SonosManager    = require './sonos-manager'

class Connector extends EventEmitter
  constructor: ->
    @sonos = new SonosManager

  addToQueue: ({uri, positionInQueue}, callback) =>
    @sonos.addToQueue {uri, positionInQueue}, callback

  close: (callback) =>
    debug 'on close'
    @sonos.close callback

  getCurrentTrack: (callback) =>
    @sonos.getCurrentTrack callback

  getMuted: (callback) =>
    @sonos.getMuted callback

  getVolume: (callback) =>
    @sonos.getVolume callback

  isOnline: (callback) =>
    callback null, running: true

  mute: (callback) =>
    @sonos.mute callback

  next: (callback) =>
    @sonos.next callback

  onConfig: (device={}, callback=->) =>
    { @options } = device
    debug 'on config', @options
    {ipAddress} = @options ? {}
    @sonos.connect {ipAddress}, callback

  play: (callback) =>
    @sonos.play callback

  playImmediately: ({uri}, callback) =>
    @sonos.playImmediately {uri}, callback

  playNext: ({uri}, callback) =>
    @sonos.playNext {uri}, callback

  pause: (callback) =>
    @sonos.pause callback

  previous: (callback) =>
    @sonos.previous callback

  setVolume: ({volume}, callback) =>
    @sonos.setVolume {volume}, callback

  searchLibrary: ({ searchType, searchTerm, limit, offset }, callback) =>
    @sonos.searchLibrary { searchType, searchTerm, limit, offset }, callback

  start: (device, callback) =>
    debug 'started'
    @onConfig device, callback

  unmute: (callback) =>
    @sonos.unmute callback

module.exports = Connector
