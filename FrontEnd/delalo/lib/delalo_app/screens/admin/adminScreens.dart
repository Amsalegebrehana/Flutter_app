

import 'package:delalo/delalo_app/screens/admin/providers_list.dart';
import 'package:flutter/material.dart';

import 'category_list.dart';
import 'orders_list.dart';

class AdminScreen extends StatefulWidget {
   static const routeName = '/';

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Icon(Icons.search)
          ],
          
          title: Text("Delalo",
        textAlign: TextAlign.center,
        ),centerTitle: true,
        backgroundColor: Colors.purple,
        
        bottom: TabBar(tabs: [
         Tab(text: 'Category'),
         Tab(text: 'Providers'),
         Tab(text: 'Order')
        ],
        ),
        
        ),
        drawer: Drawer(),
       
        body: TabBarView(
          children: [
          AdminCategoryList(),
          AdminProvidersList(),
          AdminOrdersJobs()
          ],
        ),
      ),
    );
  }
}