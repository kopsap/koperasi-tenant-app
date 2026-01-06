import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:koperasitenantapp/bloc/auth/auth_bloc.dart';

import 'package:koperasitenantapp/bloc/auth_payment/auth_payment_bloc.dart';
import 'package:koperasitenantapp/bloc/order_process/order_process_bloc.dart';
import 'package:koperasitenantapp/init/util/nfc.dart';
import 'package:koperasitenantapp/models/auth/auth.dart';
import 'package:koperasitenantapp/models/auth/auth_request.dart';
import 'package:koperasitenantapp/models/order/order_create_request.dart';
import 'package:koperasitenantapp/models/order/order_item.dart';
import 'package:koperasitenantapp/models/order/order_payment_request.dart';
import 'package:koperasitenantapp/service/payment.dart';
import 'package:koperasitenantapp/service/storage.dart';
import 'package:koperasitenantapp/themes/colors.dart';
import 'package:koperasitenantapp/themes/dialogs/nfc.dart';
import 'package:koperasitenantapp/themes/dialogs/pin.dart';
import 'package:koperasitenantapp/themes/dialogs/result.dart';
import 'package:koperasitenantapp/themes/widgets/buttons.dart';
import 'package:koperasitenantapp/themes/widgets/loading.dart';

class OrderBody extends StatefulWidget {
  const OrderBody({super.key});

  @override
  State<OrderBody> createState() => _OrderBodyState();
}

class _OrderBodyState extends State<OrderBody> {
  final OrderCreateRequest _orderRequest = OrderCreateRequest(
    authToken: "",
    orderItems: [],
    orderNotes: "Pembayaran melalui aplikasi.",
  );
  final AuthRequest _authRequest = AuthRequest(cardId: "", pin: "");
  final OrderPaymentRequest _paymentRequest = OrderPaymentRequest(
    authToken: "",
  );
  final TextEditingController _price = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _closeNfcReader() {
    print("Closing NFC Reader!");
    NFCReader.closeNfc();
  }

  @override
  void dispose() {
    super.dispose();
    _closeNfcReader();
  }

  void _openNFCPopup() async {
    context.read<PaymentProcess>().nfcPopup(context, (cardId, pin) {
      /**
       * 1. Auth Card
       * 2. Create Order
       * 3. Payment
       */
      // Auth Card
      _authRequest.cardId = cardId;
      _authRequest.pin = pin;

      if (!_authRequest.allowLogin()) {
        displaySnackBar("PIN harus diisi!");
        return;
      }

      context.read<AuthPaymentBloc>().add(
        AuthPaymentRequested(_authRequest),
      );
    });
  }

  void _resultPopup(bool isSuccess) async {
    final dialog = await showDialog(
      context: context,
      builder:
          (BuildContext context) =>
              resultDialog(context: context, isSuccess: isSuccess),
    );

    if (dialog == null) {
      _closeNfcReader();

      if (isSuccess) {
        context.goNamed("home");
      } else {
        Navigator.pop(context);
      }
    }
  }

  void displaySnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void createOrder() {
    context.read<OrderProcessBloc>().add(OrderProcessCreate(_orderRequest));
  }

  void paymentOrder(String orderCode) {
    context.read<OrderProcessBloc>().add(
      OrderProcessPayment(orderCode, _paymentRequest),
    );
  }

  // Form:
  // 1. Isi tagihan
  // 2. Open NFC Connection
  // 3. Read Card
  // 4. API Call
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthPaymentBloc, AuthPaymentState>(
          listener: (_, state) async {
            if (state is AuthPaymentLoadSuccess) {
              final String? _token =
                  await context.read<SecureStorage>().getToken();
              _orderRequest.authToken = _token!;
              final Auth data =
                  await context.read<SecureStorage>().getCredentials();
              final String? merchantCode = data.workerId;

              _orderRequest.orderItems = [];
              _orderRequest.orderItems.add(
                OrderItem(
                  productCode: merchantCode!,
                  qty: 1,
                  price: double.parse(_price.text),
                ),
              );
              _orderRequest.orderNotes = "Pembayaran melalui aplikasi tenant";

              createOrder();

              _paymentRequest.authToken = state.data.authToken!;
            }

            if (state is AuthPaymentLoadFailed) {
              displaySnackBar(state.errorMessage);
            }
          },
        ),
        BlocListener<OrderProcessBloc, OrderProcessState>(
          listener: (_, state) async {
            if (state is OrderProcessCreateSuccess) {
              // Call payment
              paymentOrder(state.orderCode);
            }

            if (state is OrderProcessPaymentSuccess) {
              _resultPopup(true);
            }

            if (state is OrderProcessLoadFailed) {
              _resultPopup(false);
            }
          },
        ),
      ],
      child: Container(
        padding: EdgeInsets.fromLTRB(30.0, 90.0, 30.0, 15.0),
        child: Column(
          children: [
            /**
                 * Start
                 * -->
                 * Number Input => Validation
                 * Button to Submit
                 * -->
                 * Popup alert to tap card, open NFC
                 * -->
                 * If detected fetch ID and call API
                 * Else wait till 30 secs, then show close button
                 * -->
                 * Done
                 */
            Column(
              children: [
                Text(
                  "Tagihan Belanja",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  "Masukkan total belanja karyawan disini",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            SizedBox(height: 30.0),
            TextFormField(
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: _price,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.money),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 2.0,
                  horizontal: 5.0,
                ),
                border: OutlineInputBorder(),
                labelText: 'Harga Total',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelStyle: Theme.of(context).textTheme.labelLarge,
              ),
              style: Theme.of(context).textTheme.labelLarge,
              onFieldSubmitted: (v) {
                // Open popup alert
                _openNFCPopup();
              },
            ),
            SizedBox(height: 15.0),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    onPress: () {
                      print(_price.text);
                      if (_price.text != "") {
                        _openNFCPopup();
                      } else {
                        displaySnackBar("Harga harus diisi!");
                      }
                    },
                    label: "Simpan",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
