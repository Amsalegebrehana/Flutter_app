import 'package:delalo/delalo_app/blocs/blocs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routeGenerator.dart';

class DeclinedOrders extends StatelessWidget {
  DeclinedOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String seeker_id = "61332f182eb4f64398fa7676";
    final orderBloc = BlocProvider.of<OrderBloc>(context);
    orderBloc.add(DeclinedOrdersLoad(seeker_id));
    return Scaffold(
      body: Center(
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (_, orderState) {
            if (orderState is Loading) {
              return CircularProgressIndicator();
            }

            if (orderState is DeclinedOrdersLoadFailure) {
              return Text(orderState.failureMessage);
            }

            if (orderState is DeclinedOrdersEmpltyFailure) {
              return Text(orderState.message);
            }

            if (orderState is DeclinedOrdersLoadSuccess) {
              final declinedOrders = orderState.declinedOrders;

              return ListView.builder(
                itemCount: declinedOrders.length,
                itemBuilder: (context, index) {
                  final currentOrder = declinedOrders[index];
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
                        Navigator.pushNamed(context, RouteGenerator.homePageName);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.teal,
                            size: 30,
                          ), // icon
                          Text(
                            'Hire Someone Else',
                            style: TextStyle(
                              color: Colors.teal,
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
