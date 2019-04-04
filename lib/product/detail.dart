import 'dart:async';
import 'package:flutter/material.dart';
import 'package:eating_project_app/models/product.dart';
import 'package:eating_project_app/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class ProductDetail extends StatefulWidget {

  String appBarTitle;

  ProductDetail(this.appBarTitle);

  @override
  State<StatefulWidget> createState() {

    return ProductDetailState(this.appBarTitle);
  }
}

class ProductDetailState extends State<ProductDetail> {

  static var _priorities = ['Hight', 'Middle', 'Low'];
  String appBarTitle;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  ProductDetailState(this.appBarTitle);

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    return WillPopScope(
      onWillPop: () {
        moveToLastScreen();
      },

      child: Scaffold(

        appBar: AppBar(
          title: Text(appBarTitle),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              moveToLastScreen();
            },),
        ),

        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[


              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextField(
                  controller: titleController,
                  style: textStyle,
                  onChanged: (value) {
                    debugPrint("Something is changed in Title Text Field");
                  },
                  decoration: InputDecoration(
                    labelStyle: textStyle,
                    labelText: "Title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    )
                  ),
                ),
              ),


              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextField(
                  controller: descriptionController,
                  style: textStyle,
                  onChanged: (value) {
                    debugPrint("Something is changed in Description Text Field");
                  },
                  decoration: InputDecoration(
                      labelStyle: textStyle,
                      labelText: "Description",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                ),
              ),


              ListTile(
                title: DropdownButton(

                    items: _priorities.map((String dropDownStringItem) {
                      return DropdownMenuItem<String> (
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),

                    style: textStyle,

                    value: 'Low',

                    onChanged: (valueSelectedByUser) {
                      setState(() {
                        debugPrint("User selected $valueSelectedByUser");
                      });
                    }
                ),
              ),


              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Row(
                  children: <Widget>[

                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            debugPrint('Save button is clicked');
                          });
                        },
                      ),
                    ),

                    Container(width: 5.0,),

                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Delete',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            debugPrint('Delete button is clicked');
                          });
                        },
                      ),
                    )

                  ],
                ),
              ),

            ],
          ),
        ),
      )
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context);
  }
}
