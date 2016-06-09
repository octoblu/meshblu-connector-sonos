_               = require 'lodash'
{EventEmitter}  = require 'events'
Sonos           = require 'sonos'
cSonos          = require('sonos').Sonos
debug           = require('debug')('meshblu-connector-sonos:index')

class SonosConnector extends EventEmitter
  isOnline: (callback) =>
    callback null, running: !!@sonos

  onMessage: (message={}) =>
    @doAction message.payload

  doAction: (payload={}) =>
    return @emitMessage 'error', error: 'Not connected to a Sonos' unless @sonos?
    { action, args } = payload
    return @emitMessage 'error', error: "Invalid Action, #{action}" unless @sonos[action]?
    callback = (error, response) =>
      return @emitMessage 'error', { error } if error?
      @emitMessage action, { response }

    argValues = _.values(args)
    argValues.push callback
    @sonos[action] argValues...

  emitMessage: (topic, payload={}) =>
    @emit 'message', {
      devices: ['*'],
      topic,
      payload
    }

  connectToSonos: (@ipAddress=@ipAddress) =>
    @sonos = new cSonos @ipAddress

  getAvailableSonos: =>
    return @connectToSonos() if @ipAddress
    @getDeviceIp (error, ipAddress) =>
      return @emitMessage 'error', { error } if error?
      @connectToSonos ipAddress

  getDeviceIp: (callback) =>
    debug 'discovering...'
    search = Sonos.search()
    search.on 'DeviceAvailable', (device, model) =>
      debug 'device discovered', device, model
      search.destroy()
      callback null, device.host

  onConfig: (device={}) =>
    options = device.options || {}
    lastIpAddress = @ipAddress
    { useCustomIP, ipAddress } = options
    return @getAvailableSonos() unless useCustomIP
    return debug 'already connected' if @sonos? && lastIpAddress && lastIpAddress == ipAddress
    @ipAddress = null
    @connectCustomSonos ipAddress

  start: (device) =>
    @onConfig device

module.exports = SonosConnector
