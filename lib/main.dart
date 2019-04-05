import 'package:flutter/material.dart';
import 'package:eating_project_app/product/list.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      title: 'Product Keeper',

      theme: new ThemeData(
        primarySwatch: Colors.deepPurple,
      ),

      home: new ProductList(),
    );
  }
}
