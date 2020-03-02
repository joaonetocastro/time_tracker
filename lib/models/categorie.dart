class Categorie{
  int _id;
  String _name;
  
  int get id => _id;
  String get name => _name;

  Categorie(this._name);
  Categorie.withID(this._name, this._id);

  @override
  String toString(){
    return "[id: ${this.id}, name: ${this.name}]";
  }

  Map<String, dynamic> convertToMap(){
    final Map<String, dynamic> categorieMap = Map();
    categorieMap['id'] = this.id;
    categorieMap['name'] = this.name;
    return categorieMap;
  }
}