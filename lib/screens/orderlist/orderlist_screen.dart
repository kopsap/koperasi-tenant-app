import 'package:flutter/material.dart';
import 'package:koperasitenantapp/init/util/nfc.dart';
import 'package:koperasitenantapp/screens/orderlist/orderlist_body.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
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
        title: Text("Pesanan", style: Theme.of(context).textTheme.titleLarge),
      ),
      body: SafeArea(child: OrderListBody()),
    );
  }
}
