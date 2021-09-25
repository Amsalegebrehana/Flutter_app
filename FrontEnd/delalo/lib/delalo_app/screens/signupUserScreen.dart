import 'package:delalo/delalo_app/blocs/auth_bloc/signupUser_bloc/signupUser_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routeGenerator.dart';

class SignupUserForm extends StatefulWidget {
  SignupUserForm({Key? key}) : super(key: key);

  @override
  _SignupUserFormState createState() => _SignupUserFormState();
}

class _SignupUserFormState extends State<SignupUserForm> {
  final _formKey = GlobalKey<FormState>();
  late String firstname;
  late String lastname;
  final String role = "user";
  late String email;
  late String password;
  late String phone;
  late String address;
  late String image = "assets/images/user.png";

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);

  final emailValidator = MultiValidator([
    EmailValidator(errorText: 'Invalid email'),
    RequiredValidator(errorText: "Email is required")
  ]);

  final nameValidator =
      MultiValidator([RequiredValidator(errorText: "Field is required")]);

  final phoneValidator =
      MultiValidator([RequiredValidator(errorText: "phone is required")]);

  @override
  Widget build(BuildContext context) {
    final signupUserBlocProvider = BlocProvider.of<SignupUserBloc>(context);
    return Scaffold(
      body: BlocConsumer<SignupUserBloc, SignupUserState>(
        listener: (_, state) {
          if (state is SignupUserFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                duration: Duration(seconds: 4),
              ),
            );
            print(state.error);
          } else if (state is SignupUserSuccess) {
            Navigator.of(context)
                .pushNamed(RouteGenerator.singleProviderPageName);
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
                    'Sign up',
                    style: GoogleFonts.ibmPlexSans(
                      fontSize: 30,
                      fontWeight: FontWeight.w300,
                    ),
                  ),

                  // login illustration
                  Image.asset(
                    'assets/images/signup.png',
                    height: 260,
                    width: 230,
                  ),
                  SizedBox(height: 30),

                  // Form goes here
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Add TextFormFields and ElevatedButton here.

                        // email field
                        Container(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                              icon: Icon(Icons.email),
                              labelText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            validator: emailValidator,
                            onChanged: (value) {
                              this.email = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        // firstname field
                        Container(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: TextFormField(
                            // The validator receives the text that the user has entered.
                            decoration: InputDecoration(
                              icon: Icon(Icons.account_circle),
                              labelText: "First name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            validator: nameValidator,
                            onChanged: (value) {
                              this.firstname = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        // last name field
                        Container(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: TextFormField(
                            // The validator receives the text that the user has entered.
                            decoration: InputDecoration(
                              icon: Icon(Icons.account_circle),
                              labelText: "Last name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            validator: nameValidator,
                            onChanged: (value) {
                              this.lastname = value;
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
                              this.password = value;
                            },
                          ),
                        ),
                        SizedBox(height: 20),

                        // phone number field
                        Container(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: TextFormField(
                            // The validator receives the text that the user has entered.
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              icon: Icon(Icons.phone),
                              labelText: "Phone No",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            validator: phoneValidator,
                            onChanged: (value) {
                              this.phone = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        // address dropdown field============================

                        Container(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: TextFormField(
                            // The validator receives the text that the user has entered.
                            decoration: InputDecoration(
                              icon: Icon(Icons.place),
                              labelText: "Address",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            validator: nameValidator,
                            onChanged: (value) {
                              this.address = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // Container(
                        //   padding: EdgeInsets.only(right: 20, left: 20),
                        //   child: DropdownButtonFormField(
                        //     decoration: InputDecoration(
                        //       icon: Icon(Icons.place),
                        //       labelText: "Address",
                        //       border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(20),
                        //       ),
                        //     ),
                        //     value: _selectedValue,
                        //     hint: Text(
                        //       'choose one',
                        //     ),
                        //     isExpanded: true,
                        //     onChanged: (input) {
                        //       this.address = input.toString();
                        //       setState(() {
                        //         _selectedValue = input.toString();
                        //       });
                        //     },
                        //     onSaved: (input) {
                        //       setState(() {
                        //         _selectedValue = input.toString();
                        //       });
                        //     },
                        //     validator: nameValidator,
                        //     items: _locations.map((String val) {
                        //       return DropdownMenuItem(
                        //         value: val,
                        //         child: Text(
                        //           val,
                        //         ),
                        //       );
                        //     }).toList(),
                        //   ),
                        // ),
                        // SizedBox(height: 20),

                        (state is SignupUserLoading)
                            ? CircularProgressIndicator()
                            : SizedBox(),

                        SizedBox(height: 10),

                        // submit Button
                        Container(
                          margin: EdgeInsets.only(left: 30),
                          child: ElevatedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                signupUserBlocProvider.add(
                                  SignupUserFormSubmitted(
                                      email: this.email,
                                      password: this.password,
                                      firstname: this.firstname,
                                      lastname: this.lastname,
                                      role: this.role,
                                      phone: this.phone,
                                      image: this.image,
                                      address: this.address),
                                );
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
                              'Sign up',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.ibmPlexSans(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),

                        // Don't have an account? option
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 0,
                              child: Text("Already have an account?"),
                            ),
                            Expanded(
                              flex: 0,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      RouteGenerator.loginScreenName);
                                },
                                child: Text(
                                  "Login",
                                ),
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
