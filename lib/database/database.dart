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

  Future<List<Group>> findCategories() async {
    final Database database = await this._database;
    final List<Map> tasks = await database.query("tasks");
    final List<Group> categories = (await database.query("categories"))
        .map((e) => Group.fromMap(e))
        .toList();

    categories.forEach((category) {
      tasks.forEach((element) {
        final int categoryId = element['category_id'];
        if (category.categoryId == categoryId) {
          final Task task = Task.fromMap(category, element);
          category.addTask(task);
          task.category = category;
        }
      });
    });
    return categories;
  }

  Future<Group> insertCategory(String name, Color color) async {
    final Database database = await this._database;
    final Group category = Group(name, color);
    category.categoryId = await database.insert(
      'categories',
      category.toMap(),
    );
    return category;
  }

  Future<void> deleteCategory(Group category) async {
    final Database database = await this._database;
    database.delete(
      'categories',
      where: 'category_id=?',
      whereArgs: [category.categoryId],
    );
  }

  Future<void> updateCategory(Group category) async {
    final Database database = await this._database;
    database.update(
      'categories',
      category.toMap(),
      where: "category_id=?",
      whereArgs: [category.categoryId],
    );
  }

  Future<Task> insertTask(Group category, Task task) async {
    final Database database = await this._database;
    final Map<String, dynamic> map = task.toMap();
    map['category_id'] = category.categoryId;
    task.taskId = await database.insert(
      "tasks",
      map,
    );
    task.category = category;
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
