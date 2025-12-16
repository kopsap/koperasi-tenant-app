import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:koperasitenantapp/init/util/util.dart';
import 'package:koperasitenantapp/themes/colors.dart';
import 'package:koperasitenantapp/themes/dialogs/basic.dart';
import 'package:koperasitenantapp/init/util/nfc.dart';

Widget resultDialog({
  required BuildContext context,
  required bool isSuccess,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      return dialogTemplate(
        height: 200.0,
        component: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /**
             * 1. NFC Icon
             * 2. Label
             */
            Icon(isSuccess ? Icons.check_circle : Icons.warning, size: 100.0, color: isSuccess ? CustomColor.successColor : CustomColor.failedColor),
            SizedBox(height: 10.0),
            Text(
              isSuccess ? "Pembayaran berhasil!" : "Pembayaran gagal!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge!,
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
