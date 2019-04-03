import 'package:flutter/material.dart';
import 'package:eating_project_app/product/detail.dart';
import 'package:eating_project_app/product/list.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      title: 'Startup Name Generator',

      theme: new ThemeData(
        primaryColor: Colors.deepPurple,
        primaryColorDark: Colors.deepPurple[600],
        primaryColorLight: Colors.white,
      ),

      home: new ProductDetail(),
    );
  }
}

// https://www.youtube.com/watch?v=iY2RYQKPm84
