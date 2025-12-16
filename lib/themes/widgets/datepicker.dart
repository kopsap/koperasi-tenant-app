import 'package:flutter/material.dart';
import 'package:koperasitenantapp/init/util/util.dart';
import 'package:koperasitenantapp/themes/colors.dart';

class Datepicker extends StatefulWidget {
  Datepicker({
    super.key,
    this.date,
    required this.onChange,
    this.format = "d M Y",
  });

  final DateTime? date;
  final Function onChange;
  String format;

  @override
  State<Datepicker> createState() => _DatepickerState();
}

class _DatepickerState extends State<Datepicker> {
  final DateTime _today = Util.date.getToday();
  DateTime? _defaultLastDate;
  DateTime? _defaultFirstDate;

  @override
  void initState() {
    super.initState();

    setState(() {
      _defaultFirstDate = Util.date.dateAddition(
        datetime: _today,
        addition: -1,
        type: DateAdditionType.year,
      );
      _defaultLastDate = Util.date.dateAddition(
        datetime: _today,
        addition: 1,
        type: DateAdditionType.day,
      );
    });
  }

  void _openDatePicker(callback) async {
    await showDatePicker(
      context: context,
      initialDate: widget.date,
      currentDate: widget.date,
      firstDate: _defaultFirstDate!,
      lastDate: _defaultLastDate!,
    ).then((pickedDate) {
      if (pickedDate != null) callback(pickedDate);
    });
  }

  void _updateDate(selectedDate) {
    setState(() {
      widget.onChange(selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openDatePicker((selectedDate) => _updateDate(selectedDate)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: CustomColor.darkColor),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              Util.date.datetimeFormat(
                datetime: widget.date,
                format: widget.format,
              ),
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Icon(Icons.date_range, color: CustomColor.primaryColor, size: 20.0),
          ],
        ),
      ),
    );
  }
}
