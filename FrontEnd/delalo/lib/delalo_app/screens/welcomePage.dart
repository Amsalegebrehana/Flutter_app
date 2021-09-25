import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routeGenerator.dart';

class WelcomeScreen extends StatelessWidget {
  Widget _whiteCircle() {
    return Icon(
      Icons.circle,
      color: Colors.white,
      size: 10,
    );
  }

  Widget _greyCircle() {
    return Icon(
      Icons.circle,
      color: Colors.white38,
      size: 10,
    );
  }

  List<Widget> _bottomCircles() {
    return [_whiteCircle(), SizedBox(width: 3), _greyCircle()];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(decoration: TextDecoration.none),
      child: Container(
        color: Color(0xff61327D),
        child: Container(
          padding: EdgeInsets.only(right: 20, left: 20),
          margin: EdgeInsets.only(top: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 0,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 130),
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 80,
                          height: 80,
                        ),
                      ),
                      SizedBox(height: 50),
                      Text(
                        'Welcome To Delalo',
                        style: GoogleFonts.ibmPlexSans(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'It’s the simplest, most convinient and safest way to fix your problems at hand.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ibmPlexSans(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w100,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  )),
              Expanded(flex: 1, child: SizedBox()),
              Expanded(
                flex: 0,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: this._bottomCircles(),
                    ),
                    SizedBox(height: 30),
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: SizedBox(
                        width: 150,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                             Navigator.of(context).pushNamed(RouteGenerator.getStartedScreenName);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.white),
                            shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          child: Text(
                            "Next",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.ibmPlexSans(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
