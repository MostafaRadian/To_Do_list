// ignore_for_file: prefer_const_declarations
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? db;

  static Future<void> createDB() async {
    //print('Creating database...');

    // Check if the database instance is already created
    if (db != null) {
      //print('Database instance already exists.');
    } else {
      try {
        String path = join(await getDatabasesPath(), 'todo.db');

        // checking if the database file exists
        bool exists = await databaseExists(path);

        // If the database doesn't exist, create it
        if (!exists) {
          db = await openDatabase(
            path,
            version: 1,
            onCreate: (db, version) async {
              await db.execute(
                '''CREATE TABLE todo (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT DEFAULT 'false',archived TEXT DEFAULT 'false')''',
              );
            },
          );
          //print('Database created.');
        } else {
          // If the database exists, simply open it
          db = await openDatabase(path, version: 1);
          //print('Database already exists. Opened existing database.');
        }
      } catch (error) {
        //print("Error in database creation is $error");
      }
    }
  }

  // Other methods in your DBHelper class...

  static Future<void> insertToDB({
    required String title,
    required String time,
    required String date,
  }) async {
    try {
      await db?.insert("todo", {"title": title, "date": date, "time": time});
    } catch (error) {
      if (kDebugMode) {
        print("Error in insert is $error");
      }
    }
  }

  static Future<void> updateTaskStatus(int taskId, String status) async {
    try {
      await db?.update(
        'todo',
        {'status': status == 'true' ? 'false' : 'true'},
        where: 'id = ?',
        // In SQLite's UPDATE statement, you typically use placeholders (represented by ?) and the whereArgs parameter to provide the values for those placeholders. This is done for security and to prevent SQL injection attacks.
        whereArgs: [taskId],
      );
    } catch (error) {
      if (kDebugMode) {
        print("Error updating favourite status: $error");
      }
    }
  }

  static Future<void> updateArchiveStatus(int taskId, String archived) async {
    try {
      await db?.update(
        'todo',
        {'archived': archived == 'true' ? 'false' : 'true'},
        where: 'id = ?',
        // In SQLite's UPDATE statement, you typically use placeholders (represented by ?) and the whereArgs parameter to provide the values for those placeholders. This is done for security and to prevent SQL injection attacks.
        whereArgs: [taskId],
      );
    } catch (error) {
      if (kDebugMode) {
        print("Error updating favourite status: $error");
      }
    }
  }

  static Future<List<Map<String, dynamic>>?> getDataFromDB() async {
    var result = await db?.query('todo');
    return result;
  }

  static Future<void> deleteTaskById(int taskId) async {
    try {
      await db?.delete(
        'todo',
        where: 'id = ?',
        whereArgs: [taskId],
      );
    } catch (error) {
      if (kDebugMode) {
        print("Error deleting task: $error");
      }
    }
  }
}
