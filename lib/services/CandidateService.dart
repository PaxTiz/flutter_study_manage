import 'package:flutter/material.dart';
import 'package:macos_student/models/Candidate.dart';

import '../db.dart';

class CandidateService with ChangeNotifier, MyDatabase {
  static final CandidateService instance = CandidateService._internal();
  String get tableName => "candidates";

  List<Candidate> candidates = [];

  factory CandidateService() => instance;

  Future<List<Candidate>> getAll() async {
    List<Map<String, dynamic>> data =
        await db.query(tableName, orderBy: "id DESC");

    candidates = List.generate(
      data.length,
      (i) => Candidate.fromMap(data[i]),
    );

    notifyListeners();
    return candidates;
  }

  Future<Candidate> get(int id) {
    throw UnimplementedError();
  }

  Future<void> insert(Candidate data) async {
    await db.insert(tableName, data.toMap());
    candidates.add(data);
    notifyListeners();
  }

  Future<void> update(Candidate data) async {
    await db
        .update(tableName, data.toMap(), where: "id = ?", whereArgs: [data.id]);
    final c = candidates.indexWhere((e) => e.id == data.id);
    candidates[c] = data;
    notifyListeners();
  }

  Future<void> delete(Candidate data) async {
    await db.delete(tableName, where: "id = ?", whereArgs: [data.id]);
    candidates.remove(data);
    notifyListeners();
  }

  CandidateService._internal() {
    init();
  }
}
