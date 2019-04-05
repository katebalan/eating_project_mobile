import 'package:flutter/material.dart';
import 'package:eating_project_app/models/product.dart';
import 'package:eating_project_app/utils/database_helper.dart';
import 'package:intl/intl.dart';

class ProductDetail extends StatefulWidget {

  final String appBarTitle;
  final Product product;

  ProductDetail(this.product, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {

    return ProductDetailState(this.product, this.appBarTitle);
  }
}

class ProductDetailState extends State<ProductDetail> {

  static var _priorities = ['High', 'Low'];
  String appBarTitle;
  Product product;

  DatabaseHelper helper = DatabaseHelper();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  ProductDetailState(this.product, this.appBarTitle);

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    titleController.text = product.title;
    descriptionController.text = product.description;

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
                    updateTitle();
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
                    updateDescription();
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

                    value: getPriorityAsString(product.priority),

                    onChanged: (valueSelectedByUser) {
                      setState(() {
                        debugPrint("User selected $valueSelectedByUser");
                        updatePriorityAsInt(valueSelectedByUser);
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
                            _save(context);
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
                            _delete(context);
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
    Navigator.pop(context, true);
  }

  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        product.setPriority(1);
        break;
      case 'Low':
        product.setPriority(2);
        break;
      default:
        product.setPriority(2);
    }
  }

  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _priorities[0];
        break;
      case 2:
        priority = _priorities[1];
        break;
      default:
        priority = _priorities[1];
    }

    return priority;
  }

  void updateTitle() {
    product.setTitle(titleController.text);
  }

  void updateDescription() {
    product.setDescription(descriptionController.text);
  }

  // Save data to database
  void _save(BuildContext context) async {

    moveToLastScreen();

    product.setDate(DateFormat.yMMMd().format(DateTime.now()));
    int result;
    var id = product.id;
    if (product.id != null) {
      var id = product.id;
      result = await helper.updateProduct(product);
      debugPrint('$id result save function update: $result');
    } else {
      result = await helper.insertProduct(product);
      debugPrint('$id result save function insert: $result');
    }

    if (result != 0) {
      _showAlertDialog('Status', 'Product Saved Successfully');
    } else {
      _showAlertDialog('Status', 'Problem Saving Product');
    }
  }

  void _showAlertDialog(String title, String message) {

    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );

    showDialog(context: context, builder: (_) => alertDialog);
  }

  void _delete(BuildContext context) async {

    moveToLastScreen();

    if (product.id == null) {
      _showAlertDialog('Status', 'No  Product was deleted');
      return;
    }

    int result = await helper.deleteProduct(product.id);

    if (result != 0) {
      _showAlertDialog('Status', 'Product Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Product');
    }
  }
}
