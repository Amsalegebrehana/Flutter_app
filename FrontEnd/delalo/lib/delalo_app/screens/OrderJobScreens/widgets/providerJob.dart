import 'package:delalo/delalo_app/blocs/blocs.dart';
import 'package:delalo/delalo_app/blocs/navigation_drawer/navigation.dart';
import 'package:delalo/delalo_app/data_provider/data_provider.dart';
import 'package:delalo/delalo_app/repository/repository.dart';
import 'package:delalo/delalo_app/screens/OrderJobScreens/activeJob.dart';
import 'package:delalo/delalo_app/screens/OrderJobScreens/pendingJobs.dart';
import 'package:delalo/routeGenerator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:delalo/delalo_app/screens/OrderJobScreens/widgets/rowTitle.dart';
import 'package:delalo/delalo_app/screens/OrderJobScreens/widgets/rowContent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ProviderJob extends StatelessWidget {
  ProviderJob({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String provider_id = "61332f352eb4f64398fa7678";
    final orderBloc = BlocProvider.of<OrderBloc>(context);
    orderBloc.add(ProviderJobStatus(provider_id));
    return Scaffold(
      body: Center(
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (_, orderState) {
            if (orderState is Loading) {
              return CircularProgressIndicator();
            }

            if (orderState is PendingJobsLoadFailure) {
              return Center(child: Text(orderState.failureMessage));
            }

            if (orderState is PendingJobsEmpltyFailure) {
              return Center(child: Text(orderState.message));
            }

            if (orderState is ActiveJobFailure) {
              return Text(orderState.failureMessage);
            }

            if (orderState is PendingJobsLoadSuccess) {
              final pendingJobs = orderState.pendingJobs;
              return ListView.builder(
                itemCount: pendingJobs.length,
                itemBuilder: (context, index) {
                  final job = pendingJobs[index];
                  final userName =
                      job.user!.firstname + " " + job.user!.lastname;
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/user.png'),
                    ),
                    title: Text(
                      userName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(job.provider.category),
                        ],
                      ),
                    ),
                    trailing: Container(
                      margin: EdgeInsets.all(0),
                      width: 120,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              orderBloc.add(
                                AcceptJob(job.order.id),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                ), // icon
                                Text(
                                  'Accept',
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                ), // text
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              orderBloc.add(
                                DeclineJob(job.order.id),
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
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            if (orderState is ActiveJobSuccess) {
              final activeJob = orderState.activeJob;
              final userName =
                  activeJob.user!.firstname + " " + activeJob.user!.lastname;
              final orderCreatedDate =
                  activeJob.order!.order_created_date!.substring(0, 24);

              return Container(
                decoration: BoxDecoration(color: Colors.grey[100]),
                child: Column(
                  children: [
                    Container(
                      color: Colors.grey[100],
                      child: Stack(
                        children: [
                          Container(
                              height: 400,
                              margin: EdgeInsets.only(top: 40),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.0),
                                  topLeft: Radius.circular(20.0),
                                ),
                              )),
                          Column(
                            children: [
                              Container(
                                child: Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Center(
                                      child: Text(
                                        "Undertaking...",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                        ),
                                      ),
                                    ),
                                    height: 60,
                                    width: 300,
                                    decoration: BoxDecoration(
                                      color: Colors.purple[700],
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(40.0),
                                          bottomRight: Radius.circular(40.0),
                                          topLeft: Radius.circular(40.0),
                                          bottomLeft: Radius.circular(40.0)),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage:
                                      AssetImage('assets/images/user.png'),
                                ),
                              ),
                              Text(
                                userName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                              Divider(
                                height: 10,
                                thickness: 1,
                                indent: 15,
                                endIndent: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RowTitle(title: 'Service'),
                                        RowTitle(title: 'Phone Number'),
                                        RowTitle(title: 'Address'),
                                        RowTitle(title: 'Order Created'),
                                        RowTitle(title: 'Unique Code'),
                                      ],
                                    ),
                                    Expanded(
                                      child: SizedBox(),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        RowContent(
                                            content:
                                                activeJob.provider!.category),
                                        RowContent(
                                            content: activeJob.user!.phone),
                                        RowContent(
                                            content: activeJob.user!.address),
                                        RowContent(content: orderCreatedDate),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            activeJob.order!.unique_code
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
