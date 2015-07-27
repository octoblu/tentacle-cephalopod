Cephalopod = require '../lib/cephalopod'

describe 'Cephalopod', ->
  beforeEach ->
    @net = createConnection: sinon.spy()

  beforeEach ->
    options = host: '172.17.8.101', port: 61108
    dependencies = net: @net
    @sut = new Cephalopod options, dependencies

  describe '->connect', ->
    beforeEach ->
      @sut.connect()

    it 'should establish a connection', ->
      options = host: '172.17.8.101', port: 61108
      expect(@net.createConnection).to.have.been.calledWith options

    # describe 'when the connection completes', ->
    #   beforeEach ->
    #     @net.createConnection.yields @socket

      # it 'should try to authenticate', ->
