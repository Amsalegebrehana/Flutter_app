import 'package:delalo/delalo_app/blocs/auth_bloc/signupProvider_bloc/signupProvider_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routeGenerator.dart';

class SignupProviderForm extends StatefulWidget {
  SignupProviderForm({Key? key}) : super(key: key);

  @override
  _SignupProviderFormState createState() => _SignupProviderFormState();
}

class _SignupProviderFormState extends State<SignupProviderForm> {
  final _formKey = GlobalKey<FormState>();

  // form field fields
  late String firstname;
  late String lastname;
  late String email;
  late String password;
  late String phone;
  late String description;
  late String recommendation;
  late String perHourWage;
  late String address;

  String category = '';

  final String role = "provider";
  final String image = "assets/images/user.png";

  late String _selectedCategoryValue;

  late List<String> _categories;

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
    final signupProviderBlocProvider =
        BlocProvider.of<SignupProviderBloc>(context);
    return Scaffold(
      body: BlocConsumer<SignupProviderBloc, SignupProviderState>(
        listener: (_, state) {
          if (state is SignupProviderFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                duration: Duration(seconds: 4),
              ),
            );
            print(state.error);
          } else if (state is SignupProviderSuccess) {
            Navigator.of(context)
                .pushNamed(RouteGenerator.singleProviderPageName);
          }
        },
        builder: (context, state) {
          if (state is SingupProviderLoadSuccess) {
            this._categories = state.categoryLst;
            this._selectedCategoryValue = state.categoryLst[0];
          }
          if (state is SignupProviderInitial) {
            this._categories = ['maek', 'build', 'set', 'after'];
            this._selectedCategoryValue = 'build';
          }
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
                        // email field==========================================================
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

                        // firstname field==========================================================
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

                        // last name field===========================================================
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

                        // password field==============================================================
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

                        // recommendation link field=============================================================
                        Container(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: TextFormField(
                            // The validator receives the text that the user has entered.
                            decoration: InputDecoration(
                              icon: Icon(Icons.insert_link),
                              labelText: "Recommendation Link",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            validator: (value) {
                              var val = value.toString();
                              if (!Uri.parse(val).isAbsolute) {
                                return 'Invalid link';
                              } else if (value == null) {
                                return 'Field is required';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              this.recommendation = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        // phone number field===================================================================
                        Container(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: TextFormField(
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

                        // per hour wage field====================================================================
                        Container(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: TextFormField(
                            // The validator receives the text that the user has entered.
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              icon: Icon(Icons.attach_money),
                              labelText: "Per Hour Wage",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            validator: nameValidator,
                            onChanged: (value) {
                              this.perHourWage = value;
                            },
                          ),
                        ),
                        SizedBox(height: 20),

                        // category dropdown field ===============================================================
                        Container(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              icon: Icon(Icons.work),
                              labelText: "Category",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            value: _selectedCategoryValue,
                            hint: Text(
                              'choose one',
                            ),
                            isExpanded: true,
                            onChanged: (input) {
                              this.category = input.toString();
                              // setState(() {
                              //   _selectedCategoryValue = input.toString();
                              // });
                            },
                            onSaved: (input) {
                              // setState(() {
                              //   _selectedCategoryValue = input.toString();
                              // });
                            },
                            items: _categories.map((String val) {
                              print(val);
                              return DropdownMenuItem(
                                value: val,
                                child: Text(
                                  val,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(height: 20),

                        // address dropdown field=================================================================
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

                        // Description Field ===============================================================
                        Container(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                              icon: Icon(Icons.description),
                              labelText: "Description",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            validator: nameValidator,
                            onChanged: (value) {
                              this.description = value;
                            },
                            minLines: 6,
                            maxLines: 10,
                          ),
                        ),
                        SizedBox(height: 40),

                        (state is SignupProviderLoading)
                            ? CircularProgressIndicator()
                            : SizedBox(),

                        SizedBox(height: 10),

                        // submit Button
                        Container(
                          margin: EdgeInsets.only(left: 30),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                signupProviderBlocProvider.add(
                                  SignupProviderFormSubmitted(
                                      email: this.email,
                                      password: this.password,
                                      firstname: this.firstname,
                                      lastname: this.lastname,
                                      role: this.role,
                                      phone: this.phone,
                                      image: this.image,
                                      address: this.address,
                                      description: this.description,
                                      category: this.category,
                                      recommendation: this.category,
                                      perHourWage: int.parse(this.perHourWage)),
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
                            Text("Already have an account?"),
                            SizedBox(
                              width: 10,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(RouteGenerator.loginScreenName);
                              },
                              child: Text(
                                "Login",
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
