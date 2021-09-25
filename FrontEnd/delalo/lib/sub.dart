import 'package:delalo/delalo_app/blocs/auth_bloc/signupUser_bloc/signupUser_bloc.dart';
import 'package:delalo/delalo_app/blocs/blocs.dart';
import 'package:delalo/delalo_app/blocs/category/category_bloc.dart';
import 'package:delalo/delalo_app/blocs/user/provider_bloc/provider_bloc.dart';
import 'package:delalo/delalo_app/blocs/user/provider_bloc/provider_event.dart';
import 'package:delalo/delalo_app/blocs/category/category_event.dart';
import 'package:delalo/delalo_app/blocs/category/category_state.dart';
import 'package:delalo/delalo_app/data_provider/auth_data/singupUser_data.dart';
import 'package:delalo/delalo_app/data_provider/user_data/provider_data.dart';
import 'package:delalo/delalo_app/exports.dart';
import 'package:delalo/delalo_app/screens/home_page.dart';
import 'package:delalo/delalo_app/delalo_app.dart';
import 'package:flutter/material.dart';
import 'package:delalo/delalo_app/screens/user_account_page.dart';
import 'package:delalo/delalo_app/screens/edit_profile_user.dart';
import 'package:delalo/delalo_app/screens/category_page.dart';
import 'package:delalo/delalo_app/screens/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'delalo_app/data_provider/user_data/category_data.dart';
import 'delalo_app/data_provider/user_data/user_data.dart';
import 'delalo_app/repository/user_repository/user_repository.dart';
import 'delalo_app/repository/user_repository/category_repository.dart';
import 'delalo_app/repository/user_repository/provider_repository.dart';
import 'delalo_app/repository/auth_repository/signupUser_repository.dart';
import 'delalo_app/delalo_app.dart';
import 'package:http/http.dart' as http;

import 'delalo_app/screens/hometools/listview.dart';

final CategoryRepository categoryRepository = CategoryRepository(
  dataProvider: CategoryDataProvider(
    httpClient: http.Client(),
  ),
);

final ProviderRepository providerRepository = ProviderRepository(
  dataProvider: UserDataProvider(
    httpClient: http.Client(),
  ),
);

final SignupUserRepository signupUserRepository = SignupUserRepository(
  dataProvider: SignupUserDataProvider(
    httpClient: http.Client(),
  ),
);

final UserRepository userRepository = UserRepository(
    dataProvider: UserOnlyDataProvider(httpClient: http.Client()));

class UserInfo {
  final String email;
  final String phoneNo;
  final String address;
  // final String id;
  final String firstname;
  final String lastname;
  final String password;
  final String role;
  const UserInfo(
    this.firstname,
    this.lastname,
    this.email,
    this.phoneNo,
    this.address,
    // this.id,
    this.password,
    this.role,
  );
}

void main() {
  runApp(MainPage());
}

String email = "bay@gmail.com";

class MainPage extends StatefulWidget {
  FirstPage createState() => FirstPage();
}

class FirstPage extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    _setValues();
    _getValues();
  }

  _getValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      String email = (prefs.getString('email') ?? '');
      // print(email);
    });
  }

  _setValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = "bay@gmail.com";
    });
    prefs.setString('email', email);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => ProviderBloc(providerRepository: providerRepository)
            ..add(
              ProviderLoad(),
            ),
        ),
        BlocProvider(
          create: (ctx) => CategoryBloc(categoryRepository: categoryRepository)
            ..add(
              CategoriesLoad(),
            ),
        ),
        BlocProvider(
            create: (ctx) => UserBloc(userRepository: userRepository)
              ..add(UserLoad(email: email))),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // initialRoute: HomePage.routeName,
          routes: {
            CategoryPage.routeName: (ctx) => CategoryPage(),
            AccountPage.routeName: (ctx) => AccountPage(),
          },
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomeCollectedScreen()
          //AccountPage()
          //HomePage(),
          ),
    );
    // HomePage(),
  }
}
//CategoryPage()));

