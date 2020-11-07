import 'dart:io';

import 'package:flutter/material.dart';
import 'package:macos_student/routes.dart';
import 'package:macos_student/services/AbsenceService.dart';
import 'package:macos_student/services/CandidateService.dart';
import 'package:macos_student/theme.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isMacOS) {
    setWindowFrame(Rect.fromLTRB(50, 50, 1350, 850));
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider(create: (ctx) => CandidateService()),
        ListenableProvider(create: (ctx) => AbsenceService()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: theme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.dark,
        initialRoute: '/',
        routes: routes,
      ),
    );
  }
}
