{EventEmitter}  = require 'events'
debug           = require('debug')('meshblu-connector-sonos:index')
Sonos           = require 'sonos'
cSonos          = require('sonos').Sonos

class SonosConnector extends EventEmitter
  constructor: ->
    debug 'Sonos constructed'

  isOnline: (callback) =>
    callback null, running: true

  close: (callback) =>
    debug 'on close'
    callback()

  onMessage: (message) =>
    return unless message?
    { payload } = message
    switch payload.action
      when 'play-url' then @playUrl payload.url
      when 'current-track' then @getCurrentTrack()

  getCurrentTrack: =>
    @sonos.currentTrack (err, track) =>
      return if err?
      @emit 'message',
        devices: [ '*' ]
        payload:
          currentTrack: track

  playUrl: (url) =>
    @sonos.play url, (err, playing) =>
      debug 'play response',
        error: err
        playing: playing

  connectSonos: () =>
    if @options.useCustomIP?
      return @sonos = new cSonos(@options.ip) if @options.useCustomIP and @options.ip?
    @getDeviceIp (error, ipAddress) =>
      @sonos = new cSonos(ipAddress)

  getDeviceIp: (callback) =>
    if @discoveredIp
      debug 'ip address already discovered', @discoveredIp
      return callback(null, @discoveredIp)
    debug 'discovering...'
    search = Sonos.search()
    search.on 'DeviceAvailable', (device, model) =>
      debug 'device discovered', device, model
      @discoveredIp = device.host
      debug 'ipAddress', @discoveredIp
      callback null, @discoveredIp

  onConfig: (device) =>
    @options = device.options || {}
    debug 'on config', @options
    @connectSonos()

  start: (device) =>
    { @uuid } = device
    debug 'started', @uuid
    @onConfig device


module.exports = SonosConnector
