import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:koperasitenantapp/bloc/order_process/order_process_bloc.dart';
import 'package:koperasitenantapp/init/util/util.dart';
import 'package:koperasitenantapp/themes/colors.dart';
import 'package:koperasitenantapp/themes/dialogs/basic.dart';
import 'package:koperasitenantapp/init/util/nfc.dart';
import 'package:koperasitenantapp/themes/widgets/buttons.dart';
import 'package:koperasitenantapp/themes/widgets/loading.dart';

Widget pinDialog({required BuildContext context, required Function onSubmit}) {
  final TextEditingController _pin = TextEditingController();

  return StatefulBuilder(
    builder: (context, setState) {
      return dialogTemplate(
        height: 200.0,
        component: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /**
             * Input PIN
             */
            TextFormField(
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              controller: _pin,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 2.0,
                  horizontal: 5.0,
                ),
                border: OutlineInputBorder(),
                labelText: 'Masukkan 6-digit pin disini',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelStyle: Theme.of(context).textTheme.labelLarge,
              ),
              obscureText: true,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(height: 15.0),
            BlocBuilder<OrderProcessBloc, OrderProcessState>(
              builder: (_, state) {
                if (state is OrderProcessLoading) {
                  return Loading();
                }

                return PrimaryButton(
                  onPress: () {
                    String textValidation = "";

                    if (_pin.value.text == "") {
                      textValidation = "PIN harus diisi!";
                    } else if (_pin.value.text.length < 6) {
                      textValidation = "PIN harus 6 digit!";
                    }

                    if (textValidation != "") {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(textValidation)));
                    } else {
                      onSubmit(_pin.value.text);
                    }
                  },
                  label: "Enter",
                );
              },
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
