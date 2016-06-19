###Description
Library for passing JSON messages from tcp clients and servers.

###Install

```
npm install easy-tcp --save

###Create a server

```javascript
easy = require('./easy-tcp'), connect = easy.connect, listen = easy.listen;
  port = 3000;
  //Server
  listen(port, function(client){
    console.log("Client connected");
    return client.on("chat", function(m){
      return client.send({
        _name: "chat",
        text: "Got your message buddy !"
      });
    });
  });





