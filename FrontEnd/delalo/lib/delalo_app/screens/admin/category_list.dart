import 'package:delalo/delalo_app/blocs/admin_bloc/category_bloc/category_event.dart';
import 'package:delalo/delalo_app/blocs/admin_bloc/category_bloc/category_state.dart';
import 'package:delalo/delalo_app/blocs/admin_bloc/category_bloc/category_bloc.dart';
import 'package:delalo/delalo_app/blocs/admin_bloc/category_bloc/category_state.dart';
import 'package:delalo/delalo_app/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'category_add.dart';

class AdminCategoryList extends StatefulWidget {
  static const routeName = '/';
  // final CategoryArgument args;

  const AdminCategoryList({Key? key}) : super(key: key);

  @override
  _AdminCategoryListState createState() => _AdminCategoryListState();
}

class _AdminCategoryListState extends State<AdminCategoryList> {
  get category => null;

  @override
  Widget build(BuildContext context) {
    late String description;
    final categoryBloc = BlocProvider.of<AdminCategoryBloc>(context);
   
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // final category = Category(name: "De");
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AdminAddUpdateCategory();
          }));
          // AdminAddUpdateCategory();
        }
        // Navigator.of(context).pushNamed(AddCategory)
        // {
        //   final category = Category(
        //       id: "1",
        //       name: 'Deliver',
        //       image: 'shopping_cart',
        //       numOfProviders: 13,
        //       description: "Delivery category");
        //   categoryBloc.add(AddCategory(category));
        // }
        ,
        icon: Icon(Icons.add),
        label: const Text('Add'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: BlocBuilder<AdminCategoryBloc, CategoryState>(
            builder: (_, categoryState) {
          if (categoryState is CategoryLoading) {
            return CircularProgressIndicator();
          } else if (categoryState is CategoryOperationFailed) {
            return Text("Loading failed");
          } else if (categoryState is CategoryLoaded) {
            final categories = categoryState.catagories;
            return Padding(
              padding: const EdgeInsets.only(top: 15),
              child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (_, index) {
                    final category = categories[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                        height: 200,
                        width: 70,
                        margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),

                          ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius:5,
                                blurRadius: 7, 
                                offset: Offset(0,3),
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              //the above row
                            
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: ListTile(
                                  leading: Icon(Icons.category),
                                  title: Text(
                                        category.name,
                                        style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                        
                                        color: Colors.black),
                                    ),
                                    subtitle: Text(
                                            'Number of providers: ${(category.numOfProviders).toString()}',
                                            style: TextStyle(color: Colors.black),
                                        ),
                                    trailing:
                                            Column(mainAxisSize: MainAxisSize.min , children: [
                                            // IconButton(
                                            //   onPressed: () {},
                                            //   icon: Icon(
                                            //     Icons.edit,
                                            //     color: Colors.green,
                                            //   ),
                                            // ),
                                            Expanded(
                                              child: IconButton(
                                              onPressed: () {
                                                  showDialog<void>(
                                                  context: context,
                                                  builder: (BuildContext context) =>
                                                      AlertDialog(
                                                      title: Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: Column(
                                                          children: [
                                                          const Text(
                                                              'Edit Category',
                                                              style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight: FontWeight.w400,
                                                              ),
                                                              textAlign: TextAlign.center,
                                                          ),
                                                          Text('${category.name}')
                                                          ],
                                                      ),
                                                      ),
                                                      content: Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.stretch,
                                                          //position
                                                          mainAxisSize: MainAxisSize.min,
                                                          // wrap content in flutter
                                                          children: [
                                                          TextFormField(
                                                              onChanged: (val) {
                                                              description =  val;
                                                              //  this.category
                                                              },
                                                              decoration: InputDecoration(
                                                                  labelText:
                                                                      "Category Description",
                                                                  hintText:
                                                                      '${category.description}'),
                                                          ),
                                                          ],
                                                      ),
                                                      ),
                                                      contentPadding:
                                                          EdgeInsets.fromLTRB(30, 10, 5, 10),
                                                      actions: <Widget>[
                                                      TextButton(
                                                          onPressed: () {
                                                          Navigator.pop(context);
                                                          },
                                                          child: const Text('Cancel'),
                                                      ),
                                                      TextButton(
                                                          onPressed: () {
                                                          final newCategory =  Category(
                                                              id: category.id,
                                                              name: category.name,
                                                              numOfProviders:
                                                                  category.numOfProviders,
                                                              image: category.image,
                                                              description:description);
                                                          categoryBloc.add(
                                                              CategoryUpdate(newCategory));
                                                          Navigator.pop(context, 'OK');
                                                          },
                                                          child: const Text(
                                                          'Edit',
                                                          style:
                                                              TextStyle(color: Colors.green),
                                                          ),
                                                      ),
                                                      ],
                                                  ),
                                                  );
                                              },
                                              icon: Icon(
                                                  Icons.edit,
                                                  color: Colors.green,
                                              ),
                                              ),
                                            ),

                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 10),
                                                child: IconButton(
                                                onPressed: () {
                                                    showDialog<void>(
                                                    context: context,
                                                    builder: (BuildContext context) =>
                                                        AlertDialog(
                                                        title: Padding(
                                                        padding: const EdgeInsets.all(10.0),
                                                        child: const Text(
                                                            'Are you sure you want to delete this Category?',
                                                            style: TextStyle(
                                                            fontSize: 18,
                                                            ),
                                                            textAlign: TextAlign.center,
                                                        ),
                                                        ),
                                                        content: Padding(
                                                        padding: const EdgeInsets.all(10.0),
                                                        child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment.stretch,
                                                            //position
                                                            mainAxisSize: MainAxisSize.min,
                                                            // wrap content in flutter
                                                            children: [
                                                            Text(
                                                                'Category Name: ${category.name}'),
                                                            Text(
                                                                'Number of Providers: ${category.numOfProviders}')
                                                            ],
                                                        ),
                                                        ),
                                                        contentPadding:
                                                            EdgeInsets.fromLTRB(30, 10, 5, 10),
                                                        actions: <Widget>[
                                                        TextButton(
                                                            onPressed: () {
                                                            Navigator.pop(context);
                                                            },
                                                            child: const Text('Cancel'),
                                                        ),
                                                        TextButton(
                                                            onPressed: () {
                                                            categoryBloc.add(
                                                                CategoryDelete(category.id));
                                                            Navigator.pop(context, 'OK');
                                                            },
                                                            child: const Text(
                                                            'Delete',
                                                            style: TextStyle(color: Colors.red),
                                                            ),
                                                        ),
                                                        ],
                                                    ),
                                                    );
                                                },
                                                icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                ),
                                                ),
                                              ),
                                            ),
                                        
          
          
          
                                             ]),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 50, 5, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Container(
                                        // color: Colors.amber,
                                        child: Text(category.description)),
                                    )
                                  ],
                                )
                              )
                            ],
                          ),
                      )
                     

                    );
                  }),
            );
          }
          return Container();
        }),
      ),
    );
  }
}
