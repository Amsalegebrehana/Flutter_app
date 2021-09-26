import 'package:delalo/delalo_app/blocs/admin_bloc/category_bloc/category_bloc.dart';
import 'package:delalo/delalo_app/blocs/admin_bloc/category_bloc/category_state.dart';
import 'package:delalo/delalo_app/blocs/admin_bloc/provider_bloc/provider_bloc.dart';
import 'package:delalo/delalo_app/blocs/admin_bloc/provider_bloc/provider_state.dart';
import 'package:delalo/delalo_app/models/category.dart';
import 'package:delalo/delalo_app/screens/bottom_nav.dart';
import 'package:delalo/delalo_app/screens/navigation_drawer/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCollectedScreen extends StatefulWidget {
  const HomeCollectedScreen({Key? key}) : super(key: key);

  @override
  _HomeCollectedScreenState createState() => _HomeCollectedScreenState();
}

class _HomeCollectedScreenState extends State<HomeCollectedScreen> {
  final double circleRadius = 50.0;
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
       drawer: NavigationDrawer(),
      bottomNavigationBar: BottomNav(),
      appBar: AppBar(actions: [],
      title: Text("Delalo"),
      backgroundColor: Colors.purple,
      ),
      body:
    Stack(
      children: [
        FeaturedCategory(),
        Padding(
          padding: EdgeInsets.only(top: 300),
          child: FeaturedProvider(),
        )
      ],
    )
    //   )
    //   // FeaturedCategory(),
    //   // FeaturedProvider()
    );
    //     Column(
    //   children: [
    //     SizedBox(
    //       height: 40,
    //     ),
    //     Center(
    //       child: Container(
    //         height: 70,
    //         width: 150,
    //         child: Center(
    //           child: Text(
    //             "Top providers",
    //             style: TextStyle(
    //                 color: Colors.black,
    //                 fontSize: 20,
    //                 fontWeight: FontWeight.bold),
    //           ),
    //         ),
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.only(
    //             bottomLeft: Radius.circular(10.0),
    //             bottomRight: Radius.circular(10.0),
    //             topLeft: Radius.circular(10.0),
    //             topRight: Radius.circular(10.0),
    //           ),
    //         ),
    //       ),
    //     ),
    //     Container(
    //       height: 175.0,
    //       decoration: BoxDecoration(
    //         color: Colors.purple[100],
    //         borderRadius: BorderRadius.only(
    //           bottomLeft: Radius.circular(100.0),
    //           bottomRight: Radius.circular(10.0),
    //         ),
    //       ),
    //     ),
    //     new Expanded(
    //         child: ListView.builder(
    //             itemCount: 4,
    //             scrollDirection: Axis.horizontal,
    //             itemBuilder: (_, index) {
    //               return Padding(
    //                 padding: const EdgeInsets.all(10.0),
    //                 child: Column(
    //                   children: [
    //                     Stack(
    //                       children: [
    //                         Stack(
    //                           children: [
    //                             Container(
    //                               height: 150.0,
    //                               width: 150.0,
    //                               decoration: BoxDecoration(
    //                                 borderRadius: BorderRadius.circular(15.0),
    //                                 color: Colors.grey[150],
    //                                 boxShadow: [
    //                                   BoxShadow(
    //                                     color: Colors.black12,
    //                                     blurRadius: 1.0,
    //                                     offset: Offset(0.0, 1.0),
    //                                   ),
    //                                 ],
    //                               ),
    //                               child: Column(
    //                                 children: [
    //                                   SizedBox(
    //                                     height: 30,
    //                                   ),
    //                                   Text(
    //                                     "name",
    //                                     style: TextStyle(
    //                                         fontWeight: FontWeight.w300,
    //                                         fontSize: 20.0),
    //                                   ),
    //                                   Text(
    //                                     " provider.address",
    //                                     style: TextStyle(
    //                                         fontWeight: FontWeight.w300,
    //                                         fontSize: 12.0,
    //                                         color: Colors.black),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                             Container(
    //                               width: circleRadius,
    //                               height: circleRadius,
    //                               decoration: BoxDecoration(
    //                                 shape: BoxShape.circle,
    //                                 color: Colors.white,
    //                                 boxShadow: [
    //                                   BoxShadow(
    //                                     color: Colors.black26,
    //                                     blurRadius: 8.0,
    //                                     offset: Offset(0.0, 5.0),
    //                                   ),
    //                                 ],
    //                               ),
    //                               child: Padding(
    //                                 padding: EdgeInsets.all(4.0),
    //                                 child: Center(
    //                                   child: Container(
    //                                     child: Icon(Icons.person),

    //                                     /// replace your image with the Icon
    //                                   ),
    //                                 ),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //               );
    //             }))
    //   ],
    // ));
  }
}

class FeaturedCategory extends StatefulWidget {
  const FeaturedCategory({Key? key}) : super(key: key);

  @override
  _FeaturedCategoryState createState() => _FeaturedCategoryState();
}

class _FeaturedCategoryState extends State<FeaturedCategory> {
  @override
  Widget build(BuildContext context) {
    final categoryBloc = BlocProvider.of<AdminCategoryBloc>(context);
    final Category categorys;
    String categoryName = "";
    String categoryDescription = "";

    return BlocBuilder<AdminCategoryBloc, CategoryState>(
        builder: (_, categoryState) {
      if (categoryState is CategoryLoading) {
        return CircularProgressIndicator();
      } else if (categoryState is CategoryOperationFailed) {
        return Text("Loading failed");
      } else if (categoryState is CategoryLoaded) {
        final categories = categoryState.catagories;
        return ListView.builder(
            //  scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (_, index) {
              final category = categories[index];
              if (category.numOfProviders >= 10) {
                return Card(
                  color: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadowColor: Colors.black,
                  child: Center(
                    child: ExpansionTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(''),
                      ),
                      title: Text(
                        category.name,
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(
                        'Number of providers: ${(category.numOfProviders).toString()}',
                        style: TextStyle(color: Colors.black),
                      ),
                      children: [
                        ListTile(
                          title: Text(
                            category.description,
                          ),
                          subtitle: Text(
                            category.description,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Container();
            });
      }
      return Container();
    });
  }
}

class FeaturedProvider extends StatefulWidget {
  const FeaturedProvider({Key? key}) : super(key: key);

  @override
  _FeaturedProviderState createState() => _FeaturedProviderState();
}

class _FeaturedProviderState extends State<FeaturedProvider> {
  @override
  Widget build(BuildContext context) {
    final providersBloc = BlocProvider.of<ProvidersBloc>(context);

    return BlocBuilder<ProvidersBloc, ProvidersState>(
        builder: (_, providersState) {
      if (providersState is ProviderLoading) {
        return CircularProgressIndicator();
      } else if (providersState is ProvidersOperationsFailed) {
        return Text("Loading failed");
      } else if (providersState is ProviderLoaded) {
        final providers = providersState.providers;
        return ListView.builder(
            //  scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (_, index) {
              final provider = providers[index];
              if (provider.role == 'provider') {
                return Container(
                  //  color: Colors.grey[100],

                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage('https://picsum.photos/250?image=9'),
                    ),
                    title: Text(provider.firstname),
                    subtitle: Text(provider.lastname),
                  ),
                );
              }
              return Container();
            });
      }
      return Container();
    });
  }
}
