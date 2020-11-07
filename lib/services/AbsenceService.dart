import 'package:flutter/material.dart';
import 'package:macos_student/models/Absence.dart';

import '../db.dart';

class AbsenceService with MyDatabase, ChangeNotifier {
  static final AbsenceService instance = AbsenceService._internal();
  String get tableName => "absences";

  List<Absence> absences = [];

  factory AbsenceService() {
    return instance;
  }

  Future<List<Absence>> getAll() async {
    List<Map<String, dynamic>> candidates =
        await db.query(tableName, orderBy: "updated_at DESC");

    absences = List.generate(
      candidates.length,
      (i) => Absence.fromMap(candidates[i]),
    );

    notifyListeners();
    return absences;
  }

  Future<Absence> get(int id) {
    throw UnimplementedError();
  }

  Future<void> insert(Absence data) async {
    int id = await db.insert(tableName, data.toMap());
    await db.update(
        tableName, {"updated_at": DateTime.now().millisecondsSinceEpoch},
        where: "id = ?", whereArgs: [id]);
    absences.add(data);
    notifyListeners();
  }

  Future<void> update(Absence data) async {
    await db
        .update(tableName, data.toMap(), where: "id = ?", whereArgs: [data.id]);
    await db.update(
        tableName, {"updated_at": DateTime.now().millisecondsSinceEpoch},
        where: "id = ?", whereArgs: [data.id]);
    final a = absences.indexWhere((e) => e.id == data.id);
    absences[a] = data;
    notifyListeners();
  }

  Future<void> delete(Absence data) async {
    await db.delete(tableName, where: "id = ?", whereArgs: [data.id]);
    absences.remove(data);
    notifyListeners();
  }

  Future<void> increment(Absence absence) async {
    await db.rawUpdate("""
      UPDATE $tableName
      SET missed_hours = missed_hours + 1, available_hours = available_hours - 1
      WHERE id = ?
    """, [absence.id]);

    final a = absences.indexWhere((e) => e.id == absence.id);
    absences[a].missedHours += 1;
    absences[a].availableHours -= 1;
    notifyListeners();
  }

  AbsenceService._internal() {
    init();
  }
}
