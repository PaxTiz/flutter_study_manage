import 'package:sqflite/sqflite.dart';

import '../db.dart';
import '../models/Candidate.dart';

class CandidateService {
  Future<List<Candidate>> getAll() async {
    final Database db = await getDatabase();
    List<Map<String, dynamic>> candidates =
        await db.query("candidates", orderBy: "id DESC");

    if (candidates.length > 0)
      return List.generate(
        candidates.length,
        (i) => Candidate.fromMap(candidates[i]),
      );

    return null;
  }

  Future insertCandidate(Candidate candidate) async {
    final Database db = await getDatabase();
    await db.insert("candidates", candidate.toMap());
  }

  Future updateCandidate(Candidate c) async {
    final Database db = await getDatabase();
    await db
        .update("candidates", c.toMap(), where: "id = ?", whereArgs: [c.id]);
  }

  Future deleteCandidate(Candidate candidate) async {
    final Database db = await getDatabase();
    await db.delete("candidates", where: "id = ?", whereArgs: [candidate.id]);
  }
}
