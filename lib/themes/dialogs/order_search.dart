import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:koperasitenantapp/init/util/util.dart';
import 'package:koperasitenantapp/themes/colors.dart';
import 'package:koperasitenantapp/themes/dialogs/basic.dart';
import 'package:koperasitenantapp/themes/widgets/buttons.dart';
import 'package:koperasitenantapp/themes/widgets/datepicker.dart';

Widget orderDialog({
  required BuildContext context,
  required DateTime startDate,
  required DateTime endDate,
  required int status,
  required Function onChange,
  required Function onReset,
}) {
  DateTime? localStartDt = startDate;
  DateTime? localEndDt = endDate;
  int? localStatus = status;

  return StatefulBuilder(
    builder: (context, setState) {
      return dialogTemplate(
        height: 500.0,
        component: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Filter data",
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SearchFormItem(
                  labelWidget: Text(
                    "Dari Tgl: ",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  valueWidget: Datepicker(
                    date: localStartDt,
                    onChange: (DateTime value) {
                      setState(() {
                        if (Util.date.compareDate(value, localEndDt!) < 0) {
                          localEndDt = value;
                        }
                        localStartDt = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 30.0),
                SearchFormItem(
                  labelWidget: Text(
                    "Sampai Tgl: ",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  valueWidget: Datepicker(
                    date: localEndDt,
                    onChange: (DateTime value) {
                      setState(() {
                        if (Util.date.compareDate(value, localStartDt!) > 0) {
                          localStartDt = value;
                        }
                        localEndDt = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 30.0),
                SearchFormItem(
                  labelWidget: Text(
                    "Status: ",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  valueWidget: DropdownButton(
                    dropdownColor: CustomColor.whiteColor,
                    value: localStatus,
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(child: Text("Belum Bayar"), value: 0),
                      DropdownMenuItem(child: Text("Sudah Bayar"), value: 1),
                    ],
                    onChanged: (value) {
                      setState(() {
                        localStatus = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SecondaryButton(
                    onPress: () {
                      context.pop();
                      onReset();
                    },
                    label: "Reset",
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: PrimaryButton(
                    onPress: () {
                      // Construct data fetched from datepicker and dropdown
                      // Call onchange to notify parent
                      onChange(localStartDt!, localEndDt!, localStatus!);
                      context.pop();
                    },
                    label: "Terapkan",
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

class SearchFormItem extends StatelessWidget {
  const SearchFormItem({
    super.key,
    required this.labelWidget,
    required this.valueWidget,
  });

  final Widget labelWidget;
  final Widget valueWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [labelWidget, SizedBox(height: 5.0), valueWidget],
    );
  }
}
