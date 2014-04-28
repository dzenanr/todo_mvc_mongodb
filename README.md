# todo_mvc 

**Categories**: dartling, client-server, json, MongoDB. 

## Description: 
Client-server application with [dartling](https://github.com/dzenanr/dartling) 
on a client and on the server. 
Local storage used on a client. 
MongoDB used on the server.

This project is based on the last spiral of 
[dartling_todo_mvc_spirals](https://github.com/dzenanr/dartling_todo_mvc_spirals)
for the client application,
on the last spiral of
[indexed_db_spirals](https://github.com/dzenanr/indexed_db_spirals)
for the client-sever communication,
and on the
[todo_mongodb](https://github.com/dzenanr/todo_mongodb) project for the database.

The author is thankful for the existence of
[Using Dart with JSON Web Services](http://www.dartlang.org/articles/json-web-service/)
and
[mongo_dart: MongoDB driver for Dart](http://pub.dartlang.org/packages/mongo_dart).

Client

+ client starts by loading data from the local storage
+ client has 2 buttons: To server and From server
+ To server (POST) integrates local tasks to data on the server
+ From server (GET) integrates server data to local tasks

Server

+ when server starts, it loads data from MongoDB to the model in main memory
+ when the model in main memory changes, the database is updated
+ server programming uses the model in main memory and not the database

Use

1. no need to create a database before 2;
   however, do not forget to start the MongoDB server (mongod; Ctrl-C to stop it)
2. run server/bin/server.dart in Dart Editor;
   it runs when you see in the server.dart tab in Dart Editor:
   Server at http://127.0.0.1:8080;
   if it does not run, use Run/Manage Launches
3. run client/web/todo_mvc.html in Dartium
4. run client as JavaScript in Chrome
5. use the client app in Dartium:
   1. From server to integrate server data locally
   2. add, remove and update tasks (saved locally)
   3. To server to integrate local data to server
6. use the client app in Chrome:
   1. From server to integrate server data locally
   2. add, remove and update tasks (saved locally)
   3. To server to integrate local data to server

