class Product {

  int _id;
  String _title;
  String _description;
  String _date;
  int _priority;

  Product(this._title, this._date, this._priority, [this._description]);

  Product.withId(this._id, this._title, this._date, this._priority, [this._description]);

  int get id => _id;

  String get title => _title;

  String get description => _description;

  int get priority => _priority;

  String get date => _date;

  setTitle(String newTitle) {
    if (newTitle.length <= 225) {
      this._title = newTitle;
    }
  }

  setDescription(String newDescription) {
    if (newDescription.length <= 225) {
      this._description = newDescription;
    }
  }

  setPriority(int newPriority) {
    if (newPriority >= 1 && newPriority <= 2) {
      this._priority = newPriority;
    }
  }

  setDate(String newDate) {
    this._date = newDate;
  }

  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = _id;
    }

    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;

    return map;
  }

  Product.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._priority = map['priority'];
    this._date = map['date'];
  }
}
