import 'package:delalo/delalo_app/blocs/blocs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PendingJobs extends StatelessWidget {
  PendingJobs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final orderBloc = BlocProvider.of<OrderBloc>(context);

    return Scaffold(
      body: Center(
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (_, orderState) {
            if (orderState is Loading) {
              return CircularProgressIndicator();
            }

            if (orderState is PendingJobsLoadSuccess) {
              final pendingJobs = orderState.pendingJobs;

              return ListView.builder(
                itemCount: pendingJobs.length,
                itemBuilder: (context, index) {
                  final job = pendingJobs[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/user.png'),
                    ),
                    title: Text(
                      job.order.id,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Category Type'),
                        ],
                      ),
                    ),
                    trailing: Container(
                      margin: EdgeInsets.all(0),
                      width: 120,
                      child: Row(
                        children: [
                          Column(
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
                          SizedBox(
                            width: 15,
                          ),
                          Column(
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
