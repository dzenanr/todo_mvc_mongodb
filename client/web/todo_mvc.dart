import 'package:todo_mvc/todo_mvc.dart';
import 'package:todo_mvc/todo_mvc_app.dart';

//String url = 'http://127.0.0.1:8080/getresponse';
String url = 'http://todomvcmongodb.dzenanr.dartblob.com/getresponse';

main() {
  var repository = new Repository();
  var domain = repository.getDomainModels('Todo');
  new TodoApp(domain, url);
}



