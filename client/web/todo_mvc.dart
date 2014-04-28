
import 'package:todo_mvc/todo_mvc.dart';
import 'package:todo_mvc/todo_mvc_app.dart';

main() {
  var repository = new Repository();
  var domain = repository.getDomainModels('Todo');
  new TodoApp(domain);
}



