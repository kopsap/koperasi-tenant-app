import 'package:flutter/material.dart';
import 'package:koperasitenantapp/themes/colors.dart';
import 'package:koperasitenantapp/themes/widgets/table/widget/table_count.dart';
import 'package:koperasitenantapp/themes/widgets/table/widget/table_limitdropdown.dart';

class CustomTable extends StatefulWidget {
  CustomTable({
    super.key,
    required this.columnCount,
    required this.header,
    required this.data,
    this.start = 0,
    this.limit = 0,
    this.onUpdatePage,
    this.onUpdateLimit,
  });

  int columnCount;
  List<String> header;
  List<List> data;

  int start;
  int limit;

  Function? onUpdatePage;
  Function? onUpdateLimit;

  @override
  State<CustomTable> createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  Map<int, TableColumnWidth> _generateColumns() {
    Map<int, TableColumnWidth> columns = {};

    for (var i = 0; i < widget.columnCount; i++) {
      columns[i] = FlexColumnWidth();
    }

    return columns;
  }

  @override
  Widget build(BuildContext context) {
    final headerStyle = Theme.of(context).textTheme.titleSmall;
    final bodyStyle = Theme.of(context).textTheme.labelMedium;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.limit > 0)
          CustomTableLimitDropdown(
            limit: widget.limit,
            onChange: (value) => widget.onUpdateLimit!(value),
          ),
        Table(
          border: TableBorder.all(),
          columnWidths: _generateColumns(),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              children: [
                ...widget.header.map((label) {
                  return Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(label, style: headerStyle),
                  );
                }),
              ],
            ),
            ...widget.data.map((values) {
              return TableRow(
                children: [
                  ...values.map(
                    (value) => Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(value ?? "", style: bodyStyle),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
        SizedBox(height: 5.0),
        if (widget.limit > 0) CustomTableCount(length: widget.data.length),
      ],
    );
  }
}
