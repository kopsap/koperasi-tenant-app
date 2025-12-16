import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:koperasitenantapp/init/util/util.dart';
import 'package:koperasitenantapp/models/order/order.dart';
import 'package:koperasitenantapp/themes/colors.dart';

class OrderCardItem extends StatelessWidget {
  const OrderCardItem({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap:
            () => context.goNamed(
              'orderDetail',
              extra: {
                "orderCode": order.orderCode,
                "previous": {"page": "order", "extras": null},
              },
            ),
        title: Text(
          order.orderCode!,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tgl: ${Util.date.datetimeFormat(datetime: order.createdAt, format: "Y-m-d H:i:s")}",
              style: Theme.of(context).textTheme.labelSmall,
            ),
            Text(
              "Pembeli: [${order.workerId}] ${order.workerName}",
              style: Theme.of(context).textTheme.labelSmall,
            ),
            Text(
              "Total Pesanan: ${Util.currency(order.orderValue ?? 0)}",
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
        trailing: Container(
          width: 120.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                order.statusMessage!,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color:
                      (order.status ?? 0) > 0
                          ? CustomColor.successColor
                          : CustomColor.failedColor,
                ),
              ),
              Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
