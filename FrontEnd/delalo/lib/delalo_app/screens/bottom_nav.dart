import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:delalo/delalo_app/blocs/bottom_nav_bloc/bottomNavigationBloc.dart';
import 'package:delalo/delalo_app/blocs/bottom_nav_bloc/bottomNavigationEvent.dart';
import 'package:delalo/delalo_app/blocs/bottom_nav_bloc/bottomNavigationState.dart';
import 'package:delalo/delalo_app/exports.dart';
import 'package:delalo/delalo_app/screens/category_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigation_drawer/navigation_drawer.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
   @override
  Widget build(BuildContext context) {
    return Container();
  }
}
  // int _currentIndex = 0;
  // PageController _pageController;

  // @override
  // void initState() {
  //   super.initState();
  //   _pageController = PageController();
  // }

  // @override
  // void dispose() {
  //   _pageController.dispose();
  //   super.dispose();
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return BottomNavyBar(
  //     selectedIndex: _selectedIndex,
  //     showElevation: true, // use this to remove appBar's elevation
  //     onItemSelected: (index) => setState(() {
  //       _selectedIndex = index;
  //       _pageController.animateToPage(index,
  //           duration: Duration(milliseconds: 300), curve: Curves.ease);
  //     }),
  //     items: [
  //       BottomNavyBarItem(
  //         icon: Icon(Icons.apps),
  //         title: Text('Home'),
  //         activeColor: Colors.red,
  //       ),
        // BottomNavyBarItem(
        //     icon: Icon(Icons.people),
        //     title: Text('Users'),
        //     activeColor: Colors.purpleAccent),
        // BottomNavyBarItem(
        //     icon: Icon(Icons.message),
        //     title: Text('Messages'),
        //     activeColor: Colors.pink),
        // BottomNavyBarItem(
        //     icon: Icon(Icons.settings),
        //     title: Text('Settings'),
        //     activeColor: Colors.blue),
  //     ],
  //   );
  // }
// }

// class BottomNav extends StatelessWidget {
//   static int currentIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: BlocConsumer<BottomNavigationBloc, BottomNavigationState>(
//           listener: (context, bottomState) {
//         if (bottomState is ShowHomePage) {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (context) => CategoryPage()));
//           // Navigator.pushNamed(context, routeName);
//         } else if (bottomState is ShowCategoryPage) {
//           print('debug...1');
//           Navigator.push(
//               context, MaterialPageRoute(builder: (context) => CategoryPage()));
//           // Navigator.pushNamed(context, RouteGenerator.categoryListPage);
//         } else if (bottomState is ShowOrdersPage) {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (context) => CategoryPage()));
//         } else if (bottomState is ShowJobsPage) {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (context) => CategoryPage()));
//         } else if (bottomState is ShowAccountPage) {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (context) => AccountPage()));
//         }
//       }, builder: (context, bottomState) {
//         currentIndex = bottomState.posIndex;
//         return Scaffold(
//           appBar: AppBar(
//             title: Text("Home"),
//           ),
//           drawer: NavigationDrawer(),
//           bottomNavigationBar: BottomNavigationBar(
//             currentIndex: currentIndex,
//             onTap: (currentIndex) {
//               if (currentIndex == 0) {
//                 final navBottomBloc =
//                     BlocProvider.of<BottomNavigationBloc>(context);
//                 navBottomBloc.add(BottomHomePageEvent());
//               } else if (currentIndex == 1) {
//                 final navBottomBloc =
//                     BlocProvider.of<BottomNavigationBloc>(context);
//                 navBottomBloc.add(BottomCategoryPageEvent());
//               } else if (currentIndex == 2) {
//                 final navBottomBloc =
//                     BlocProvider.of<BottomNavigationBloc>(context);
//                 navBottomBloc.add(BottomOrdersPageEvent());
//               } else if (currentIndex == 3) {
//                 final navBottomBloc =
//                     BlocProvider.of<BottomNavigationBloc>(context);
//                 navBottomBloc.add(BottomJobsPageEvent());
//               } else if (currentIndex == 4) {
//                 final navBottomBloc =
//                     BlocProvider.of<BottomNavigationBloc>(context);
//                 navBottomBloc.add(BottomAccountPageEvent());
//               }
//             },
//             items: [
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.home),
//                   backgroundColor: Colors.black,
//                   label: "Home"),
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.category),
//                   backgroundColor: Colors.black,
//                   label: "Category"),
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.assignment),
//                   backgroundColor: Colors.black,
//                   label: "Orders"),
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.work),
//                   backgroundColor: Colors.black,
//                   label: "Jobs"),
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.account_circle),
//                   backgroundColor: Colors.black,
//                   label: "Account"),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }


