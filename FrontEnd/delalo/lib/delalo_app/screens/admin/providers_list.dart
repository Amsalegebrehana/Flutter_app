

import 'package:delalo/delalo_app/blocs/admin_bloc/provider_bloc/provider_bloc.dart';
import 'package:delalo/delalo_app/blocs/admin_bloc/provider_bloc/provider_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminProvidersList extends StatefulWidget {
  const AdminProvidersList({Key? key}) : super(key: key);

  @override
  _AdminProvidersListState createState() => _AdminProvidersListState();
}

class _AdminProvidersListState extends State<AdminProvidersList> {
  @override
  Widget build(BuildContext context) {
    final providersBloc = BlocProvider.of<ProvidersBloc>(context);
    return Scaffold(
      body: Center(
        child: BlocBuilder<ProvidersBloc, ProvidersState>(
            builder: (_, providersState) {
          if (providersState is ProviderLoading) {
            return CircularProgressIndicator();
          } else if (providersState is ProvidersOperationsFailed) {
            return Text("Loading failed");
          } else if (providersState is ProviderLoaded) {
            final providers = providersState.providers;
            return ListView.builder(
                itemCount: providers.length,
                itemBuilder: (_, index) {
                  final provider = providers[index];
                  if (provider.role == 'provider') {
                    String name = provider.firstname + provider.lastname;
                    final double circleRadius = 70.0;
                    return Container(
                     
                      child: Stack(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                  top: circleRadius / 2.0,
                                ),

                                ///here we create space for the circle avatar to get ut of the box
                                child: Container(
                                  height: 200.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 8.0,
                                        offset: Offset(0.0, 5.0),
                                      ),
                                    ],
                                  ),
                                  width: double.infinity,
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, bottom: 10.0),
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: circleRadius / 2,
                                          ),
                                          Text(
                                            name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 20.0),
                                          ),
                                          Text(
                                            provider.address,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 12.0,
                                                color: Colors.purple[200]),
                                          ),
                                          Text(
                                            provider.email,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 15.0,
                                                color: Colors.black),
                                          ),
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 32.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Column(
                                                  children: <Widget>[
                                                    Text(
                                                      'Avarage Ratings',
                                                      style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Text(
                                                      provider.average_rating.toString(),
                                                      style: TextStyle(
                                                          fontSize: 15.0,
                                                          color: Colors.black87,
                                                          fontFamily: ''),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: <Widget>[
                                                    Text(
                                                      'Per hour wage',
                                                      style: TextStyle(
                                                          fontSize: 15.0,
                                                          color:
                                                              Colors.black),
                                                    ),
                                                    Text(
                                                       provider. per_hour_wage.toString(),
                                                      style: TextStyle(
                                                          fontSize: 15.0,
                                                          color: Colors.black,
                                                          fontFamily: ''),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: <Widget>[
                                                    Text(
                                                      'Phone Number',
                                                      style: TextStyle(
                                                          fontSize: 15.0,
                                                          color:
                                                              Colors.black),
                                                    ),
                                                    Text(
                                                      provider.phone,
                                                      style: TextStyle(
                                                          fontSize: 15.0,
                                                          color: Colors.black87,
                                                          fontFamily: ''),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                              ),

                              ///Image Avatar
                              Container(
                                width: circleRadius,
                                height: circleRadius,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 8.0,
                                      offset: Offset(0.0, 5.0),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Center(
                                    child: Container(
                                      child: Icon(Icons.person),

                                      /// replace your image with the Icon
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    );
                  } else {
                    return Container();
                  }
                });
          }
          return Container();
        }),
      ),
    );
  }
}
