import 'package:flutter/cupertino.dart';
import 'package:task_management/category/task.dart';
import 'package:task_management/utils/hexcolor.dart';

class Group {
  String name;
  int categoryId;
  Color displayColor;
  final List<Task> tasks = [];

  Group(this.name, this.displayColor);

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {
      'name': name,
      'display_color': displayColor.toHex(),
    };
    if (categoryId != null) {
      map['category_id'] = categoryId;
    }
    return map;
  }

  Group.fromMap(Map<String, dynamic> map) {
    this.categoryId = map['category_id'];
    this.name = map['name'];
    this.displayColor = HexColor.fromHex(map['display_color']);
  }

  void addTask(Task task) {
    this.tasks.add(task);
  }

  void addTasks(List<Task> tasks) {
    this.tasks.addAll(tasks);
  }

  void removeTask(Task task) {
    this.tasks.removeWhere((element) => element == task);
  }

  void clearTasks() {
    this.tasks.clear();
  }

  void updateTask(Task task) {
    final int index = this.tasks.indexWhere((element) => element == task);
    if (index == -1) {
      return;
    }
    this.tasks.removeWhere((element) => element == task);
    this.tasks.insert(index, task);
  }

  List<Task> completedTasks() {
    return this.tasks.where((element) => element.completed).toList();
  }

  List<Task> notCompletedTasks() {
    return this.tasks.where((element) => !element.completed).toList();
  }

  bool operator ==(o) => o is Group && o.categoryId == categoryId;

  @override
  int get hashCode => categoryId.hashCode ^ name.hashCode;
}
