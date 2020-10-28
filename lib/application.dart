import 'package:flutter/material.dart';
import 'package:macos_student/components/Sidebar.dart';
import 'package:macos_student/pages/CustomPage.dart';
import 'package:macos_student/pages/candidate/CandidatePage.dart';

class Application extends StatefulWidget {
  createState() => _Application();
}

class _Application extends State<Application> {
  int _currentPage = 0;
  void setCurrentPage(int index) => setState(() => _currentPage = index);

  final pages = <CustomPage>[
    CustomPage(
      child: Text("Hello World"),
    ),
    CustomPage(
      child: Text("Coucou 2"),
    ),
    CustomPage(
      child: CandidatePage(),
    ),
  ];

  final tiles = <String>[
    "Mes notes",
    "Mes absences",
    "Mes candidatures",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Sidebar(
              tiles: tiles,
              onSelectTile: setCurrentPage,
              currentIndex: _currentPage),
          pages[_currentPage],
        ],
      ),
    );
  }
}
