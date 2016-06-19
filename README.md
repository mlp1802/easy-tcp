###Description
Library for passing JSON messages from tcp clients and servers.

###Install

```
npm install easy-tcp --save

```
###Server
```javascript
listen = require('easy-tcp').listen
port = 3000;
//start server
listen(port, function(client){
  console.log("Client connected");
  return client.on("chat", function(m){
    return client.send({
      _name: "chat", //this is a reserved word, the name of the message
      text: "Got your message buddy !"
    });
  });
});
```
###Client
```javascript
connect = require('easy-tcp').connect
//connect to server
connect("localhost", port, function(client){
  client.on("chat", function(message){
    return console.log("Chat message: " + message.text);
  });
  return client.send({
    _name: "chat", //this is a reserved word, the name of the message
    text: "Let's chat !"
  });
});

```
When done with client
```javascript
client.close()
```





