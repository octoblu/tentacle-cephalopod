MeshbluConfig = require 'meshblu-config'
Cephalopod = require './'

class Command
  run: =>
    config = new MeshbluConfig
    cephalopod = new Cephalopod config.toJSON()
    cephalopod.connect()

command = new Command()
command.run()
