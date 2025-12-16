import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/nfc_manager_android.dart';

class NFCReader {
  NFCReader();

  static bool _isActive = false;
  static bool _isAvailable = false;

  static void checkAvailability() async {
    _isAvailable = await NfcManager.instance.isAvailable();
    print("NFC Availability: $_isAvailable");
  }

  static void startNfc({required Function onDetected}) async {
    if (!_isAvailable) return;

    if (_isActive) {
      closeNfc();
      await Future.delayed(Duration(milliseconds: 300));
    }

    print("NFC Feature Supported!");
    _isActive = true;

    // Start the session.
    print("Starting card detect session!");
    NfcManager.instance.startSession(
      pollingOptions: {
        NfcPollingOption.iso14443,
      }, // You can also specify iso18092 and iso15693.
      onDiscovered: (NfcTag tag) {
        onDetected(detectCard(tag));
      },
      onSessionErrorIos: (e) {
        print(e.toString());
      },
      alertMessageIos: "Hold your card!",
    );
  }

  static String detectCard(NfcTag tag) {
    try {
      // Do something with an NfcTag instance...
      final NfcAAndroid? nfca = NfcAAndroid.from(tag);
      final uid = nfca?.tag.id;
      final uidHexString =
          uid?.map((e) => e.toRadixString(16).padLeft(2, '0')).join();

      // print(uidHexString); // This ID will be used for Card Identifier

      return uidHexString!.toUpperCase();
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  static void closeNfc() {
    if (!_isActive) return;

    // Stop the session when no longer needed.
    print("Closing session!");
    NfcManager.instance.stopSession();
    _isActive = false;
  }
}
