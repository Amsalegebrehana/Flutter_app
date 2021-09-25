import 'package:delalo/delalo_app/blocs/user/user_bloc/bloc.dart';
import 'package:delalo/delalo_app/exports.dart';
import 'package:flutter/material.dart';
import 'bottom_nav.dart';
import 'navigation_drawer/navigation_drawer.dart';
import 'user_account_page.dart';
import 'package:delalo/sub.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserEditProfile extends StatelessWidget {
  const UserEditProfile({Key? key, required this.user}) : super(key: key);
  final user;
  static final routeName = "/user_edit_page";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      bottomNavigationBar: BottomNav(),
        appBar: AppBar(
          title: Text("Edit Profile"),
        ),
        body: BlocBuilder<UserBloc, UserState>(builder: (_, UserState) {
          if (UserState is UserLoading) {
            return Text("Loading...");
          }

          if (UserState is UserOperationFailure) {
            return Text("Loading failed");
          }

          if (UserState is UserLoadSuccess) {
            final users = UserState.user;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 55.0, vertical: 22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(80)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 35),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Your Name",
                            style: TextStyle(color: Colors.grey, fontSize: 17),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: user.firstname + " " + user.lastname,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Your Email",
                            style: TextStyle(color: Colors.grey, fontSize: 17),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: user.email,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Your PhoneNo.",
                            style: TextStyle(color: Colors.grey, fontSize: 17),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: user.phone,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Your Address",
                            style: TextStyle(color: Colors.grey, fontSize: 17),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: user.address,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          ElevatedButton(
                              onPressed: null,
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.purple)),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 100),
                                width: 300,
                                height: 50,
                                child: Text(
                                  "Save",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 23),
                                ),
                              )),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        }));
  }
}
