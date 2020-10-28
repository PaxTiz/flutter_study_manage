import 'package:flutter/material.dart';
import 'package:macos_student/components/CustomButton.dart';
import 'package:macos_student/models/Candidate.dart';
import 'package:macos_student/pages/candidate/CandidateArgs.dart';
import 'package:macos_student/pages/candidate/CandidateCreate.dart';
import 'package:macos_student/services/CandidateService.dart';

class CandidatePage extends StatelessWidget {
  final service = CandidateService();

  void updateCandidate(BuildContext context, Candidate candidate) {
    Navigator.pushNamed(context, CandidateCreate.routeName,
        arguments: CandidateArgs(candidate));
  }

  Widget buildListCandidates(BuildContext ctx, List<Candidate> candidates) =>
      (candidates == null || candidates.isEmpty)
          ? Text("Aucune candidature..",
              style: Theme.of(ctx).textTheme.headline6)
          : ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: candidates.length,
              itemBuilder: (context, index) => Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: Text(
                      candidates[index].id.toString(),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(candidates[index].companyName,
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(
                        candidates[index].email.isEmpty
                            ? "❌"
                            : candidates[index].email,
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(candidates[index].response,
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                  SizedBox(
                    width: 100,
                    child: CustomButton(
                      text: "Modifier",
                      action: () => updateCandidate(context, candidates[index]),
                    ),
                  )
                ],
              ),
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                height: 8,
              ),
            );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Mes candidatures",
              style: Theme.of(context).textTheme.headline1,
            ),
            CustomButton(
              text: "Nouvelle candidature",
              action: () => Navigator.pushNamed(
                  context, CandidateCreate.routeName,
                  arguments: CandidateArgs(null)),
            )
          ],
        ),
        SizedBox(height: 32),
        Row(
          children: [
            SizedBox(
              width: 50,
              child: Text("#", style: Theme.of(context).textTheme.headline2),
            ),
            SizedBox(
              width: 150,
              child: Text("Organisation",
                  style: Theme.of(context).textTheme.headline2),
            ),
            SizedBox(
              width: 150,
              child:
                  Text("Email", style: Theme.of(context).textTheme.headline2),
            ),
            SizedBox(
              width: 200,
              child:
                  Text("Réponse", style: Theme.of(context).textTheme.headline2),
            ),
            SizedBox(
              width: 100,
              child:
                  Text("Action", style: Theme.of(context).textTheme.headline2),
            ),
          ],
        ),
        SizedBox(height: 16),
        FutureBuilder<List<Candidate>>(
          future: service.getAll(),
          initialData: [],
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.done
                  ? buildListCandidates(context, snapshot.data)
                  : CircularProgressIndicator(),
        ),
      ],
    );
  }
}
