import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart' as sql;

// local database Sqflite
class SQLHelper {
  static Future<sql.Database> db() async {
    return sql.openDatabase("DB_local.db", version: 1,
        onCreate: (sql.Database database, int version) {
      database.execute(
          "CREATE TABLE DB_local (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, title TEXT, desc TEXT,createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)");
    });
  }

  static Future<int> createData(String title, String? desc) async {
    final db = await SQLHelper.db();
    final data = {'title': title, 'desc': desc};
    // final id = await db.insert('DB_local', data,conflictAlgorithm: sql.ConflictAlgorithm.replace);
    // return id;
    return db.insert("DB_local", data);
  }

  static Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await SQLHelper.db();
    return db.query('DB_local', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getSingleData(int id) async {
    final db = await SQLHelper.db();
    return db.query('DB_local', where: "id = ?", whereArgs: [id], limit: 1);
  }

  //update data
  static Future<int> updateData(int id, String title, String? desc) async {
    final db = await SQLHelper.db();

    final data = {
      'title': title,
      'desc': desc,
      'createdAt': DateTime.now().toString()
    };
    final result =
        await db.update('DB_local', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete data
  static Future<void> deleteData(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("DB_local", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
