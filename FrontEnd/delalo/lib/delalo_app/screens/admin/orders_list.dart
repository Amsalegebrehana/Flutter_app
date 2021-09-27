import 'package:delalo/delalo_app/blocs/admin_bloc/order_bloc/order_bloc.dart';
import 'package:delalo/delalo_app/blocs/admin_bloc/order_bloc/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminOrdersJobs extends StatefulWidget {
  const AdminOrdersJobs({Key? key}) : super(key: key);

  @override
  _AdminOrdersJobsState createState() => _AdminOrdersJobsState();
}

class _AdminOrdersJobsState extends State<AdminOrdersJobs> {
  var color_swap = Colors.grey[200];
  var color_swap_white = Colors.white;
  @override
  Widget build(BuildContext context) {
    final ordersBloc = BlocProvider.of<AdminOrderBloc>(context);
    return Scaffold(body: Center(
      child: BlocBuilder<AdminOrderBloc, AdminOrderState>(builder: (_, orderState) {
        print('orders state $orderState');
        if (orderState is AdminOrderLoading) {
          return CircularProgressIndicator();
        } else if (orderState is AdminOrderOperationFailure) {
          return Text("Loading failed");
        } else if (orderState is AdminOrdersLoadSuccess) {
          final orders = orderState.orders;
          print("orders Ui");
          print(orders.length);
          if (orders.length / 2 == 0) {
            color_swap = Colors.white;
            color_swap_white =  Colors.grey;
          } 
          return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (_, index) {
                final order = orders[index];
                final seeker_user_name =
                    order.user!.firstname + order.user!.lastname;
                final provider_user_name =
                    order.provider!.firstname + order.provider!.lastname;
                return Card(
                    child: Container(
                  child: Row(
                    children: [
                      Expanded(
                        
                        child: Container(
                         color: (index % 2 == 0) ? Colors.white : Colors.grey[200],
                          child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),

                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 5, 5, 10),
                              child: Column(
                                children: [
                                  Row(children: [
                                    Text("Provider:  "),
                                     Text('$provider_user_name'),
                                  ],),
                                  SizedBox(height: 5,),
                                 Row(children: [
                                  Text('Category: '),
                                 
                                  Text('${order.order!.order_completed_date}'),


                                 ],),SizedBox(height: 5,),
                                 Row(children: [
                                  Text('Date: '),
                                  // Text('${order.provider!.category}'),
                                  Text('${order.order!.order_completed_date}'),


                                 ],)
                                  // Text('Address  ${order.user!.adderess}'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                       color: (index % 2 == 0) ? Colors.grey[200] : Colors.white,

                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 5, 5, 10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                  Text("Seeker Name "),

                                  Text(" ${seeker_user_name}"),

                                    ],

                                  ),
                                   SizedBox(height: 5,),
                                   Row(
                                    children: [
                                  Text("Unique Code "),
                                  Text(" ${order.order!.unique_code}"),

                                    ],
                                    
                                  ),
                                  SizedBox(height: 5,),
                                   Row(
                                    children: [
                                  Text("Saved Time"),
                                  Text(" ${order.order!.saved_time}"),

                                    ],
                                    
                                  )
                                  // Text('Start Time ${order.user!.start_time}'),
                                  // Text("Saved Time ${order.user!.saved_time}")
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
                   
                    );
              });
        }
        return Container();
      }),
    ));
  }
}
