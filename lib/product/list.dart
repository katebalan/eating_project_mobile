import 'dart:async';
import 'package:flutter/material.dart';
import 'package:eating_project_app/models/product.dart';
import 'package:eating_project_app/utils/database_helper.dart';
import 'package:eating_project_app/product/detail.dart';
import 'package:sqflite/sqflite.dart';

class ProductList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return ProductListState();
  }
}

class ProductListState extends State<ProductList> {

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Product> productList;
  int count = 0;

  @override
  Widget build(BuildContext context) {

    if (productList == null) {
      productList = List<Product>();
      updateListView();
    }

    return Scaffold(

      appBar: AppBar(
        title: Text('Products'),
      ),

      body: getProductListView(),

      floatingActionButton: FloatingActionButton(

        onPressed: () {
          debugPrint("add button was tabbed");
          navigateToProductDetail("New Product");
        },

        tooltip: 'Add Product',

        child: Icon(Icons.add),

        backgroundColor: Colors.deepPurple,
      ),
    );
  }

  ListView getProductListView() {

    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(

      itemCount: count,

      itemBuilder: (BuildContext context, int position) {

        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(

            leading: CircleAvatar(
              backgroundColor: getPriorityColor(this.productList[position].priority),
              child: getPriorityIcon(this.productList[position].priority),
            ),

            title: Text(this.productList[position].title),

            subtitle: Text(this.productList[position].date),

            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.grey),
              onTap: () {
                _delete(context, this.productList[position])
              },
            ),

            onTap: () {
              debugPrint("onTap item");
              navigateToProductDetail("Edit Product");
            },
          ),
        );
      },
    );
  }


  void navigateToProductDetail(String title) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ProductDetail(title);
    }));
  }

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;
      default:
        return Colors.yellow;
    }
  }

  Icon getPriorityIcon(int priority) {
    switch (priority) {
      default:
        return Icon(Icons.play_arrow);
    }
  }

  void _delete(BuildContext context, Product product) async {
    int result = await databaseHelper.deleteProduct(product.id);
    if (result != 0) {
      _showSnackBar(context, 'Note Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<Product>> productListFuture =  databaseHelper.getProductList();
      productListFuture.then((productList) {
        setState(() {
          this.productList = productList;
          this.count = productList.length;
        });
      });
    });
  }
}
