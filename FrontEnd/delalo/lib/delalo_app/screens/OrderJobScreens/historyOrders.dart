import 'package:delalo/delalo_app/blocs/blocs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:givestarreviews/givestarreviews.dart';

class HistoryOrders extends StatelessWidget {
  HistoryOrders({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    final String seeker_id = "611e45f2517e71323071fa50";
    final orderBloc = BlocProvider.of<OrderBloc>(context);
    orderBloc.add(CompleteOrdersLoad(seeker_id));

    return Scaffold(
      body: Center(
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (_, orderState) {
            if (orderState is Loading) {
              return CircularProgressIndicator();
            }

            if (orderState is CompletedOrdersLoadFailure) {
              return Text(orderState.failureMessage);
            }

            if (orderState is CompletedOrdersEmpltyFailure) {
              return Text(orderState.message);
            }

            if (orderState is CompletedOrdersLoadSuccess) {
              final jobs = orderState.completedOrders;

              return ListView.builder(
                itemCount: jobs.length,
                itemBuilder: (context, index) {
                  final job = jobs[index];
                  final orderCreatedDate =
                      job.order!.order_created_date!.substring(0, 24);
                  final orderCompletedDate =
                      job.order!.order_completed_date!.substring(0, 24);
                  final providerName =
                      job.provider!.firstname + " " + job.provider!.lastname;
                  return Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: ListTile(
                      leading: Column(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundImage:
                                AssetImage('assets/images/user.png'),
                          ),
                          Text(
                            providerName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      title: Text(
                        "${job.order.final_payment.toStringAsFixed(2)} ETB",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.grey,
                                  size: 16,
                                ),
                                Text(job.user.address),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: Colors.grey,
                                  size: 16,
                                ),
                                Text(job.provider.phone),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.date_range,
                                  color: Colors.grey,
                                  size: 16,
                                ),
                                Text(
                                    '$orderCreatedDate -\n $orderCompletedDate. '),
                              ],
                            ),
                            // StarRating(
                            //   size: 15,
                            //   value: job.review.rating,
                            //   onChanged: null,
                            // ),
                            Text(job.review.comment)
                          ],
                        ),
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
