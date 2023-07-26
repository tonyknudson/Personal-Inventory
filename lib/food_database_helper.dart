import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class FoodDatabaseHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE foodRecords(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        label TEXT NOT NULL,
        category TEXT NOT NULL,
        purchaseDate TEXT NOT NULL,
        expirationDate TEXT NOT NULL,
        warningDate TEXT NOT NULL
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'personalInventory.db',
      version: 30,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new food record
  static Future<int> createFoodRecord(String label, String category,
      String purchaseDate, String expirationDate, String warningDate) async {
    final db = await FoodDatabaseHelper.db();

    final data = {
      'label': label,
      'category': category,
      'purchaseDate': purchaseDate,
      'expirationDate': expirationDate,
      'warningDate': warningDate
    };

    final id = await db.insert('foodRecords', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all food records
  static Future<List<Map<String, dynamic>>> getFoodRecords() async {
    final db = await FoodDatabaseHelper.db();
    return db.query('foodRecords', orderBy: "id");
  }

  // Get a single food record by id
  static Future<List<Map<String, dynamic>>> getFoodRecord(int id) async {
    final db = await FoodDatabaseHelper.db();
    return db.query('foodRecords', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update a food record by id
  static Future<int> updateFoodRecord(int id, String label, String category,
      String purchaseDate, String expirationDate, String warningDate) async {
    final db = await FoodDatabaseHelper.db();

    final data = {
      'label': label,
      'category': category,
      'purchaseDate': purchaseDate,
      'expirationDate': expirationDate,
      'warningDate': warningDate
    };

    final result =
        await db.update('foodRecords', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete food record by id
  static Future<void> deleteFoodRecord(int id) async {
    final db = await FoodDatabaseHelper.db();
    try {
      await db.delete("foodRecords", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an food record: $err");
    }
  }

  // Delete all food records
  static Future<void> deleteAllFoodRecords() async {
    final db = await FoodDatabaseHelper.db();
    try {
      await db.delete("foodRecords");
    } catch (err) {
      debugPrint("Something went wrong when deleting an food record: $err");
    }
  }
}
