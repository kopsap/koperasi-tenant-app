import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koperasitenantapp/bloc/order/order_bloc.dart';
import 'package:koperasitenantapp/models/order/order_list_request.dart';
import 'package:koperasitenantapp/screens/orderlist/widget/order_carditem.dart';
import 'package:koperasitenantapp/screens/orderlist/widget/order_searchbox.dart';
import 'package:koperasitenantapp/service/storage.dart';
import 'package:koperasitenantapp/themes/widgets/loading.dart';
import 'package:koperasitenantapp/themes/widgets/refresh_message.dart';

class OrderListBody extends StatefulWidget {
  const OrderListBody({super.key});

  @override
  State<OrderListBody> createState() => _OrderListBodyState();
}

class _OrderListBodyState extends State<OrderListBody> {
  final OrderListRequest _filter = OrderListRequest();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getOrder(OrderListRequest filter) async {
    final String? _token = await context.read<SecureStorage>().getToken();

    setState(() {
      _filter.startDate = filter.startDate;
      _filter.endDate = filter.endDate;
      _filter.status = filter.status;
      _filter.start = filter.start;
      _filter.limit = filter.limit;
      context.read<OrderBloc>().add(OrderRequested(_token!, filter));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OrderSearchBox(loadData: (filter) => _getOrder(filter)),
        Expanded(
          child: BlocBuilder<OrderBloc, OrderState>(
            builder: (_, state) {
              if (state is OrderLoading) {
                return Loading();
              }

              if (state is OrderLoadSuccess) {
                return state.data.isNotEmpty
                    ? CustomScrollView(
                      slivers: [
                        SliverPadding(
                          padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 25.0),
                          sliver: SliverToBoxAdapter(
                            child: Column(
                              children: [
                                ...state.data.map((e) {
                                  return OrderCardItem(order: e);
                                }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                    : Center(
                      child: Text(
                        "Data tidak ada",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    );
              }

              if (state is OrderLoadFailed) {
                return RefreshMessage(
                  onPress: () => _getOrder(OrderListRequest()),
                  message: state.errorMessage,
                );
              }

              return SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
