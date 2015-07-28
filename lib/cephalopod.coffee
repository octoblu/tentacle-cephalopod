_ = require 'lodash'
through = require 'through'
debug = require('debug')('tentacle-cephalopod')
TentacleTransformer = require 'tentacle-protocol-buffer'

class Cephalopod
  constructor: (options={}, dependencies={}) ->
    @options = options
    @net = dependencies.net ? require 'net'
    @tentacle = new TentacleTransformer

  connect: =>
    connOptions = _.pick @options, 'host', 'port'
    @socket = @net.createConnection connOptions, @onConnect
    @socket.pipe through @onData

  onConnect: =>
    debug 'socket open'
    @authenticate()

  onData: (data) =>
    debug "adding #{data.length} bytes from tentacle"
    @parseTentacleMessage()
    @tentacle.addData data
    @parseTentacleMessage()


  authenticate: =>
    debug 'authenticate'
    authMsg =
      topic: 'authentication'
      authentication: _.pick @options, 'uuid', 'token'
    @socket.write @tentacle.toProtocolBuffer authMsg

  parseTentacleMessage: =>
    try
      while (message = @tentacle.toJSON())
        debug "received tentacleMessage: ", message
    catch error
      debug "error parsing tentacle message"

module.exports = Cephalopod
