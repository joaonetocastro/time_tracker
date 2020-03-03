class Category{
  int _id;
  String _name;
  
  int get id => _id;
  String get name => _name;

  Category(this._name);
  Category.withID(this._name, this._id);

  @override
  String toString(){
    return "[id: ${this.id}, name: ${this.name}]";
  }

  Map<String, dynamic> convertToMap(){
    final Map<String, dynamic> categoryMap = Map();
    categoryMap['id'] = this.id;
    categoryMap['name'] = this.name;
    return categoryMap;
  }
}