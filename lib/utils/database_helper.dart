import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:eating_project_app/models/product.dart';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database;

  String productTable = 'product';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colDate = 'date';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }

    return _databaseHelper;
  }

  Future<Database> get database async {

    if (_database == null) {
      _database = await initializeDatabase();
    }

    return _database;
  }

  Future<Database> initializeDatabase() async {

    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'eating_app.db';
    
    var appDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return appDatabase;
  }

  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $productTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,'
        ' $colTitle TEXT, $colDescription TEXT, $colPriority INTEGER, $colDate STRING) ');
  }

  // Fetch operation
  Future<List<Map<String, dynamic>>> getProductMapList() async {
    Database db = await this.database;

    // var result = await db.rawQuery('SELECT * FROM $productTable ORDER BY $colPriority ASC');
    var result = await db.query(productTable, orderBy: '$colPriority ASC');

    return result;
  }

  // Insert operation
  Future<int> insertProduct(Product product) async {
    Database db = await this.database;
    var result = await db.insert(productTable, product.toMap());
    return result;
  }

  // Update operation
  Future<int> updateProduct(Product product) async {
    Database db = await this.database;
    var result = await db.update(
        productTable,
        product.toMap(),
        where: '$colId = ?',
        whereArgs: [product.id]
    );
    return result;
  }

  // Delete operation
  Future<int> deleteProduct(int id) async {
    Database db = await this.database;
    int result =  await db.rawDelete('DELETE FROM $productTable WHERE $colId = $id');
    return result;
  }

  // Get number of raws from database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) FROM $productTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Product>> getProductList() async {
    var productMapList = await getProductMapList();
    int count = productMapList.length;

    List<Product> productList = List<Product>();
    for ( int i = 0; i < count; i++) {
      productList.add(Product.fromMapObject(productMapList[i]));
    }

    return productList;
  }
}
