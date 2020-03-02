import 'package:time_tracker/database/app_database.dart';
import 'package:time_tracker/models/categorie.dart';

class CategorieDataService {
  static Future<int> add(Categorie categorie){
    return createDatabase().then((db){
      return db.insert('categories', categorie.convertToMap());
    });
  }

  static Future<List<Categorie>> getAll(){
    return createDatabase().then((db){
      return db.query('categories').then((mapData){
        final List<Categorie> categories = List();
        for(Map<String, dynamic> map in mapData){
          final Categorie categorie = Categorie.withID(
            map['name'],
            map['id'],
          );
          categories.add(categorie);
        }
        return categories;
      });
    });
  }
  static Future<Categorie> find(id){
    return createDatabase().then((db){
      return db.query('categories where id=${id}').then((listMapData){
        Map<String, dynamic> categorieData = listMapData[0];
        final Categorie categorie = Categorie.withID(
          categorieData['name'],
          categorieData['id'],
        );
        return categorie;
      });
    });
  }
  static Future<int> delete(id) async{
    return createDatabase().then((db) async{
      await db.execute('DELETE FROM categories WHERE id=${id}');
      return id;
    });
  }
}