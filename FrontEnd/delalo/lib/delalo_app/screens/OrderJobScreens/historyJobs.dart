import 'package:delalo/delalo_app/blocs/user/user_blocs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:givestarreviews/givestarreviews.dart';

class HistoryJobs extends StatelessWidget {
  HistoryJobs({Key? key}) : super(key: key);
  Widget build(BuildContext context) {
    final String provider_id = "61332f352eb4f64398fa7678";
    final orderBloc = BlocProvider.of<OrderBloc>(context);
    orderBloc.add(CompleteJobsLoad(provider_id));

    return Scaffold(
      body: Center(
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (_, orderState) {
            if (orderState is Loading) {
              return CircularProgressIndicator();
            }

            if (orderState is CompletedJobsLoadFailure) {
              return Text(orderState.failureMessage);
            }

            if (orderState is CompletedJobsEmpltyFailure) {
              return Text(orderState.message);
            }

            if (orderState is CompletedJobsLoadSuccess) {
              final jobs = orderState.completedJobs;

              return ListView.builder(
                itemCount: jobs.length,
                itemBuilder: (context, index) {
                  final job = jobs[index];
                  final orderCreatedDate =
                      job.order!.order_created_date!.substring(0, 24);
                  final orderCompletedDate =
                      job.order!.order_completed_date!.substring(0, 24);
                  final userName =
                      job.user!.firstname + " " + job.user!.lastname;
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
                            userName,
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
                                Text(job.user.phone),
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
