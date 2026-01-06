import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koperasitenantapp/bloc/auth_payment/auth_payment_bloc.dart';
import 'package:koperasitenantapp/bloc/order_detail/order_detail_bloc.dart';
import 'package:koperasitenantapp/init/util/util.dart';
import 'package:koperasitenantapp/models/auth/auth_request.dart';
import 'package:koperasitenantapp/screens/orderdetail/widget/orderdetail_item.dart';
import 'package:koperasitenantapp/service/payment.dart';
import 'package:koperasitenantapp/service/storage.dart';
import 'package:koperasitenantapp/themes/colors.dart';
import 'package:koperasitenantapp/themes/widgets/labelvalue.dart';
import 'package:koperasitenantapp/themes/widgets/loading.dart';
import 'package:koperasitenantapp/themes/widgets/refresh_message.dart';
import 'package:koperasitenantapp/themes/widgets/buttons.dart';

class OrderDetailBody extends StatefulWidget {
  const OrderDetailBody({super.key, required this.orderCode});

  final String orderCode;

  @override
  State<OrderDetailBody> createState() => _OrderDetailBodyState();
}

class _OrderDetailBodyState extends State<OrderDetailBody> {
  final AuthRequest _authRequest = AuthRequest(cardId: "", pin: "");

  @override
  void initState() {
    super.initState();
    _getOrder();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getOrder() async {
    final String? _token = await context.read<SecureStorage>().getToken();

    context.read<OrderDetailBloc>().add(
      OrderDetailRequested(_token!, widget.orderCode),
    );
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

      context.read<AuthPaymentBloc>().add(AuthPaymentRequested(_authRequest));
    });
  }

  void displaySnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailBloc, OrderDetailState>(
      builder: (context, state) {
        if (state is OrderDetailLoading) {
          return Loading();
        }

        if (state is OrderDetailLoadSuccess) {
          bool needRetry = state.data.status == 0;

          return CustomScrollView(
            slivers: [
              // Worker Info
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 10.0),
                      Text(
                        "Pesanan ${state.data.orderCode}",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 10.0),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LabelValue(
                                label: Text(
                                  "Tgl Pesan",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                value: Text(
                                  Util.date.datetimeFormat(
                                    datetime: state.data.createdAt!,
                                    format: "Y-m-d H:i",
                                  ),
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              LabelValue(
                                label: Text(
                                  "NI Karyawan",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                value: Text(
                                  "${state.data.workerId}",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              LabelValue(
                                label: Text(
                                  "Nama Karyawan",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                value: Text(
                                  "${state.data.workerName}",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              LabelValue(
                                label: Text(
                                  "Status Pembayaran",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                value: Text(
                                  state.data.statusMessage!,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium?.copyWith(
                                    color:
                                        state.data.status! > 0
                                            ? CustomColor.successColor
                                            : CustomColor.failedColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // List Pesanan
              SliverPadding(
                padding: EdgeInsets.all(10.0),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "List Pesanan",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 10.0),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Column(
                            children: [
                              ...List.generate(state.data.detail!.length, (
                                index,
                              ) {
                                var e = state.data.detail![index];
                                return OrderDetailItem(
                                  item: e,
                                  useBorder:
                                      index < (state.data.detail!.length - 1),
                                );
                              }),
                              ListTile(
                                title: Text(
                                  "Total",
                                  style: Theme.of(context).textTheme.labelLarge
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                trailing: Text(
                                  Util.currency(state.data.orderValue!),
                                  style: Theme.of(context).textTheme.labelLarge
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      // Button to Retry Payment
                      needRetry
                          ? PrimaryButton(
                            onPress: () => _openNFCPopup(),
                            label: "Lanjutkan Pembayaran",
                            icon: Icon(Icons.sync),
                          )
                          : SizedBox(height: 0),
                    ],
                  ),
                ),
              ),
            ],
          );
        }

        if (state is OrderDetailLoadFailed) {
          return RefreshMessage(
            onPress: () => _getOrder(),
            message: state.errorMessage,
          );
        }

        return SizedBox.shrink();
      },
    );
  }
}
