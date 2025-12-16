import 'package:flutter/material.dart';
import 'package:koperasitenantapp/init/util/util.dart';
import 'package:koperasitenantapp/models/order/order_list_request.dart';
import 'package:koperasitenantapp/themes/dialogs/order_search.dart';

class OrderSearchBox extends StatefulWidget {
  const OrderSearchBox({super.key, required this.loadData});

  final Function loadData;

  @override
  State<OrderSearchBox> createState() => _OrderSearchBoxState();
}

class _OrderSearchBoxState extends State<OrderSearchBox> {
  final OrderListRequest _filter = OrderListRequest();

  @override
  void initState() {
    super.initState();

    // _filter.startDate = Util.date.getToday();
    // _filter.startDate = DateTime.parse(
    //   Util.date.datetimeFormat(format: "Y-m-d 00:00:00"),
    // );
    // _filter.endDate = Util.date.dateAddition(
    //   datetime: _filter.startDate,
    //   addition: 60,
    //   type: DateAdditionType.day,
    // );

    WidgetsBinding.instance.addPostFrameCallback((_) => _resetFilter());
  }

  void _applyFilter(startDate, endDate, status) {
    _filter.startDate = startDate;
    _filter.endDate = endDate;
    _filter.status = status;

    widget.loadData(_filter);
  }

  void _resetFilter() {
    final startDate = DateTime.parse(
      Util.date.datetimeFormat(format: "Y-m-d 00:00:00"),
    );
    final endDate = Util.date.dateAddition(
      datetime: _filter.startDate,
      addition: 60,
      type: DateAdditionType.day,
    );
    final status = 1;

    _applyFilter(startDate, endDate, status);
  }

  void _openSearchDialog() {
    showDialog(
      context: context,
      builder:
          (BuildContext context) => orderDialog(
            context: context,
            startDate: _filter.startDate!,
            endDate: _filter.endDate!,
            status: _filter.status!,
            onChange:
                (startDate, endDate, status) =>
                    _applyFilter(startDate, endDate, status),
            onReset: () => _resetFilter(),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () => _openSearchDialog(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Icon(Icons.filter_alt),
                Text(
                  "Terapkan Filter",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
