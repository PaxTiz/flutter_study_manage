import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  return openDatabase(join(await getDatabasesPath(), 'doggie_database.db'),
      version: 1, onCreate: (db, version) async {
    await db.execute("""CREATE TABLE candidates (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        company_name VARCHAR(255) NOT NULL,
        email VARCHAR(255) DEFAULT NULL,
        response TEXT NOT NULL
      )""");
  });
}
