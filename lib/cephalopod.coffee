_ = require 'lodash'
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

  onConnect: =>
    debug 'socket open'
    @authenticate()

  authenticate: =>
    debug 'authenticate'
    authMsg =
      topic: 'authentication'
      authentication: _.pick @options, 'uuid', 'token'
    @socket.write @tentacle.toProtocolBuffer authMsg

module.exports = Cephalopod
