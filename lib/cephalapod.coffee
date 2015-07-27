_ = require 'lodash'
TentacleTransformer = require 'tentacle-protocol-buffer'

class Cephalapod
  constructor: (options={}, dependencies={}) ->
    @options = options
    @net = dependencies.net ? require 'net'
    @tentacle = new TentacleTransformer

  connect: =>
    connOptions = _.pick @options, 'host', 'port'
    @net.createConnection connOptions, (socket) =>
      @socket = socket
      @authenticate

  authenticate: =>
    authMsg =
      topic: 'authenticate'
      authentication: _.pick @options, 'uuid', 'token'
    @socket.write @tentacle.toProtocolBuffer authMsg

module.exports = Cephalapod
