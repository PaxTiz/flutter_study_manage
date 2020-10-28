import 'package:flutter/material.dart';
import 'package:macos_student/components/candidates/CandidateForm.dart';
import 'package:macos_student/pages/candidate/CandidateArgs.dart';

class CandidateCreate extends StatelessWidget {
  static const routeName = "/candidate/create";

  @override
  Widget build(BuildContext context) {
    final CandidateArgs args = ModalRoute.of(context).settings.arguments;

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
                  args.candidate == null
                      ? "Ajouter une candidature"
                      : "Modifier la candidature",
                  style: Theme.of(context).textTheme.headline1,
                )
              ],
            ),
            SizedBox(height: 32),
            CandidateForm(candidate: args.candidate)
          ],
        ),
      ),
    );
  }
}
