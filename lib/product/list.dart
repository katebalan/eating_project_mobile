import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return ProductListState();
  }
}

class ProductListState extends State<ProductList> {

  int count = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text('Products'),
      ),

      body: getProductListView(),

      floatingActionButton: FloatingActionButton(

        onPressed: () {
          debugPrint("add button was tabbed");
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
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(Icons.keyboard_arrow_right),
            ),

            title: Text('Dummy title'),

            subtitle: Text('Dummy date'),
            
            trailing: Icon(Icons.delete, color: Colors.grey),

            onTap: () {
              debugPrint("onTap item");
            },
          ),
        );
      },
    );
  }
}
