import 'package:flutter/material.dart';
import 'package:macos_student/components/candidates/AbsenceForm.dart';
import 'package:macos_student/pages/absences/AbsenceArgs.dart';

class AbsenceCreate extends StatelessWidget {
  static const routeName = "/absence/create";

  @override
  Widget build(BuildContext context) {
    final AbsenceArgs args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(width: 32),
                Text(
                  args.absence == null
                      ? "Ajouter une absence"
                      : "Modifier l'absence",
                  style: Theme.of(context).textTheme.headline1,
                )
              ],
            ),
            SizedBox(height: 32),
            AbsenceForm(absence: args.absence)
          ],
        ),
      ),
    );
  }
}
