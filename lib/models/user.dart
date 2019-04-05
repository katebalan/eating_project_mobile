class User {

  int _id;
  String _name;
  int _age;
  int _gender;
  int _weight;
  int _energyExchange;
  int _currentKkal;
  int _currentFats;
  int _currentProteins;
  int _currentCarbohydrates;
  int _normalKkal;
  int _normalFats;
  int _normalProteins;
  int _normalCarbohydrates;

  User(
      this._name,
      this._age,
      this._gender,
      this._weight,
      this._energyExchange
  ) {
    this._currentKkal = 0;
    this._currentFats = 0;
    this._currentProteins = 0;
    this._currentCarbohydrates = 0;
  }

  User.withId(
      this._id,
      this._name,
      this._age,
      this._gender,
      this._weight,
      this._energyExchange
  ) {
    this._currentKkal = 0;
    this._currentFats = 0;
    this._currentProteins = 0;
    this._currentCarbohydrates = 0;
  }

  int get id => _id;

  String get name => _name;

  int get age => _age;

  int get gender => _gender;

  int get weight => _weight;

  int get energyExchange => _energyExchange;

  set name(String name) {
    this.name = name;
  }

  set age(int age) {
    this.age = age;
  }

  set gender(int gender) {
    this.gender = gender;
  }


//  setTitle(String newTitle) {
//    if (newTitle.length <= 225) {
//      this._title = newTitle;
//    }
//  }
//
//  setDescription(String newDescription) {
//    if (newDescription.length <= 225) {
//      this._description = newDescription;
//    }
//  }
//
//  setPriority(int newPriority) {
//    if (newPriority >= 1 && newPriority <= 2) {
//      this._priority = newPriority;
//    }
//  }
//
//  setDate(String newDate) {
//    this._date = newDate;
//  }
//
//  Map<String, dynamic> toMap() {
//
//    var map = Map<String, dynamic>();
//
//    if (id != null) {
//      map['id'] = _id;
//    }
//
//    map['title'] = _title;
//    map['description'] = _description;
//    map['priority'] = _priority;
//    map['date'] = _date;
//
//    return map;
//  }
//
//  Product.fromMapObject(Map<String, dynamic> map) {
//    this._id = map['id'];
//    this._title = map['title'];
//    this._description = map['description'];
//    this._priority = map['priority'];
//    this._date = map['date'];
//  }
}
