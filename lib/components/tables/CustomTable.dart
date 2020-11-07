import 'package:flutter/material.dart';

class CustomTable extends StatelessWidget {
  final List<double> columnsSize;
  final List<String> columnsHeader;
  final List<TableRow> columnsBody;

  const CustomTable(
      {@required this.columnsSize,
      @required this.columnsHeader,
      @required this.columnsBody})
      : assert(columnsSize.length == columnsHeader.length,
            "Il doit y avoir le même nombre de tailles de colonne que d'en-têtes");

  Map _buildColumnsSize() {
    Map<int, FixedColumnWidth> m = Map();
    for (int i = 0; i < columnsSize.length - 1; i++) {
      m[i] = FixedColumnWidth(columnsSize[i]);
    }

    return m;
  }

  TableRow _buildColumnsHeader(BuildContext context) {
    return TableRow(
        children: columnsHeader
            .map((e) => Text(e, style: Theme.of(context).textTheme.headline2))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    List<TableRow> children = [_buildColumnsHeader(context), ...columnsBody];
    return Table(
      columnWidths: _buildColumnsSize(),
      children: children,
    );
  }
}
