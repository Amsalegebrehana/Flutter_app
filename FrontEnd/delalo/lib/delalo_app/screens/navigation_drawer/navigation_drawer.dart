import 'package:delalo/delalo_app/blocs/navigation_drawer/navigation.dart';
import 'package:delalo/delalo_app/exports.dart';
import 'package:delalo/delalo_app/screens/allScreens.dart';
import 'package:delalo/routeGenerator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../category_page.dart';
import 'header.dart';


class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({ Key? key }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          children: <Widget>[
            Header(),
            const SizedBox(height: 24),
            BlocProvider(
            create :(context) => NavDrawerBloc(),
            child:
            BlocConsumer<NavDrawerBloc,NavDrawerState>(
              listener: (context,navState){
                if(navState is Account){
                 Navigator.push(context, new MaterialPageRoute(builder: (context) => new AccountPage()));
                }
                else if(navState is Orders){
                   Navigator.push(context, new MaterialPageRoute(builder: (context) => new OrdersScreen()));
                }
                else if(navState is Jobs){
                   Navigator.push(context, new MaterialPageRoute(builder: (context) => new JobsScreen()));
                }
               
                // else if(navState is LoggedOut){
                //   Navigator.of(context).pushNamed(LogoutPage.routeName);
                // }
              },
              builder: (context,navState){
                return Column(
                      children: [
                        const SizedBox(height: 24),
                        ListTile(
                          leading:Icon(Icons.account_circle),
                          title: Text("Account"),
                          onTap: (){
                            final navBloc= BlocProvider.of<NavDrawerBloc>(context);
                            navBloc.add(
                              AccountPageEvent()
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        ListTile(
                          leading:Icon(Icons.assignment),
                          title: Text("Orders"),
                          onTap: (){
                            final navBloc= BlocProvider.of<NavDrawerBloc>(context);
                            navBloc.add(
                              OrdersPageEvent()
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        ListTile(
                          leading:Icon(Icons.work),
                          title: Text("Jobs"),
                          onTap: (){
                            final navBloc= BlocProvider.of<NavDrawerBloc>(context);
                            navBloc.add(
                              JobsPageEvent()
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        ListTile(
                          leading:Icon(Icons.logout),
                          title: Text("Logout"),
                          onTap: (){
                            final navBloc= BlocProvider.of<NavDrawerBloc>(context);
                            navBloc.add(
                              LogoutPageEvent()
                            );
                          },
                        ),
                       
                      ],
            );
              },
              )
            
            ),
            
            
          ],
        ),
      ),
    );
  }
}