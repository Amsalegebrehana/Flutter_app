import 'package:delalo/delalo_app/blocs/admin_bloc/category_bloc/category_bloc.dart';
import 'package:delalo/delalo_app/blocs/admin_bloc/category_bloc/category_event.dart';
import 'package:delalo/delalo_app/blocs/admin_bloc/category_bloc/category_state.dart';
import 'package:delalo/delalo_app/models/category.dart';
import 'package:delalo/delalo_app/screens/admin/category_list.dart';
import 'package:delalo/routeGenerator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminAddUpdateCategory extends StatefulWidget {
  static const routeName = '/updateAdd';
  // final CategoryArgument args;
  // final Map args;

  const AdminAddUpdateCategory({Key? key}) : super(key: key);

  @override
  _AdminAddUpdateCategoryState createState() => _AdminAddUpdateCategoryState();
}

class _AdminAddUpdateCategoryState extends State<AdminAddUpdateCategory> {
  // final categoryBloc = BlocProvider.of<CategoryBloc>(context);

  final _formKey = GlobalKey<FormState>();
  late String name;
  late String description;
  final Map<String, dynamic> _category = {};

  @override
  Widget build(BuildContext context) {
    final categoryBloc = BlocProvider.of<AdminCategoryBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Delalo"),
      ),
      body: BlocConsumer<AdminCategoryBloc, CategoryState>(
        listener: (_, state) {
          // TO DO: implement listener
          // if (state is CategoryLoading) {
          //   CircularProgressIndicator();
          // } else if (state is CategoryOperationFailed) {
          //   Text("Loading failed");
          // } else if (state is CategoryLoaded) {
          //   Navigator.push(context,
          //       MaterialPageRoute(builder: (context) => AdminCategoryList()));
          //   // Navigator.of(context).pushNamed(AdminCategoryList.routeName);
          // }

          if (state is CategoryNavigate) {
            print('new debug...4');
            BlocProvider.of<AdminCategoryBloc>(context)
                .add(LoadAllCategories());
            Navigator.pushNamed(context, RouteGenerator.adminScreenName);
          }
        },
        builder: (context, state) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
              child: Form(
                  key: _formKey,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Center(
                        child: Text(
                          "Add Category",
                        ),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Category Name';
                          }
                          return null;
                        },
                        onChanged: (val) {
                          name = val;
                        },
                        decoration: InputDecoration(
                            icon: Icon(Icons.category),
                            labelText: "Category Name"),
                      ),
                      // SizedBox(height: 20,),
                      // TextFormField(
                      //   decoration: InputDecoration(
                      //     icon: Icon(Icons.image),
                      //     labelText: "Category Image"
                      //   ),
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        onChanged: (val) {
                          description = val;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Category Description';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            icon: Icon(Icons.description),
                            labelText: "Category Description"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FloatingActionButton.extended(
                        onPressed: () {
                          final form = _formKey.currentState;
                          if (form!.validate()) {
                            final category = Category(
                                name: this.name,
                                image: 'category',
                                numOfProviders: 0,
                                description: this.description);
                            categoryBloc.add(AddCategory(category));
                          }
                          AdminCategoryList.routeName;
                        },
                        label: Text("Save"),
                        backgroundColor: Colors.purple,
                        icon: Icon(Icons.save),
                      )
                    ],
                  )),
            ),
          );
        },
      ),
    );
  }
}
