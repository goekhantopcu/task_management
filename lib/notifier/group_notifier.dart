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
    this._groups = await connector.findCategories();
    this.notifyListeners();
  }

  void removeGroup(Group category) async {
    this._groups.removeWhere((element) => element == category);
    await connector.deleteCategory(category);
    this.notifyListeners();
  }

  Future<Group> addGroup(Group category) async {
    final Group tmp = await connector.insertCategory(
      category.name,
      category.displayColor,
    );
    if (this._groups != null) {
      this._groups.add(tmp);
    }
    this.notifyListeners();
    return tmp;
  }

  Future<void> addTask(Group category, Task task) async {
    task = await connector.insertTask(category, task);
    category.addTask(task);
    task.category = category;
    this._replaceGroup(category);
  }

  Future<void> removeTask(Task task) async {
    Group group = task.category;
    if (group == null) {
      group = _groups.where((element) => element.tasks.contains(task)).first;
    }
    group.removeTask(task);
    await connector.deleteTask(task);
    this.notifyListeners();
  }

  Future<void> updateTask(Task task) async {
    if (task.category == null) {
      return;
    }
    final Group category = task.category;
    category.updateTask(task);
    task.category = category;
    this._replaceGroup(category);
    await connector.updateTask(task);
  }

  Future<void> updateGroup(Group group) async {
    this._replaceGroup(group);
    await connector.updateCategory(group);
  }

  void _replaceGroup(Group category) {
    final int index = groups.indexWhere((element) => element == category);
    if (index == -1) {
      return;
    }
    this._groups.removeAt(index);
    this._groups.insert(index, category);
    this.notifyListeners();
  }

  bool operator ==(o) =>
      o is GroupController && o._groups.length == _groups.length;

  @override
  int get hashCode => "GroupController".hashCode;
}
