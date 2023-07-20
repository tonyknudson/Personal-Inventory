import 'sqflite.dart';

/// Creates food Table
Future createFoodTable() async {
  var dbClient = await SqliteDB().db;
  var res = await dbClient.execute("""
      CREATE TABLE User(
        id TEXT PRIMARY KEY,
        name TEXT,
        email TEXT,
        age INTEGER
      )""");
  return res;
}
