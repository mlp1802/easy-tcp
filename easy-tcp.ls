{each} = require("prelude-ls")
net  = require 'net'
carrier = require 'carrier'

listen = (port,onConnect)->
  (net.createServer (socket)~>
     client = new Client(socket)
     onConnect client
     socket.on 'error', ->
     carrier.carry socket,(line)~>client.handleLine line).listen(port)

connect = (ip,port,onConnect)->
  socket = new net.Socket()
  socket.on 'error', ->
  socket.connect port,ip,->
    client = new Client(socket)
    onConnect client
    carrier.carry socket,(line)~>client.handleLine line

#MessageHandler
class MessageHandler
    ->@handlers = []
    add:(name,handler)~>@handlers[name] = handler
    handleMessage:(message)~>
      call = (fun,message)~>
          if fun.length is 0 then
            fun()
          if fun.length is 1 then
            fun(message)
      command = @handlers[message._name]
      if command!=void
          call command, message
      else
        "Unhandled message: "+message|>console.log
    handleLine:(line) ~>
      try
        JSON.parse(line)|>@handleMessage
      catch e
        console.log e.stack

#ClientContainer
class ClientContainer
  ->@clients = new Map()

  add:(name,client)~>
    @clients.set name,client

  remove:(name)~>@clients.delete name
  each:(f)->@clients.forEach f
  sendAll:(message)~>@each (c)~>c.send message

#Client
class Client
  (@socket)->@messageHandler = new MessageHandler()
  sendString:(str)->@socket.write str
  send:(obj)~>@sendString (obj|>JSON.stringify)+"\n"
  handleLine:(line)~>@messageHandler.handleLine line
  on:(name,handler)-> @messageHandler.add name,handler
  close:->@socket.destroy()


module.exports = {
  ClientContainer:ClientContainer,
  connect:connect,
  listen:listen
}
