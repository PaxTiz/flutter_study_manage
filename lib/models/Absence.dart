import 'package:macos_student/models/Model.dart';

class Absence extends Model {
  /// The id which reference document in SQLite
  final int id;

  /// The subject relative to absence
  String subject;

  /// The number of total hours of this subject
  int totalHours;

  /// The number of allowed absences (10% of totalHours)
  int allowedHours;

  /// The number of hours the person has missed
  int missedHours;

  /// The number of absences still available before reaching 10%
  int availableHours;
  Absence(
      {this.id,
      this.subject,
      this.totalHours,
      this.allowedHours,
      this.missedHours,
      this.availableHours});

  factory Absence.fromMap(Map<String, dynamic> map) {
    return Absence(
        id: int.parse(map['id'].toString()),
        subject: map['subject'],
        totalHours: int.parse(map['total_hours'].toString()),
        allowedHours: int.parse(map['allowed_hours'].toString()),
        missedHours: int.parse(map['missed_hours'].toString()),
        availableHours: int.parse(map['available_hours'].toString()));
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subject': subject,
      'total_hours': totalHours,
      'allowed_hours': allowedHours,
      'missed_hours': missedHours,
      'available_hours': availableHours,
    };
  }
}
