{connect, listen} = require './easy-tcp'
port = 3000
#server
listen port, (client)->
  console.log("Client connected")
  client.on "chat", (m)->
    client.send(
      _name:"chat" #the name/id of the message. Must be there.
      text:"Got your chat message buddy !"
      )

#client
connect "localhost", port, (client)->
  #handling chatmessage
  client.on "chat", (m)->console.log ("Chat message: "+m.text)
  #send a message to server
  client.send(
      _name:"chat",
      text:"Let's chat !"
      )
