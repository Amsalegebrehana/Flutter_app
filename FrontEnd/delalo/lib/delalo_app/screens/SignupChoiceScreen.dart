import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routeGenerator.dart';

class SignupChoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 0,
              child: Image.asset(
                'assets/images/logo.png',
                width: 100,
                height: 100,
              ),
            ),
            SizedBox(height: 50),
            Expanded(
              flex: 0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(RouteGenerator.signupUserScreenName);
                },
                style: ButtonStyle(
                  fixedSize:
                      MaterialStateProperty.all<Size?>(Size.fromHeight(50)),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                      EdgeInsets.only(left: 70, right: 70)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xff61327D)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                child: Text(
                  'Sign up as a user',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ibmPlexSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              flex: 0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(RouteGenerator.signupProviderScreenName);
                },
                style: ButtonStyle(
                  fixedSize:
                      MaterialStateProperty.all<Size?>(Size.fromHeight(50)),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                      EdgeInsets.only(left: 50, right: 50)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xff61327D)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                child: Text(
                  'Sign up as a provider',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ibmPlexSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
