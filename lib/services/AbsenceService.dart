import 'package:macos_student/models/Absence.dart';
import 'package:macos_student/services/Service.dart';
import 'package:sqflite/sqflite.dart';

import '../db.dart';

class AbsenceService implements Service<Absence> {
  static final AbsenceService instance = AbsenceService._internal();
  String get tableName => "absences";
  Database db;

  factory AbsenceService() {
    return instance;
  }

  Future<List<Absence>> getAll() async {
    List<Map<String, dynamic>> candidates =
        await db.query(tableName, orderBy: "updated_at DESC");

    if (candidates.length > 0)
      return List.generate(
        candidates.length,
        (i) => Absence.fromMap(candidates[i]),
      );

    return null;
  }

  Future<Absence> get(int id) {
    throw UnimplementedError();
  }

  Future<void> insert(Absence data) async {
    int id = await db.insert(tableName, data.toMap());
    await db.update(
        tableName, {"updated_at": DateTime.now().millisecondsSinceEpoch},
        where: "id = ?", whereArgs: [id]);
  }

  Future<void> update(Absence data) async {
    await db
        .update(tableName, data.toMap(), where: "id = ?", whereArgs: [data.id]);
    await db.update(
        tableName, {"updated_at": DateTime.now().millisecondsSinceEpoch},
        where: "id = ?", whereArgs: [data.id]);
  }

  Future<void> delete(Absence data) async {
    await db.delete(tableName, where: "id = ?", whereArgs: [data.id]);
  }

  Future<void> increment(Absence absence) async {
    await db.rawUpdate("""
      UPDATE $tableName
      SET missed_hours = missed_hours + 1, available_hours = available_hours - 1
      WHERE id = ?
    """, [absence.id]);
  }

  Future<Database> init() async =>
      await getDatabase().then((value) => db = value);

  AbsenceService._internal() {
    init();
  }
}
