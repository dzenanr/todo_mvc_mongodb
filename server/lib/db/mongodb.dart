part of todo_mvc;

class TodoMvcDb implements ActionReactionApi {
  TodoDomain domain;
  DomainSession session;
  MvcModel model;
  Tasks tasks;

  String dbUri;
  String dbName;
  Db db;

  TaskCollection taskCollection;

  TodoMvcDb(this.dbUri, this.dbName) {
    var repository = new Repository();
    domain = repository.getDomainModels('Todo');
    domain.startActionReaction(this);
    session = domain.newSession();
    model = domain.getModelEntries('Mvc');
    tasks = model.tasks;
  }

  Future open() {
    Completer completer = new Completer();
    db = new Db('${dbUri}${dbName}');
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
    var taskMap = task.toDb();
    return dbTasks.insert(taskMap).then((_) {
      print('inserted task: ${task.title}');
    }).catchError(print);
  }

  Future<Task> delete(Task task) {
    var taskMap = task.toDb();
    return dbTasks.remove(taskMap).then((_) {
      print('removed task: ${task.title}');
    }).catchError(print);
  }

  Future<Task> update(Task task) {
    var taskMap = task.toDb();
    return dbTasks.update({'title': taskMap['title']}, taskMap).then((_) {
      print('updated task: ${task.title}');
    }).catchError(print);
  }
}

