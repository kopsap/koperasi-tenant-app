import 'package:flutter/material.dart';
import 'package:koperasitenantapp/themes/colors.dart';

class CustomTableLimitDropdown extends StatefulWidget {
  CustomTableLimitDropdown({
    super.key,
    required this.limit,
    required this.onChange,
  });

  int limit;
  Function onChange;

  @override
  State<CustomTableLimitDropdown> createState() =>
      _CustomTableLimitDropdownState();
}

class _CustomTableLimitDropdownState extends State<CustomTableLimitDropdown> {
  final List limitOptions = [10, 25, 50, 100];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Limit", style: Theme.of(context).textTheme.labelLarge),
        SizedBox(height: 5.0),
        DropdownButton(
          dropdownColor: CustomColor.whiteColor,
          value: widget.limit,
          items: [
            ...limitOptions.map(
              (e) => DropdownMenuItem(child: Text(e.toString()), value: e),
            ),
          ],
          onChanged: (value) => widget.onChange(value),
        ),
      ],
    );
  }
}
