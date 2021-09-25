import 'package:delalo/delalo_app/screens/category_page.dart';
import 'package:delalo/delalo_app/screens/home_page.dart';
import 'package:delalo/delalo_app/screens/provider_list_page.dart';
import 'package:delalo/delalo_app/screens/signupProviderScreen.dart';
import 'package:flutter/material.dart';
import 'delalo_app/screens/admin/adminScreens.dart';
import 'delalo_app/screens/admin/category_list.dart';
import 'delalo_app/screens/allScreens.dart';
import 'delalo_app/screens/hometools/listview.dart';

class RouteGenerator {
  static const String welcomeScreenName = "/welcome";
  static const String getStartedScreenName = "/getStartedScreen";
  static const String signupChoiceName = "/signUpChoiceScreen";
  static const String singleProviderPageName = "/singleProviderPage";
  static const String loginScreenName = "/loginScreen";
  static const String signupUserScreenName = "/signupUserScreen";
  static const String signupProviderScreenName = "/signupProviderScreen";
  static const String ordersScreenName = "/orderScreen";
  static const String jobsScreenName = "/jobScreen";
  static const String orderDetailScreenName = "/orderDetails";
  static const String categoryListPage = "/cateogry";
  static const String providerListPage = "/providerlist";
  static const String adminScreenName = "/adminscreen";
  static const String adminCategoryListName = "/admincategorylist";
  static const String homePageName = "/homePage";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcomeScreenName:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case adminCategoryListName:
        return MaterialPageRoute(builder: (_) => AdminCategoryList());
      case adminScreenName:
        return MaterialPageRoute(builder: (_) => AdminScreen());
      case getStartedScreenName:
        return MaterialPageRoute(builder: (_) => GetStartedScreen());
      case loginScreenName:
        return MaterialPageRoute(builder: (_) => LoginForm());
      case signupChoiceName:
        return MaterialPageRoute(builder: (_) => SignupChoice());
      case signupUserScreenName:
        return MaterialPageRoute(builder: (_) => SignupUserForm());
      case ordersScreenName:
        return MaterialPageRoute(builder: (_) => OrdersScreen());
      case jobsScreenName:
        return MaterialPageRoute(builder: (_) => JobsScreen());
      case categoryListPage:
        return MaterialPageRoute(builder: (_) => CategoryPage());
      case singleProviderPageName:
        // return MaterialPageRoute(builder: (_) => ProviderProfile());
      case homePageName:
        return MaterialPageRoute(builder: (_) => HomeCollectedScreen());
      case providerListPage:
        final args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(builder: (context) {
          return ProviderListPage(argObj: args.argObj);
        });
      case orderDetailScreenName:
        final args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(builder: (context) {
          return OrderDetailsScreen(
            argObj: args.argObj,
          );
        });

      default:
        throw FormatException("Route was not found");
    }
  }
}

class ScreenArguments {
  Map argObj;

  ScreenArguments(this.argObj);
}
