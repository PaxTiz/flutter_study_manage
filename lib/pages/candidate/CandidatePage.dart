import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_student/components/CustomButton.dart';
import 'package:macos_student/models/Candidate.dart';
import 'package:macos_student/pages/candidate/CandidateArgs.dart';
import 'package:macos_student/pages/candidate/CandidateCreate.dart';
import 'package:macos_student/services/CandidateService.dart';

class CandidatePage extends StatelessWidget {
  final service = CandidateService();

  void _updateCandidate(BuildContext context, Candidate candidate) {
    Navigator.pushNamed(context, CandidateCreate.routeName,
        arguments: CandidateArgs(candidate));
  }

  Future<void> _deleteCandidate(Candidate candidate) async {
    await service.deleteCandidate(candidate);
  }

  List buildTableData(BuildContext context, List<Candidate> candidates) {
    final data = [
      TableRow(children: [
        Text("#", style: Theme.of(context).textTheme.headline2),
        Text("Organisation", style: Theme.of(context).textTheme.headline2),
        Text("Email", style: Theme.of(context).textTheme.headline2),
        Text("Réponse", style: Theme.of(context).textTheme.headline2),
        Text("Actions", style: Theme.of(context).textTheme.headline2),
      ]),
    ];
    data.addAll(candidates.map((e) => TableRow(children: [
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              e.id.toString(),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              e.companyName,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              e.email,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              e.response,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => _updateCandidate(context, e),
                  child: Chip(
                    backgroundColor: Theme.of(context).hintColor,
                    label: Text("Modifier"),
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () => _deleteCandidate(e),
                  child: Chip(
                    backgroundColor: Colors.red,
                    label: Text("Supprimer"),
                  ),
                )
              ],
            ),
          ),
        ])));

    return data;
  }

  Table buildTable(List<TableRow> rows) => Table(
        columnWidths: {
          0: FixedColumnWidth(50),
          1: FixedColumnWidth(150),
          2: FixedColumnWidth(150),
          3: FixedColumnWidth(200),
          4: FixedColumnWidth(250),
        },
        children: rows,
      );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Candidate>>(
        future: service.getAll(),
        initialData: [],
        builder: (context, snapshot) {
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
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data != null)
                buildTable(buildTableData(context, snapshot.data))
              else if (snapshot.connectionState == ConnectionState.waiting)
                CircularProgressIndicator()
              else
                Text(
                  "Aucune candidature...",
                  style: Theme.of(context).textTheme.headline2,
                )
            ],
          );
        });
  }
}
