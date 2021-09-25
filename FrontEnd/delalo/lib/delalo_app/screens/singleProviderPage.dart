import 'package:delalo/delalo_app/blocs/user/provider_profile_page_bloc/provider_profile_bloc.dart';
import 'package:delalo/delalo_app/blocs/user/provider_profile_page_bloc/reviews_of_provider_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_nav.dart';
import 'navigation_drawer/navigation_drawer.dart';

class ProviderProfile extends StatefulWidget {
  const ProviderProfile({Key? key}) : super(key: key);

  @override
  _ProviderProfileState createState() => _ProviderProfileState();
}

class _ProviderProfileState extends State<ProviderProfile> {
// widget override build==============================================================================
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(decoration: TextDecoration.none, color: Colors.black),
      child: Scaffold(
        drawer: NavigationDrawer(),
        bottomNavigationBar: BottomNav(),
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: BlocListener<ProviderProfileBloc, ProviderProfileState>(
            listener: (context, state) async {
              if (state is ProviderProfileInitial) {
                WidgetsFlutterBinding.ensureInitialized();
                final SESSION = await SharedPreferences.getInstance();
                final provId =
                    await SESSION.getString('providerForSingleProviderPage');
                final seekId = await SESSION.getString('id');
                BlocProvider.of<ProviderProfileBloc>(context).add(
                    LoadProviderInfo(
                        providerId: provId.toString(),
                        seekerId: seekId.toString()));
                BlocProvider.of<ReviewsOfProviderBloc>(context)
                    .add(LoadReviewsOfProvider(providerId: provId.toString()));
              }
            },
            child: Container(
              color: Colors.white,
              height: 1200,
              padding:
                  EdgeInsets.only(top: 40, bottom: 30, left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // first profile row section======================================================================
                  BlocBuilder<ProviderProfileBloc, ProviderProfileState>(
                    builder: (context, state) {
                      if (state is ProviderInfoLoading)
                        return Center(child: CircularProgressIndicator());
                      if (state is ProviderInfoLoadFailure)
                        return Center(
                          child: Text("Failed to Load Profile"),
                        );
                      if (state is ProviderInfoLoadSuccess)
                        return Row(
                          children: [
                            Image.asset(
                              'assets/images/user.png',
                              width: 85,
                              height: 85,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            // name Location Rating ======================================
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // provider name row
                                Text(
                                  state.provider.firstname +
                                      state.provider.lastname,
                                  style: GoogleFonts.ibmPlexSans(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 10),
                                // Location, rating row
                                Row(
                                  children: [
                                    // Rating row
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        ),
                                        Text(
                                          state.provider.average_rating
                                              .toString(),
                                          style: GoogleFonts.ibmPlexSans(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    // Location row
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.place,
                                          color: Colors.green,
                                        ),
                                        Text(
                                          state.provider.address,
                                          style: GoogleFonts.ibmPlexSans(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );

                      return Center(
                        child: Text("Failed to Load Profile"),
                      );
                    },
                  ),
                  SizedBox(height: 25),

                  // second(Description)  section ====================================================================
                  BlocBuilder<ProviderProfileBloc, ProviderProfileState>(
                    builder: (context, state) {
                      if (state is ProviderInfoLoadSuccess)
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                'About',
                                style: GoogleFonts.ibmPlexSans(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.all(14),
                              child: SingleChildScrollView(
                                child: Text(
                                  state.provider.description,
                                  style: GoogleFonts.ibmPlexSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );

                      return SizedBox();
                    },
                  ),
                  SizedBox(height: 25),

                  // third row about hire infos=====================================================================================================================
                  BlocBuilder<ProviderProfileBloc, ProviderProfileState>(
                    builder: (context, state) {
                      final providerProfileBlocProvider =
                          BlocProvider.of<ProviderProfileBloc>(context);
                      if (state is ProviderInfoLoadSuccess)
                        return Column(
                          children: [
                            // first two boxes row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Per hour===========================
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xff61327D),
                                  ),
                                  width: 130,
                                  height: 130,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.attach_money,
                                              color: Colors.green,
                                            ),
                                            Text(
                                              state.provider.per_hour_wage
                                                  .toString(),
                                              style: GoogleFonts.ibmPlexSans(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'Hourly Rate',
                                          style: GoogleFonts.ibmPlexSans(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 50),

                                // jobs done field==============================
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xff61327D),
                                  ),
                                  width: 130,
                                  height: 130,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.work,
                                              color: Colors.green,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              state.provider.jobs_done
                                                  .toString(),
                                              style: GoogleFonts.ibmPlexSans(
                                                fontSize: 17,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'Jobs Done',
                                          style: GoogleFonts.ibmPlexSans(
                                            fontSize: 17,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),

                            // second hire button row====================
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: state.isRequested
                                    ? null
                                    : () {
                                        providerProfileBlocProvider.add(
                                            HireButtonPressed(
                                                providerId: state.provider.id));
                                      },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color(0xffa1a1a1)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  state.isRequested
                                      ? "Hire (pending...)"
                                      : "Hire",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.ibmPlexSans(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        );

                      return SizedBox();
                    },
                  ),
                  SizedBox(height: 30),

                  // Reviews Section=====================================================================================================================================
                  Text(
                    'Work History and Feedback',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.ibmPlexSans(
                      fontSize: 23,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 20),

                  // fetched reviews list view======================
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: BlocBuilder<ReviewsOfProviderBloc,
                          ReveiwsOfProviderState>(
                        builder: (context, state) {
                          if (state is ReviewsOfProviderInfoLoading)
                            return Container(
                                height: 40,
                                width: 40,
                                child:
                                    Center(child: CircularProgressIndicator()));
                          if (state is ReviewsOfProviderLoadFailure) {
                            return Center(
                              child: Text("No reviews"),
                            );
                          }
                          if (state is ReviewsOfProviderLoadSuccess) {
                            if (state.orderDetailsOfProvider.length > 0) {
                              return ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: state.orderDetailsOfProvider.length,
                                itemBuilder: (BuildContext context, int i) {
                                  return Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Color(0xff61327D),
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              state.orderDetailsOfProvider[i]
                                                      .user.firstname +
                                                  "  " +
                                                  state
                                                      .orderDetailsOfProvider[i]
                                                      .user
                                                      .lastname,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.ibmPlexSans(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  color: Colors.yellow,
                                                  child: Text(
                                                    state
                                                        .orderDetailsOfProvider[
                                                            i]
                                                        .review
                                                        .rating
                                                        .toString(),
                                                    style:
                                                        GoogleFonts.ibmPlexSans(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 20),
                                                Text(
                                                  'From ' +
                                                      state
                                                          .orderDetailsOfProvider[
                                                              i]
                                                          .order
                                                          .order_created_date +
                                                      ' to --',
                                                  style:
                                                      GoogleFonts.ibmPlexSans(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 1),
                                            Text(
                                              ' to --',
                                              style: GoogleFonts.ibmPlexSans(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            Text(
                                              state.orderDetailsOfProvider[i]
                                                          .review.comment !=
                                                      null
                                                  ? state
                                                      .orderDetailsOfProvider[i]
                                                      .review
                                                      .comment
                                                  : '',
                                              // state.orderDetailsOfProvider[i].review.comment ?? '',
                                              style: GoogleFonts.ibmPlexSans(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      )
                                    ],
                                  );
                                },
                              );
                            } else {
                              return Center(
                                child: Text("No reviews currently"),
                              );
                            }
                          }
                          return Center(
                            child: Text("Failed to Load reviews"),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
