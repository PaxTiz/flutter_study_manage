import 'package:macos_student/application.dart';
import 'package:macos_student/pages/candidate/CandidateCreate.dart';

final routes = {
  '/': (ctx) => Application(),
  CandidateCreate.routeName: (ctx) => CandidateCreate(),
};
