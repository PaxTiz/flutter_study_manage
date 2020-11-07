import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_student/application.dart';
import 'package:macos_student/components/CustomButton.dart';
import 'package:macos_student/components/forms/CustomFormField.dart';
import 'package:macos_student/models/Candidate.dart';
import 'package:macos_student/services/CandidateService.dart';

class CandidateForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final responseController = TextEditingController();
  final CandidateService service = CandidateService();

  final Candidate candidate;

  CandidateForm({@required this.candidate});

  void _handleForm(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      if (candidate == null) {
        Candidate c = Candidate(
            companyName: nameController.value.text,
            email: emailController.value.text,
            response: responseController.value.text);
        await service.insert(c);
      } else {
        candidate.companyName = nameController.value.text;
        candidate.email = emailController.value.text;
        candidate.response = responseController.value.text;
        await service.update(candidate);
      }

      Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => Application(2),
          ));
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
              controller: nameController,
              hintText: "Nom de l'organisation",
              errorText: "Veuillez entrer le nom de l'organisation",
              initialValue: candidate == null ? "" : candidate.companyName,
              empty: false,
            ),
            SizedBox(height: 16),
            CustomFormField(
              controller: emailController,
              hintText: "Adresse email du correspondant",
              initialValue: candidate == null ? "" : candidate.email,
            ),
            SizedBox(height: 16),
            CustomFormField(
              controller: responseController,
              hintText: "Réponse obtenue",
              initialValue: candidate == null ? "" : candidate.response,
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
