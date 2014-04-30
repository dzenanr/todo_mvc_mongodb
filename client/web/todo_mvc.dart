import 'package:todo_mvc/todo_mvc.dart';
import 'package:todo_mvc/todo_mvc_app.dart';

const String HOST = '127.0.0.1'; // eg: localhost
const int PORT = 8080;
//String url = 'http://${HOST}:${PORT}';
String url = 'http://todomvcmongodb.dzenanr.dartblob.com/';

main() {
  var repository = new Repository();
  var domain = repository.getDomainModels('Todo');
  new TodoApp(domain, url);
}



