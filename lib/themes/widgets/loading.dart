import 'package:flutter/material.dart';
import 'package:koperasitenantapp/themes/colors.dart';

class Loading extends StatelessWidget {
  const Loading({super.key, this.textMessage = ""});

  final String? textMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularProgressIndicator(color: CustomColor.primaryColor),
        textMessage != ""
            ? Column(
              children: [
                SizedBox(height: 10.0),
                Text(textMessage!, style: Theme.of(context).textTheme.labelLarge),
              ],
            )
            : SizedBox(),
      ],
    );
  }
}
