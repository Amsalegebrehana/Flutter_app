import 'package:flutter/material.dart';

import 'bottom_nav.dart';
import 'navigation_drawer/navigation_drawer.dart';

const appName = "Provider Page";
const infostyle =
    TextStyle(fontSize: 20, color: Colors.black54, fontWeight: FontWeight.bold);
const detailstyle = TextStyle(fontSize: 17);

class ProviderPage extends StatefulWidget {
  const ProviderPage({Key? key}) : super(key: key);

  @override
  _ProviderPageState createState() => _ProviderPageState();
}

class _ProviderPageState extends State<ProviderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      bottomNavigationBar: BottomNav(),
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 230),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              Container(
                height: 350,
                color: Colors.purple,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 120),
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 60,
                color: Colors.purple[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Edit Profile",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.edit,
                      size: 20,
                      color: Colors.white,
                    )
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Account Details",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 8,
                ),
                Divider(
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(children: [
                          Text(
                            "Name: ",
                            style: detailstyle,
                          ),
                          Text(
                            "Janine Doe",
                            style: infostyle,
                          ),
                        ]),
                        SizedBox(
                          height: 20,
                        ),
                        Row(children: [
                          Text(
                            "Email: ",
                            style: detailstyle,
                          ),
                          Text(
                            "janine@doe.com",
                            style: infostyle,
                          ),
                        ]),
                        SizedBox(
                          height: 20,
                        ),
                        Row(children: [
                          Text(
                            "Phone Number: ",
                            style: detailstyle,
                          ),
                          Text(
                            "0977835613",
                            style: infostyle,
                          ),
                        ]),
                        SizedBox(
                          height: 20,
                        ),
                        Row(children: [
                          Text(
                            "Address: ",
                            style: detailstyle,
                          ),
                          Text(
                            "Addis Ababa, 5 kilo",
                            style: infostyle,
                          ),
                        ]),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Description: ",
                                style: detailstyle,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Container(
                                width: 300,
                                child: Text(
                                  "Top notch provider offering high quality services.",
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                              )
                            ]),
                        SizedBox(
                          height: 20,
                        ),
                        Row(children: [
                          Text(
                            "Category: ",
                            style: detailstyle,
                          ),
                          Text(
                            "Plumber",
                            style: infostyle,
                          ),
                        ]),
                        SizedBox(
                          height: 20,
                        ),
                        Row(children: [
                          Text(
                            "Category: ",
                            style: detailstyle,
                          ),
                          Text(
                            "Plumber",
                            style: infostyle,
                          ),
                        ]),
                        SizedBox(
                          height: 20,
                        ),
                        Row(children: [
                          Text(
                            "Jobs Done: ",
                            style: detailstyle,
                          ),
                          Text(
                            "5",
                            style: infostyle,
                          ),
                        ]),
                        SizedBox(
                          height: 20,
                        ),
                        Row(children: [
                          Text(
                            "Average Rating: ",
                            style: detailstyle,
                          ),
                          Text(
                            "4.5",
                            style: infostyle,
                          ),
                        ]),
                        SizedBox(
                          height: 20,
                        ),
                        Row(children: [
                          Text(
                            "Per Hour Wage: ",
                            style: detailstyle,
                          ),
                          Text(
                            "\$30",
                            style: infostyle,
                          ),
                        ]),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  ElevatedButton(
                      onPressed: null,
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.purple)),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 22, horizontal: 3),
                        height: 70,
                        width: 80,
                        child: Text(
                          "Log Out",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 21),
                        ),
                      )),
                  ElevatedButton(
                      onPressed: null,
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.grey.shade400)),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                        height: 70,
                        width: 80,
                        child: Text(
                          "Delete Account",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ))
                ])
              ],
            ),
          )
        ]),
      ),
    );
  }
}
