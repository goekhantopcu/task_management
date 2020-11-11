import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_management/category/group.dart';
import 'package:task_management/category/task.dart';

class DatabaseConnector {
  Future<Database> _database;

  Future<void> open() async {
    WidgetsFlutterBinding.ensureInitialized();
    this._database = openDatabase(
      join(await getDatabasesPath(), "tasks_manager1.db"),
      onCreate: (db, version) {
        return db.execute(
          '''
          create table if not exists categories (
            category_id integer primary key autoincrement,
            name text,
            display_color text
          )
          ''',
        ).whenComplete(
          () => db.execute(
            ''' 
            create table if not exists tasks (
              task_id integer primary key autoincrement,
              title text not null default 'default',
              completed integer not null default 0,
              expire_date integer,
              category_id integer, 
              foreign key (category_id) references categories(category_id) 
              on delete cascade
            )
          ''',
          ),
        );
      },
      version: 1,
    );
  }

  Future<List<Group>> findGroups() async {
    final Database database = await this._database;
    final List<Map> tasks = await database.query("tasks");
    final List<Group> groups = (await database.query("categories"))
        .map((e) => Group.fromMap(e))
        .toList();

    groups.forEach((group) {
      tasks.forEach((element) {
        final int groupId = element['category_id'];
        if (group.groupId == groupId) {
          final Task task = Task.fromMap(group, element);
          group.addTask(task);
          task.group = group;
        }
      });
    });
    return groups;
  }

  Future<Group> insertGroup(String name, Color color) async {
    final Database database = await this._database;
    final Group category = Group(name, color);
    category.groupId = await database.insert(
      'categories',
      category.toMap(),
    );
    return category;
  }

  Future<void> deleteGroup(Group group) async {
    final Database database = await this._database;
    database.delete(
      'categories',
      where: 'category_id=?',
      whereArgs: [group.groupId],
    );
  }

  Future<void> updateGroup(Group group) async {
    final Database database = await this._database;
    database.update(
      'categories',
      group.toMap(),
      where: "category_id=?",
      whereArgs: [group.groupId],
    );
  }

  Future<Task> insertTask(Group group, Task task) async {
    final Database database = await this._database;
    final Map<String, dynamic> map = task.toMap();
    map['category_id'] = group.groupId;
    task.taskId = await database.insert(
      "tasks",
      map,
    );
    task.group = group;
    return task;
  }

  Future<void> deleteTask(Task task) async {
    final Database database = await this._database;
    database.delete(
      'tasks',
      where: "task_id=?",
      whereArgs: [task.taskId],
    );
  }

  Future<void> updateTask(Task task) async {
    final Database database = await this._database;
    database.update(
      "tasks",
      task.toMap(),
      where: "task_id=?",
      whereArgs: [task.taskId],
    );
  }

  Future<void> deleteAllCategories() async {
    final Database database = await this._database;
    database.delete('categories');
  }
}
