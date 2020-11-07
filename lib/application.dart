import 'package:flutter/material.dart';
import 'package:macos_student/components/Sidebar.dart';
import 'package:macos_student/pages/CustomPage.dart';
import 'package:macos_student/pages/absences/AbsencePage.dart';
import 'package:macos_student/pages/candidate/CandidatePage.dart';

class Application extends StatefulWidget {
  int _currentPage = 0;

  Application(this._currentPage);
  createState() => _Application();
}

class _Application extends State<Application> {
  void setCurrentPage(int index) => setState(() => widget._currentPage = index);

  final pages = <CustomPage>[
    CustomPage(
      child: Text("Hello World"),
    ),
    CustomPage(
      child: AbsencePage(),
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
              currentIndex: widget._currentPage),
          pages[widget._currentPage],
        ],
      ),
    );
  }
}
