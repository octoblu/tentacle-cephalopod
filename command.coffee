MeshbluConfig = require 'meshblu-config'
Cephalapod = require './lib/cephalapod'

class Command
  run: =>
    config = new MeshbluConfig
    cephalapod = new Cephalapod config.toJSON()
    cephalapod.connect()

command = new Command()
command.run()
