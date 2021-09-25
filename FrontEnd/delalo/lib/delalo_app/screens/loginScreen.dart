import 'package:delalo/delalo_app/blocs/auth_bloc/login_bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routeGenerator.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    // PatternValidator(r'(?=.*?[#?!@$%^&*-])',
    //     errorText: 'passwords must have at least one special character')
  ]);

  final emailValidator = MultiValidator([
    EmailValidator(errorText: 'Invalid email'),
    RequiredValidator(errorText: "Email is required")
  ]);

  @override
  Widget build(BuildContext context) {
    final loginBlocProvider = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (_, state) {
          if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                duration: Duration(seconds: 3),
              ),
            );
            print(state.error);
          } else if (state is LoginSuccess) {
            // if(state.role == 'admin'){
            //   Navigator.of(context).pushNamed(RouteGenerator.adminScreen);
            // }else{
            //   Navigator.of(context).pushNamed(RouteGenerator.singleProviderPageName);
            // }
            Navigator.of(context).pushNamed(RouteGenerator.singleProviderPageName);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 80),
              child: Column(
                children: [
                  // login Text
                  Text(
                    'Log in',
                    style: GoogleFonts.ibmPlexSans(
                      fontSize: 30,
                      fontWeight: FontWeight.w300,
                    ),
                  ),

                  // login illustration
                  Image.asset(
                    'assets/images/login.png',
                    height: 260,
                    width: 230,
                  ),
                  SizedBox(height: 50),

                  // Form goes here
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Add TextFormFields and ElevatedButton here.

                        // email field
                        Container(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: TextFormField(
                            // The validator receives the text that the user has entered.
                            decoration: InputDecoration(
                              icon: Icon(Icons.email),
                              labelText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            validator: emailValidator,
                            onChanged: (value) {
                              email = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        // password field
                        Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            // The validator receives the text that the user has entered.
                            obscureText: true,
                            decoration: InputDecoration(
                              icon: Icon(Icons.lock),
                              labelText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            validator: passwordValidator,
                            onChanged: (value) {
                              password = value;
                            },
                          ),
                        ),
                        SizedBox(height: 50),

                        // submit Button
                        Container(
                          margin: EdgeInsets.only(left: 30),
                          child: ElevatedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                loginBlocProvider.add(LoginFormSubmitted(
                                    email: this.email,
                                    password: this.password));
                              }
                            },
                            style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all<Size?>(
                                  Size.fromHeight(50)),
                              padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry?>(
                                  EdgeInsets.only(left: 130, right: 130)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xff61327D)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            child: Text(
                              'Log in',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.ibmPlexSans(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),

                        (state is LoginLoading)
                            ? CircularProgressIndicator()
                            : SizedBox(),

                        SizedBox(height: 10),

                        // Don't have an account? option
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?"),
                            SizedBox(
                              width: 10,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(RouteGenerator.signupChoiceName);
                              },
                              child: Text(
                                "Sign up",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
