### Description
Library for easily creating a TCP socket server that listen to JSON messages. Server and client included.

### Install

```
npm install easy-tcp --save

```
### Server
```javascript
listen = require('easy-tcp').listen
port = 3000;
//start server
listen(port, function(client){
  console.log("Client connected");
  //listen for "chat" message (message marked with _name=chat)
  client.on("chat", function(m){
    client.send({
      _name: "chat", //this is a reserved word, the name of the message
      text: "Got your message buddy !"
    });
  });
});
```
### Client
```javascript
connect = require('easy-tcp').connect
//connect to server
connect("localhost", port, function(client){
  //listen for servers response, which is also a chat message
  client.on("chat", function(message){
     console.log("Chat message: " + message.text);
  });
  //send a message
  client.send({
    _name: "chat", //this is a reserved word, the name of the message
    text: "Let's chat !"
  });
});

```
When done with client
```javascript
client.close()
```

If you need to access the underlying socket
```javascript
var socket = client.socket
```
