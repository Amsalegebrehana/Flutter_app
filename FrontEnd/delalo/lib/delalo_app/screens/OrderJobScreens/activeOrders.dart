import 'package:delalo/routeGenerator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:delalo/delalo_app/blocs/blocs.dart';
import 'package:delalo/delalo_app/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'orderDetails_screen.dart';

class ActiveOrders extends StatelessWidget {
  ActiveOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String seeker_id = "61332f182eb4f64398fa7676";
    final orderBloc = BlocProvider.of<OrderBloc>(context);
    orderBloc.add(ActiveOrdersLoad(seeker_id));

    return Scaffold(
      body: Center(
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (_, orderState) {
            if (orderState is Loading) {
              return CircularProgressIndicator();
            }
            if (orderState is ActiveOrdersLoadFailure) {
              return Text(orderState.failureMessage);
            }

            if (orderState is ActiveOrdersEmpltyFailure) {
              return Text(orderState.message);
            }

            if (orderState is ActiveOrdersLoadSuccess) {
              final activeOrders = orderState.activeOrders;

              return ListView.builder(
                itemCount: activeOrders.length,
                itemBuilder: (context, index) {
                  final currentOrder = activeOrders[index];
                  final providerName = currentOrder.provider!.firstname +
                      " " +
                      currentOrder.provider!.lastname;
                  final orderCreatedDate =
                      currentOrder.order!.order_created_date!.substring(0, 24);

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/user.png'),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    title: Text(
                      providerName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(currentOrder.provider.category),
                          Row(
                            children: [
                              Icon(
                                Icons.phone,
                                color: Colors.grey,
                                size: 16,
                              ),
                              Text(currentOrder.provider.phone),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.date_range,
                                color: Colors.grey,
                                size: 16,
                              ),
                              Text(orderCreatedDate),
                            ],
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteGenerator.orderDetailScreenName,
                        arguments:
                            ScreenArguments({'orderId': currentOrder.order.id}),
                      );
                    },
                  );
                },
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
