part of todo_mvc;

class TodoMvcDb implements ActionReactionApi {
  static const String DEFAULT_URI = 'mongodb://127.0.0.1/';
  static const String DB_NAME = 'todo_mvc_2';

  TodoDomain domain;
  DomainSession session;
  MvcModel model;
  Tasks tasks;

  Db db;

  TaskCollection taskCollection;

  TodoMvcDb() {
    var repository = new Repository();
    domain = repository.getDomainModels('Todo');
    domain.startActionReaction(this);
    session = domain.newSession();
    model = domain.getModelEntries('Mvc');
    tasks = model.tasks;
  }

  Future open() {
    Completer completer = new Completer();
    db = new Db('${DEFAULT_URI}${DB_NAME}');
    db.open().then((_) {
      taskCollection = new TaskCollection(this);
      taskCollection.load().then((_) {
        completer.complete();
      });
    }).catchError(print);
    return completer.future;
  }

  close() {
    db.close();
  }

  react(ActionApi action) {
    if (action is AddAction) {
      taskCollection.insert(action.entity);
    } else if (action is RemoveAction) {
      taskCollection.delete(action.entity);
    } else if (action is SetAttributeAction) {
      taskCollection.update(action.entity);
    }
  }
}

class TaskCollection {
  static const String COLLECTION_NAME = 'tasks';

  TodoMvcDb todo;

  DbCollection dbTasks;

  TaskCollection(this.todo) {
    dbTasks = todo.db.collection(COLLECTION_NAME);
  }

  Future load() {
    Completer completer = new Completer();
    dbTasks.find().toList().then((taskList) {
      taskList.forEach((taskMap) {
        var task = new Task.fromDb(todo.tasks.concept, taskMap);
        todo.tasks.add(task);
      });
      completer.complete();
    }).catchError(print);
    return completer.future;
  }

  Future<Task> insert(Task task) {
    var completer = new Completer();
    var taskMap = task.toDb();
    dbTasks.insert(taskMap).then((_) {
      print('inserted task: ${task.title}');
      completer.complete();
    }).catchError(print);
    return completer.future;
  }

  Future<Task> delete(Task task) {
    var completer = new Completer();
    var taskMap = task.toDb();
    dbTasks.remove(taskMap).then((_) {
      print('removed task: ${task.title}');
      completer.complete();
    }).catchError(print);
    return completer.future;
  }

  Future<Task> update(Task task) {
    var completer = new Completer();
    var taskMap = task.toDb();
    dbTasks.update({'title': taskMap['title']}, taskMap).then((_) {
      print('updated task: ${task.title}');
      completer.complete();
    }).catchError(print);
    return completer.future;
  }
}

