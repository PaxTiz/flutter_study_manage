import 'package:macos_student/application.dart';
import 'package:macos_student/pages/absences/AbsenceCreate.dart';
import 'package:macos_student/pages/candidate/CandidateCreate.dart';

final routes = {
  '/': (ctx) => Application(0),
  CandidateCreate.routeName: (ctx) => CandidateCreate(),
  AbsenceCreate.routeName: (ctx) => AbsenceCreate()
};
