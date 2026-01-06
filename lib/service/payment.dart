import 'package:flutter/material.dart';
import 'package:koperasitenantapp/init/util/nfc.dart';
import 'package:koperasitenantapp/themes/dialogs/nfc.dart';
import 'package:koperasitenantapp/themes/dialogs/pin.dart';

class PaymentProcess {
  void nfcPopup(BuildContext parentContext, Function onSuccess) async {
    // Open Dialog
    final dialog = await showDialog(
      context: parentContext,
      builder:
          (BuildContext context) => nfcDialog(
            context: context,
            onDetected: (uid) {
              Navigator.pop(context, true);
              pinPopup(parentContext, uid, onSuccess);
            },
          ),
    );

    if (dialog == null) NFCReader.closeNfc();
  }

  void pinPopup(
    BuildContext parentContext,
    String cardId,
    Function onSuccess,
  ) async {
    // Open another dialog
    final dialog = await showDialog(
      context: parentContext,
      builder:
          (BuildContext context) => pinDialog(
            context: context,
            onSubmit: (pin) {
              onSuccess(cardId, pin);
            },
          ),
    );

    if (dialog == null) NFCReader.closeNfc();
  }
}
