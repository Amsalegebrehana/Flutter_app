import 'package:delalo/delalo_app/blocs/blocs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PendingOrders extends StatelessWidget {
  PendingOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String seeker_id = "61332f182eb4f64398fa7676";
    final orderBloc = BlocProvider.of<OrderBloc>(context);
    orderBloc.add(PendingOrdersLoad(seeker_id));
    return Scaffold(
      body: Center(
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (_, orderState) {
            if (orderState is Loading) {
              return CircularProgressIndicator();
            }

            if (orderState is PendingOrdersLoadFailure) {
              return Text(orderState.failureMessage);
            }

            if (orderState is PendingOrdersEmpltyFailure) {
              return Text(orderState.message);
            }

            if (orderState is PendingOrdersLoadSuccess) {
              final pendingOrders = orderState.pendingOrders;

              return ListView.builder(
                itemCount: pendingOrders.length,
                itemBuilder: (context, index) {
                  final currentOrder = pendingOrders[index];
                  final providerName = currentOrder.provider!.firstname +
                      " " +
                      currentOrder.provider!.lastname;
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/user.png'),
                    ),
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
                        ],
                      ),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        orderBloc.add(
                          DeclineOrder(currentOrder.order.id),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.remove_circle,
                            color: Colors.red,
                          ), // icon
                          Text(
                            'Decline',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ), // text
                        ],
                      ),
                    ),
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
