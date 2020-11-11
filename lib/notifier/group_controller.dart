import 'package:flutter/widgets.dart';
import 'package:task_management/category/group.dart';
import 'package:task_management/category/task.dart';
import 'package:task_management/database/database.dart';

class GroupController extends ChangeNotifier {
  final DatabaseConnector connector;

  GroupController(this.connector);

  List<Group> _groups = [];

  List<Group> get groups => _groups;

  Future<void> loadGroups() async {
    this._groups = await connector.findGroups();
    this.notifyListeners();
  }

  void removeGroup(Group group) async {
    this._groups.removeWhere((element) => element == group);
    await connector.deleteGroup(group);
    this.notifyListeners();
  }

  Future<Group> addGroup(Group group) async {
    final Group tmp = await connector.insertGroup(
      group.name,
      group.displayColor,
    );
    if (this._groups != null) {
      this._groups.add(tmp);
    }
    this.notifyListeners();
    return tmp;
  }

  Future<void> addTask(Group group, Task task) async {
    task = await connector.insertTask(group, task);
    group.addTask(task);
    task.group = group;
    this._replaceGroup(group);
  }

  Future<void> removeTask(Task task) async {
    Group group = task.group;
    if (group == null) {
      group = _groups.where((element) => element.tasks.contains(task)).first;
    }
    group.removeTask(task);
    await connector.deleteTask(task);
    this.notifyListeners();
  }

  Future<void> updateTask(Task task) async {
    if (task.group == null) {
      return;
    }
    final Group group = task.group;
    group.updateTask(task);
    task.group = group;
    this._replaceGroup(group);
    await connector.updateTask(task);
  }

  Future<void> updateGroup(Group group) async {
    this._replaceGroup(group);
    await connector.updateGroup(group);
  }

  void _replaceGroup(Group group) {
    final int index = groups.indexWhere((element) => element == group);
    if (index == -1) {
      return;
    }
    this._groups.removeAt(index);
    this._groups.insert(index, group);
    this.notifyListeners();
  }

  bool operator ==(o) =>
      o is GroupController && o._groups.length == _groups.length;

  @override
  int get hashCode => "GroupController".hashCode;
}
