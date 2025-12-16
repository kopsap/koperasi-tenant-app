import 'package:flutter/material.dart';

class CustomTableCount extends StatefulWidget {
  CustomTableCount({super.key, required this.length});

  int length;

  @override
  State<CustomTableCount> createState() => _CustomTableCountState();
}

class _CustomTableCountState extends State<CustomTableCount> {
  @override
  Widget build(BuildContext context) {
    return Text("Jumlah data: ${widget.length.toString()}", style: Theme.of(context).textTheme.labelMedium);
  }
}
