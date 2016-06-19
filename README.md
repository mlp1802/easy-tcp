###Description
Library for passing JSON messages from tcp clients and servers.

###Install

```
npm install easy-tcp --save

```
###Server
```javascript
easy = require('./easy-tcp'), listen = easy.listen;
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
```
###Client
```javascript
easy = require('./easy-tcp'), connect = easy.connect
//Client
  connect("localhost", port, function(client){
    client.on("chat", function(message){
      return console.log("Chat message: " + message.text);
    });
    return client.send({
      _name: "chat",
      text: "Let's chat !"
    });
  });

```







