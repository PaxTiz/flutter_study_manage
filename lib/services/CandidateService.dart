import 'package:macos_student/models/Candidate.dart';
import 'package:macos_student/services/Service.dart';
import 'package:sqflite/sqflite.dart';

import '../db.dart';

class CandidateService implements Service<Candidate> {
  static final CandidateService instance = CandidateService._internal();
  String get tableName => "candidates";
  Database db;

  factory CandidateService() {
    return instance;
  }

  Future<List<Candidate>> getAll() async {
    List<Map<String, dynamic>> candidates =
        await db.query(tableName, orderBy: "id DESC");

    if (candidates.length > 0)
      return List.generate(
        candidates.length,
        (i) => Candidate.fromMap(candidates[i]),
      );

    return null;
  }

  Future<Candidate> get(int id) {
    throw UnimplementedError();
  }

  Future<void> insert(Candidate data) async {
    await db.insert(tableName, data.toMap());
  }

  Future<void> update(Candidate data) async {
    await db
        .update(tableName, data.toMap(), where: "id = ?", whereArgs: [data.id]);
  }

  Future<void> delete(Candidate data) async {
    await db.delete(tableName, where: "id = ?", whereArgs: [data.id]);
  }

  Future<Database> init() async =>
      await getDatabase().then((value) => db = value);

  CandidateService._internal() {
    init();
  }
}
