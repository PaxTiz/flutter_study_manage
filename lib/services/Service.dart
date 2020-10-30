import 'package:flutter/material.dart';
import 'package:macos_student/models/Model.dart';

abstract class Service<T extends Model> {
  final String tableName;

  Service({@required this.tableName})
      : assert(tableName != null, "Le nom de la table ne peut pas être null."),
        assert(
            tableName.length > 0, "Le nom de la table ne peut pas être vide.");

  Future<List<T>> getAll();
  Future<T> get(int id);
  Future<void> insert(T data);
  Future<void> update(T data);
  Future<void> delete(T data);
}
