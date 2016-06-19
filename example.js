  connect = require('./easy-tcp').connect
  listen = require('./easy-tcp').listen
  port = 3000;
  //Server
  listen(port, function(client){
    console.log("Client connected");
    client.on("chat", function(m){
        client.send({
          _name: "chat",
          text: "Got your message buddy !"
        });
    });
  });
  //Client
  connect("localhost", port, function(client){
    client.on("chat", function(message){
       console.log("Chat message: " + message.text);
    });
    return client.send({
      _name: "chat",
      text: "Let's chat !"
    });
  });
