import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

class ConfigDatabaseHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE configs(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        category TEXT NOT NULL,
        expirationDays TEXT NOT NULL
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'personalInventory.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new config record
  static Future<int> createConfig(
      String category, String expirationDays) async {
    final db = await ConfigDatabaseHelper.db();

    final data = {'category': category, 'expirationDays': expirationDays};
    final id = await db.insert('configs', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all config records
  static Future<List<Map<String, dynamic>>> getConfigs() async {
    final db = await ConfigDatabaseHelper.db();
    return db.query('configs', orderBy: "id");
  }

  // Get a single config record by id
  static Future<List<Map<String, dynamic>>> getConfig(int id) async {
    final db = await ConfigDatabaseHelper.db();
    return db.query('configs', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an config record by id
  static Future<int> updateConfig(
      int id, String category, String expirationDays) async {
    final db = await ConfigDatabaseHelper.db();

    final data = {
      'category': category,
      'expirationDays': expirationDays,
    };

    final result =
        await db.update('configs', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete config record by id
  static Future<void> deleteConfig(int id) async {
    final db = await ConfigDatabaseHelper.db();
    try {
      await db.delete("configs", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting a config: $err");
    }
  }

  // Delete all config records
  static Future<void> deleteAllconfigs() async {
    final db = await ConfigDatabaseHelper.db();
    try {
      await db.delete("configs");
    } catch (err) {
      debugPrint("Something went wrong when deleting a config: $err");
    }
  }
}
