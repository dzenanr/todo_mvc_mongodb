part of todo_mvc; 
 
// lib/todo/mvc/tasks.dart 
 
class Task extends TaskGen { 
 
  Task(Concept concept) : super(concept); 
 
  Task.withId(Concept concept, String title) : 
    super.withId(concept, title); 
 
  // added after code gen - begin 
  
  Task.fromDb(Concept concept, Map value): super(concept) {
    bool beforeUpdateOid = concept.updateOid;
    concept.updateOid = true;
    oid = new Oid.ts(int.parse(value['oid']));
    concept.updateOid = beforeUpdateOid;
    code = value['code'];
    title = value['title'];
    completed = value['completed'];
    bool beforeUpdateWhen = concept.updateWhen;
    concept.updateWhen = true;
    whenAdded = value['whenAdded'];
    whenSet = value['whenSet'];
    whenRemoved = value['whenRemoved'];
    concept.updateWhen = beforeUpdateWhen;
  }

  Task.fromJson(Concept concept, Map value): super(concept) {
    bool beforeUpdateOid = concept.updateOid;
    concept.updateOid = true;
    oid = new Oid.ts(int.parse(value['oid']));
    concept.updateOid = beforeUpdateOid;
    code = value['code'];
    title = value['title'];
    completed = value['completed'] == 'true' ? true : false;
    bool beforeUpdateWhen = concept.updateWhen;
    concept.updateWhen = true;
    whenAdded = DateTime.parse(value['whenAdded']);
    whenSet = DateTime.parse(value['whenSet']);
    whenRemoved = DateTime.parse(value['whenRemoved']);
    concept.updateWhen = beforeUpdateWhen;
  }
  
  bool get left => !completed;
  bool get generate => title.contains('generate') ? true : false; 
  
  Map toDb() {
    return {
      'oid': oid.toString(),
      'code': code,
      'title': title,
      'completed': completed,
      'whenAdded': whenAdded,
      'whenSet': whenSet,
      'whenRemoved': whenRemoved
    };
  }
  
  // added after code gen - end 
 
} 
 
class Tasks extends TasksGen { 
 
  Tasks(Concept concept) : super(concept); 
 
  // added after code gen - begin 

  Tasks get completed => selectWhere((task) => task.completed);
  Tasks get left => selectWhere((task) => task.left);

  bool preAdd(Task task) {
    bool validation = super.preAdd(task);
    if (validation) {
      validation = task.title.length <= 64;
      if (!validation) {
        var error = new ValidationError('pre');
        error.message =
            'The "${task.title}" title should not be longer than 64.';
        errors.add(error);
      }
    }
    return validation;
  }
  
  // added after code gen - end 
 
} 
 
