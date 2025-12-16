import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:koperasitenantapp/init/util/nfc.dart';
import 'package:koperasitenantapp/screens/orderdetail/orderdetail_body.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({
    super.key,
    required this.orderCode,
    required this.extras,
  });

  final String orderCode;
  final Map extras;

  @override
  State<OrderDetailScreen> createState() => _WorkerDetailScreenState();
}

class _WorkerDetailScreenState extends State<OrderDetailScreen> {
  @override
  void initState() {
    super.initState();
    NFCReader.startNfc(onDetected: () {});
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          // leading: Image.asset(Assets.logo),
          title: Text(
            "Detil Pesanan",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: SafeArea(child: OrderDetailBody(orderCode: widget.orderCode)),
      );
  }
}
