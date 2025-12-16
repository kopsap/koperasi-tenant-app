import 'package:flutter/material.dart';
import 'package:koperasitenantapp/themes/colors.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: CustomColor.primaryColor),
    );
  }
}
