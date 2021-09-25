import 'package:delalo/delalo_app/blocs/search_bloc/search_bloc.dart';
import 'package:delalo/delalo_app/blocs/search_bloc/search_event.dart';
import 'package:delalo/delalo_app/blocs/search_bloc/search_state.dart';
import 'package:delalo/delalo_app/screens/bottom_nav.dart';
import 'package:delalo/delalo_app/screens/navigation_drawer/navigation.dart';
import 'package:delalo/delalo_app/screens/provider_list_page.dart';
import 'package:delalo/routeGenerator.dart';
import 'package:flutter/material.dart';
// import 'package:delalo/routeGenerator.dart';
import 'package:flutter/cupertino.dart';
import 'package:delalo/delalo_app/blocs/category/category_bloc.dart';
import 'package:delalo/delalo_app/blocs/category/category_event.dart';
import 'package:delalo/delalo_app/blocs/category/category_state.dart';
import 'package:delalo/delalo_app/blocs/blocs.dart';
import 'package:delalo/delalo_app/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);
  static final routeName = "/category";

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
 
  @override
  Widget build(BuildContext context) {
    // final categoryBloc = BlocProvider.of<CategoryBloc>(context);
     final searchBloc=BlocProvider.of<SearchBloc>(context);
    return Scaffold(
      drawer: NavigationDrawer(),
      bottomNavigationBar: BottomNav(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        actions: <Widget>[
          IconButton(
                  onPressed: (){
                    showSearch(
                    context: context, 
                    delegate: SearchCategory(
                      searchBloc: searchBloc
                      )
                    );
                  },
                  icon: Icon(Icons.search),
                )
        ],
        
      ),
      // categoryBloc.add()
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (Context, CategoryState) {
          print(CategoryState);
          if (CategoryState is CategoryLoading) {
            return Text("Loading...");
          }

          if (CategoryState is CategoryOperationFailure) {
            return Text("Sorry loading failed");
          }

          if (CategoryState is CategoriesLoadSuccess) {
            final categories = CategoryState.categories;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  itemCount: categories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 8.0 / 8.0,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return Expanded(
                      child: GestureDetector(
                        onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProviderListPage(argObj: {'category_name':category.name})));
                          // Navigator.pushNamed(context, RouteGenerator.providerListPage,
                          // arguments: ScreenArguments({"category_name":category.name}));
                        },
                        child: Card(   
                           color: Colors.grey[100],
                            semanticContainer: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                      child: Container(
                                          child: Center(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 20),
                                      child: Column(
                                        children: [
                                          if(category.name =="Cleaning")
                                            Icon(Icons.cleaning_services_outlined,size: 50,),
                                          if(category.name=="Electrician")
                                            Icon(Icons.electrical_services_outlined,size: 50),
                                          if(category.name=="Plumber")
                                            Icon(Icons.plumbing_sharp,size: 50),
                                          if(category.name=="Painting")
                                            Icon(Icons.brush_outlined,size: 50),
                                          if(category.name=="Mechanic")
                                            Icon(Icons.motorcycle_outlined,size: 50),
                                          if(category.name=="Tutor")
                                            Icon(Icons.book_online_outlined,size: 50),

                                          SizedBox(
                                            height: 7,
                                          ),
                                          Text(
                                            category.name,
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.people),
                                               Text(
                                                category.numOfProviders.toString()+" providers available",
                                                style: TextStyle(fontSize: 10),
                                          ),
                                            ],
                                            
                                            )
                                         
                                        ],
                                      ),
                                    ),
                                  )))
                                ]
                                )
                            ),
                      ),
                    );
                  }),
            );
          }

          return Container();
        },
      ),
    );
  }

}

// onTap:(){Navigator.pushNamed(
//                           context, 
//                           RouteGenerator.providerListPage,
//                           arguments: ScreenArguments({"category":category.name})
//                         );},


class SearchCategory extends SearchDelegate<List>{
  SearchBloc searchBloc;
  SearchCategory({required this.searchBloc});
 
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: (){
          query='';
        }, 
        icon: Icon(Icons.clear),
      )
    ];
      
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: (){
        close(context,[]);
        },
      icon: Icon(Icons.arrow_back_ios)
     
     );
  }

  @override
  Widget buildResults(BuildContext context) {
      searchBloc.add(Search(query:query));
      print(query);
      return BlocBuilder<SearchBloc,SearchState>(
        builder: (BuildContext context,SearchState state) {
          print(state);
          if(state is SearchUninitialized){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(state is SearchError){
            return Center(
              child: Text("Failed to load"),
            );
          }
          else if(state is SearchLoaded){
            if(state.categories.isEmpty){
              return Center(
                child: Text("No results found"),
              );
            }
            else{
               return ListView.builder(
                itemCount: state.categories.length,
                itemBuilder: (_, index) {
                  final category = state.categories[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Card(
                      color: Colors.purple[50],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      shadowColor: Colors.black,
                      child: ListTile(
                        title: Text(category.description),
                        subtitle: Text(
                            'Number of providers: ${category.numOfProviders}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                        ),
                      ),
                    ),
                  );
                }
                );
              }
          }
          return Container();
        }
      );
  }
              
  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
  

}
