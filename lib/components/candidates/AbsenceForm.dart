import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_student/components/CustomButton.dart';
import 'package:macos_student/components/forms/CustomFormField.dart';
import 'package:macos_student/models/Absence.dart';
import 'package:macos_student/services/AbsenceService.dart';

import '../../application.dart';

// TODO: Add validator for inputs
class AbsenceForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final subjectController = TextEditingController();
  final totalHoursController = TextEditingController();
  final allowedHoursController = TextEditingController();
  final missedHoursController = TextEditingController();
  final AbsenceService service = AbsenceService();

  final Absence absence;

  AbsenceForm({@required this.absence});

  void _handleForm(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      if (absence == null) {
        Absence a = Absence(
          subject: subjectController.value.text,
          totalHours: int.parse(totalHoursController.value.text),
          allowedHours: int.parse(allowedHoursController.value.text),
          missedHours: int.parse(missedHoursController.value.text),
          availableHours: int.parse(allowedHoursController.value.text) -
              int.parse(missedHoursController.value.text),
        );
        await service.insert(a);
      } else {
        absence.subject = subjectController.value.text;
        absence.totalHours = int.parse(totalHoursController.value.text);
        absence.allowedHours = int.parse(allowedHoursController.value.text);
        absence.missedHours = int.parse(missedHoursController.value.text);
        absence.availableHours = int.parse(allowedHoursController.value.text) -
            int.parse(missedHoursController.value.text);
        await service.update(absence);
      }

      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => Application(1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomFormField(
              controller: subjectController,
              hintText: "Matière",
              errorText: "Veuillez entrer le nom de la matière",
              initialValue: absence == null ? "" : absence.subject,
              empty: false,
            ),
            SizedBox(height: 16),
            CustomFormField(
              controller: totalHoursController,
              hintText: "Nombre d'heures totales",
              errorText:
                  "Veuillez entrer le nombre d'heures totales de cette matière",
              initialValue: absence == null ? "" : "${absence.totalHours}",
              empty: false,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            CustomFormField(
              controller: allowedHoursController,
              hintText:
                  "Nombre d'heures manquées autorisées (généralement 10%)",
              errorText:
                  "Veuillez entrer le nombre d'heures manquées autorisées",
              initialValue: absence == null ? "" : "${absence.allowedHours}",
              empty: false,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            CustomFormField(
              controller: missedHoursController,
              hintText: "Nombre d'heures manquées",
              errorText:
                  "Veuillez entrer le nombre d'heures manquées à cet instant",
              initialValue: absence == null ? "" : "${absence.missedHours}",
              empty: false,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            CustomButton(
              text: "Valider",
              action: () => _handleForm(context),
            )
          ],
        ),
      ),
    );
  }
}
