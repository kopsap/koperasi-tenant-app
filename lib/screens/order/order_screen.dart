import 'package:flutter/material.dart';
import 'package:koperasitenantapp/screens/order/order_body.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        // leading: Image.asset(Assets.logo),
        title: Text("Buat Pesanan", style: Theme.of(context).textTheme.titleLarge),
      ),
      body: SafeArea(child: OrderBody()),
    );
  }
}
