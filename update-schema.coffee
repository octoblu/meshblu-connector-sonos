fs   = require 'fs'
path = require 'path'
_    = require 'lodash'
orgSchemas = require './schemas.json'

actions = {
  'currentTrack': [],
  'deviceDescription': [],
  'flush': [],
  'getCurrentState': [],
  'getLEDState': [],
  'getMusicLibrary' : [ 'search', 'options' ],
  'getMuted': [],
  'getTopology': [],
  'getVolume': [],
  'getZoneAttrs': [],
  'getZoneInfo': [],
  'next': [],
  'parseDIDL': [],
  'pause': [],
  'play' : [ 'uri' ],
  'previous': [],
  'queue' : [ 'uri', 'positionInQueue' ],
  'queueNext' : [ 'uri' ],
  'request' : [ 'endpoint', 'action', 'body', 'responseTag' ],
  'seek' : [ 'seconds' ],
  'setLEDState' : [ 'desiredState' ],
  'setMuted' : [ 'muted' ],
  'setName' : [ 'name' ],
  'setPlayMode' : [ 'mode' ],
  'setVolume' : [ 'volume' ],
  'stop': [],
}

class UpdateSchema
  constructor: ->
    @schemas = _.cloneDeep(orgSchemas)

  run: =>
    _.each actions, @addAction
    fs.writeFileSync(path.join(__dirname, 'schemas.json'), JSON.stringify(@schemas, null, 2))

  addAction: (args, action) =>
    kebab = _.kebabCase(action)
    title = _.startCase(action)
    actionMessage = {
      "title": title,
      "type": "object",
      "properties": {
        "action": {
          "type": "string",
          "default": action
        },
      },
      "x-form-schema": {
        "angular": "message.action.angular"
      },
      "required": [ "action" ]
    }

    unless _.isEmpty(args)
      actionMessage.properties.args = {
        "title": "Arguments",
        "type": "object",
        "properties": {},
        "required": []
      }
      actionMessage.required.push('args')
      _.each args, (arg) =>
        argObject = {
          title: _.startCase(arg)
          type: "string"
        }
        _.set actionMessage, "properties.args.properties.#{arg}", argObject
        actionMessage.properties.args.required.push arg

    _.set @schemas, "schemas.message.#{kebab}", actionMessage

new UpdateSchema().run()
