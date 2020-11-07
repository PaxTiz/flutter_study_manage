import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

mixin MyDatabase {
  Database db;

  init() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'database.db'),
          version: 1, onCreate: (db, version) async {
        await db.execute("""CREATE TABLE candidates (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        company_name VARCHAR(255) NOT NULL,
        email VARCHAR(255) DEFAULT NULL,
        response TEXT NOT NULL
      )""");

        await db.execute("""CREATE TABLE absences (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      subject VARCHAR(255) NOT NULL,
      total_hours INTEGER NOT NULL,
      allowed_hours INTEGER NOT NULL,
      missed_hours INTEGER NOT NULL,
      available_hours INTEGER NOT NULL,
      updated_at INTEGER
    )""");
      });
    }
  }
}
