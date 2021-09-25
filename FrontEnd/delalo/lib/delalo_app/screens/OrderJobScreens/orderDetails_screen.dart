import 'package:delalo/delalo_app/blocs/user/user_blocs.dart';
import 'package:delalo/delalo_app/models/models.dart';
import 'package:delalo/routeGenerator.dart';
import 'package:flutter/material.dart';
import 'package:delalo/delalo_app/screens/OrderJobScreens/widgets/rowTitle.dart';
import 'package:delalo/delalo_app/screens/OrderJobScreens/widgets/rowContent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:slider_button/slider_button.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:prompt_dialog/prompt_dialog.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import 'gradient_progress_indicator.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = '/orderDetails';
  final Map argObj;

  OrderDetailsScreen({Key? key, required this.argObj}) : super(key: key);

  @override
  _OrderDetailsScreenState createState() =>
      _OrderDetailsScreenState(argObj: argObj);
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  final Map argObj;
  bool _isWorking = false;
  String unqiueCode = '';
  final _isHours = true;
  int savedTime = 3;
  int myDuration = 0;
  Icon myIcon = Icon(
    Icons.play_circle_filled,
    color: Colors.green,
    size: 50.0,
  );
  final uniqueCodeController = TextEditingController();
  _OrderDetailsScreenState({required this.argObj});

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
    onChange: (value) => print('onChange $value'),
    onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
  );

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _stopWatchTimer.rawTime.listen((value) =>
        print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
    _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
    _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
    _stopWatchTimer.records.listen((value) => print('records $value'));

    /// Can be set preset time. This case is "00:01.23".
    // _stopWatchTimer.setPresetTime(mSec: 1234);
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  // Widget ratingDialog(BuildContext context, String order_id){
  //   int rating;
  //   String comment;

  //   return Container(

  //     child: BlocBuilder<ReviewBloc, ReviewState>(builder: (_, reviewState) {
  //   if (reviewState is ReviewLoading) {
  //     return RatingDialog(
  //       // your app's name?
  //       title: 'Rate your Service',
  //       // encourage your user to leave a high rating?

  //       // your app's logo?
  //       image: Image(image: AssetImage('assets/images/logo.png')),
  //       submitButton: 'Submit',
  //       onCancelled: () => print('cancelled'),
  //       onSubmitted: (response) {
  //         rating= response.rating;
  //         comment=response.comment;
  //         order_id= order_id;

  //   final reviewBloc = BlocProvider.of<ReviewBloc>(context);
  //   reviewBloc.add(AddReview(rating, comment, order_id));

  //       },
  //     );
  //   }
  //   return Container();
  // }));

  late OrderDetails order;

  @override
  Widget build(BuildContext context) {
    final specOrderId = argObj['orderId'];

    final orderBloc = BlocProvider.of<OrderBloc>(context);
    orderBloc.add(ActiveOrderDetailsLoad(specOrderId));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Center(child: Text("Details")),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: BlocConsumer<OrderBloc, OrderState>(
            listener: (ctx, orderState) {
              if (orderState is CompletedUniqueCodeFailure ||
                  orderState is CompletedUniqueCodeSuccess) {
                Navigator.pushNamed(context, RouteGenerator.ordersScreenName);
              }
            },
            builder: (_, orderState) {
              if (orderState is Loading) {
                return CircularProgressIndicator();
              }

              if (orderState is ActiveOrderDetailFailure) {
                return Text("Loading Failed");
              }

              if (orderState is ActiveOrderDetailSuccess) {
                final specOrder = orderState.activeOrderDetail;
                final providerName = specOrder.provider!.firstname +
                    " " +
                    specOrder.provider!.lastname;
                final orderCreatedDate =
                    specOrder.order!.order_created_date!.substring(0, 24);

                final perHourWage =
                    '${specOrder.provider!.per_hour_wage!.toStringAsFixed(2)} ETB/hr';

                final correctUniqueCode = specOrder.order!.unique_code;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: BlocBuilder<OrderBloc, OrderState>(
                      builder: (_, orderState) {
                        if (orderState is Loading) {
                          return CircularProgressIndicator();
                        }

                        return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(specOrder.order!.id),
                              GestureDetector(
                                  onTap: () async {
                                    if (_isWorking) {
                                      orderBloc.add(
                                        PauseWorking(specOrder.order!.id),
                                      );
                                      myDuration = 0;
                                      myIcon = Icon(
                                        Icons.play_circle_filled,
                                        color: Colors.green,
                                        size: 50.0,
                                      );
                                      _stopWatchTimer.onExecute
                                          .add(StopWatchExecute.stop);
                                    } else {
                                      orderBloc.add(
                                        StartWorking(specOrder.order!.id),
                                      );
                                      _stopWatchTimer.onExecute
                                          .add(StopWatchExecute.start);
                                      myDuration = 3;
                                      myIcon = Icon(
                                        Icons.pause_circle_filled,
                                        color: Colors.red,
                                        size: 50.0,
                                      );
                                    }

                                    setState(() {
                                      _isWorking = !_isWorking;
                                    });
                                  },
                                  child: GradientProgressIndicator(
                                    radius: 120,
                                    duration: myDuration,
                                    strokeWidth: 12,
                                    gradientStops: const [
                                      0.1,
                                      0.9,
                                    ],
                                    gradientColors: const [
                                      Colors.white,
                                      Colors.purple,
                                    ],
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 0),
                                          child: StreamBuilder<int>(
                                            stream: _stopWatchTimer.rawTime,
                                            initialData:
                                                _stopWatchTimer.rawTime.value,
                                            builder: (context, snap) {
                                              final value = snap.data!;
                                              final displayTime =
                                                  StopWatchTimer.getDisplayTime(
                                                      value,
                                                      hours: _isHours);
                                              return Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Text(
                                                      displayTime,
                                                      style: const TextStyle(
                                                          fontSize: 35,
                                                          fontFamily:
                                                              'Helvetica',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                        myIcon
                                      ],
                                    ),
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  width: 200,
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          validator: (value) {
                                            if ((value) !=
                                                correctUniqueCode.toString()) {
                                              return 'Incorrect try again';
                                            } else if (value == '') {
                                              return '';
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.number,
                                          cursorColor: Colors.purple,
                                          decoration: new InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.purple,
                                                    width: 2.0),
                                              ),
                                              errorStyle:
                                                  TextStyle(color: Colors.red),
                                              labelStyle: TextStyle(
                                                  color: Colors.purple),
                                              labelText: 'Unique Code',
                                              hintText: 'Enter code'),
                                          onChanged: (value) {
                                            unqiueCode = value;
                                          },
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ElevatedButton(
                                              onPressed: _isWorking
                                                  ? null
                                                  : () {
                                                      final form =
                                                          _formKey.currentState;
                                                      if (form!.validate()) {
                                                        orderBloc.add(
                                                            CompleteCode(
                                                                specOrderId));
                                                      }
                                                    },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text("Complete job"),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.purple[800],
                                                  textStyle: const TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white))),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Column(
                                    children: [
                                      Text(
                                        providerName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Divider(
                                        height: 10,
                                        thickness: 1,
                                        indent: 15,
                                        endIndent: 15,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
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
                                                RowTitle(title: 'Rate'),
                                                RowTitle(
                                                    title: 'Order Created'),
                                              ],
                                            ),
                                            Expanded(
                                              child: SizedBox(),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                RowContent(
                                                    content: specOrder
                                                        .provider!.category),
                                                RowContent(
                                                    content: specOrder
                                                        .provider!.phone),
                                                RowContent(
                                                    content: perHourWage),
                                                RowContent(
                                                    content: orderCreatedDate),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ]);
                      },
                    ),
                  ),
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}
