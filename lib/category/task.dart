import 'package:task_management/category/group.dart';

class Task {
  int taskId;
  String title;
  bool completed;
  Group group;
  DateTime expireDate;

  Task(this.title, this.completed, this.expireDate);

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {
      'title': this.title,
      'completed': this.completed ? 1 : 0,
      'expire_date': this.expireDate.millisecondsSinceEpoch
    };
    if (this.taskId != null) {
      map['task_id'] = this.taskId;
    }
    return map;
  }

  Task.fromMap(Group category, Map<String, dynamic> map) {
    this.taskId = map['task_id'];
    this.title = map['title'];
    this.completed = map['completed'] == 1 ? true : false;
    this.expireDate = DateTime.fromMillisecondsSinceEpoch(map['expire_date']);
    this.group = category;
  }

  bool operator ==(o) => o is Task && o.taskId == taskId;

  @override
  int get hashCode => taskId.hashCode ^ title.hashCode;
}
