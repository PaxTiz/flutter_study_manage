import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_student/components/CustomButton.dart';
import 'package:macos_student/models/Absence.dart';
import 'package:macos_student/pages/absences/AbsenceArgs.dart';
import 'package:macos_student/pages/absences/AbsenceCreate.dart';
import 'package:macos_student/services/AbsenceService.dart';

class AbsencePage extends StatelessWidget {
  final service = AbsenceService();

  void _increment(Absence absence) async {
    await service.increment(absence);
  }

  void _update(BuildContext context, Absence absence) {
    Navigator.pushNamed(context, AbsenceCreate.routeName,
        arguments: AbsenceArgs(absence));
  }

  List buildTableData(BuildContext context, List<Absence> absences) {
    final data = [
      TableRow(children: [
        Text("Matière", style: Theme.of(context).textTheme.headline2),
        Text("Heures totales", style: Theme.of(context).textTheme.headline2),
        Text("Absences possibles",
            style: Theme.of(context).textTheme.headline2),
        Text("Cours manqués", style: Theme.of(context).textTheme.headline2),
        Text("Heures restantes", style: Theme.of(context).textTheme.headline2),
        Text("Actions", style: Theme.of(context).textTheme.headline2),
      ]),
    ];
    data.addAll(absences.map((e) => TableRow(
            decoration: BoxDecoration(
              color: e.availableHours == 0
                  ? Colors.red.shade400
                  : Colors.transparent,
            ),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  e.subject,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "${e.totalHours}",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "${e.allowedHours}",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "${e.missedHours}",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "${e.availableHours}",
                    style: Theme.of(context).textTheme.bodyText1,
                  )),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.add, color: Colors.white),
                      onPressed: () => _increment(e),
                    ),
                    SizedBox(width: 8),
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.white),
                      onPressed: () => _update(context, e),
                    )
                  ],
                ),
              )
            ])));

    return data;
  }

  Table buildTable(List<TableRow> rows) => Table(
        columnWidths: {
          0: FixedColumnWidth(200),
          1: FixedColumnWidth(150),
          2: FixedColumnWidth(150),
          3: FixedColumnWidth(150),
          4: FixedColumnWidth(150),
          5: FixedColumnWidth(250),
        },
        children: rows,
      );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Absence>>(
        future: service.getAll(),
        initialData: [],
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // TODO: Get total absences count to show to user
                  Text(
                    "Mes absences",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  CustomButton(
                    text: "Nouvelle absence",
                    action: () => Navigator.pushNamed(
                        context, AbsenceCreate.routeName,
                        arguments: AbsenceArgs(null)),
                  )
                ],
              ),
              SizedBox(height: 32),
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data != null)
                buildTable(buildTableData(context, snapshot.data))
              else if (snapshot.connectionState == ConnectionState.waiting)
                CircularProgressIndicator()
              else
                Text(
                  "Aucune absence, bravo !",
                  style: Theme.of(context).textTheme.headline2,
                )
            ],
          );
        });
  }
}
