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
    db = new Db('${dbUri}${dbName}');
    return db.open()
      .then((_) {
        taskCollection = new TaskCollection(this);
        taskCollection.load();
      })
      .catchError(print);
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
    return dbTasks.find().toList()
      .then((taskList) {
        taskList.forEach((taskMap) {
          var task = new Task.fromDb(todo.tasks.concept, taskMap);
          todo.tasks.add(task);
        });
      })
      .catchError(print);
  }

  Future<Task> insert(Task task) {
    var taskMap = task.toDb();
    return dbTasks.insert(taskMap).catchError(print);
  }

  Future<Task> delete(Task task) {
    var taskMap = task.toDb();
    return dbTasks.remove(taskMap).catchError(print);
  }

  Future<Task> update(Task task) {
    var taskMap = task.toDb();
    return dbTasks.update({'title': taskMap['title']}, taskMap)
      .catchError(print);
  }
}

