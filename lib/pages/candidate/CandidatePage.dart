import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_student/components/CustomButton.dart';
import 'package:macos_student/components/tables/CustomTable.dart';
import 'package:macos_student/models/Candidate.dart';
import 'package:macos_student/pages/candidate/CandidateArgs.dart';
import 'package:macos_student/pages/candidate/CandidateCreate.dart';
import 'package:macos_student/services/CandidateService.dart';
import 'package:provider/provider.dart';

class CandidatePage extends StatelessWidget {
  final service = CandidateService();

  void _updateCandidate(BuildContext context, Candidate candidate) {
    Navigator.pushNamed(context, CandidateCreate.routeName,
        arguments: CandidateArgs(candidate));
  }

  Future<void> _deleteCandidate(Candidate candidate) async {
    await service.delete(candidate);
  }

  List<TableRow> _buildTableBody(
      BuildContext context, List<Candidate> candidates) {
    return candidates
        .map((e) => TableRow(children: [
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
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: () => _updateCandidate(context, e),
                    ),
                    SizedBox(width: 8),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.white),
                      onPressed: () => _deleteCandidate(e),
                    ),
                  ],
                ),
              ),
            ]))
        .toList();
  }

  CustomTable _buildTable(BuildContext context, List<Candidate> candidates) {
    List<double> width = [50, 150, 150, 200, 250];
    List<String> header = ["#", "Organisation", "Email", "Réponse", "Actions"];

    return CustomTable(
        columnsSize: width,
        columnsHeader: header,
        columnsBody: _buildTableBody(context, candidates));
  }

  @override
  Widget build(BuildContext context) {
    return FutureProvider<List<Candidate>>.value(
      value: service.getAll(),
      child: Column(
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

          Consumer<List<Candidate>>(
            builder: (context, candidates, _) {
              if (candidates == null)
                return CircularProgressIndicator();
              else if (candidates.length > 0)
                return _buildTable(context, candidates);
              else
                return Text(
                  "Aucune candidature...",
                  style: Theme.of(context).textTheme.headline2,
                );
            },
          )
        ],
      ),
    );
  }
}
