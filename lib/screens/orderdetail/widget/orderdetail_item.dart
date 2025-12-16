import 'package:flutter/material.dart';
import 'package:koperasitenantapp/init/util/util.dart';
import 'package:koperasitenantapp/models/order/order_detail.dart';
import 'package:koperasitenantapp/themes/colors.dart';

class OrderDetailItem extends StatelessWidget {
  const OrderDetailItem({
    super.key,
    required this.item,
    required this.useBorder,
  });

  final OrderDetail item;
  final bool useBorder;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(
        "[${item.productCode}] ${item.productName}",
        style: Theme.of(
          context,
        ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${item.quantity}x @${Util.currency(item.price!)}",
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
      trailing: Text(
        Util.currency(item.quantity! * item.price!),
        style: Theme.of(
          context,
        ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
      shape: Border(
        bottom: BorderSide(
          color: useBorder ? CustomColor.borderColor : CustomColor.darkColor,
          width: 1.0,
        ),
      ),
    );
  }
}
