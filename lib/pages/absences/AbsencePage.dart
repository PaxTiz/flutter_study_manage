import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_student/components/CustomButton.dart';
import 'package:macos_student/components/tables/CustomTable.dart';
import 'package:macos_student/models/Absence.dart';
import 'package:macos_student/pages/absences/AbsenceArgs.dart';
import 'package:macos_student/pages/absences/AbsenceCreate.dart';
import 'package:macos_student/services/AbsenceService.dart';
import 'package:provider/provider.dart';

class AbsencePage extends StatelessWidget {
  final service = AbsenceService();

  void _increment(Absence absence) async {
    await service.increment(absence);
  }

  void _update(BuildContext context, Absence absence) {
    Navigator.pushNamed(context, AbsenceCreate.routeName,
        arguments: AbsenceArgs(absence));
  }

  List _buildTableBody(BuildContext context, List<Absence> absences) {
    return absences
        .map((e) => TableRow(
                decoration: BoxDecoration(
                  color: e.availableHours == 0
                      ? Colors.red.shade400
                      : Colors.transparent,
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      e.subject,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      "${e.totalHours}",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      "${e.allowedHours}",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      "${e.missedHours}",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 8),
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
                ]))
        .toList();
  }

  CustomTable buildTable(BuildContext context, List<Absence> absences) {
    List<double> width = [200, 150, 150, 150, 150, 250];
    List<String> header = [
      "Matière",
      "Heures totales",
      "Absences possibles",
      "Cours manqués",
      "Heures restantes",
      "Actions"
    ];

    return CustomTable(
      columnsSize: width,
      columnsHeader: header,
      columnsBody: _buildTableBody(context, absences),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureProvider<List<Absence>>.value(
        initialData: [],
        value: service.getAll(),
        child: Column(
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
            Consumer<List<Absence>>(
              builder: (context, absences, _) {
                if (absences == null)
                  return CircularProgressIndicator();
                else if (absences.length > 0)
                  return buildTable(context, absences);
                else
                  return Text(
                    "Aucune absence, bravo !",
                    style: Theme.of(context).textTheme.headline2,
                  );
              },
            ),
          ],
        ));
  }
}
