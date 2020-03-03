import 'package:time_tracker/database/app_database.dart';
import 'package:time_tracker/models/category.dart';

class CategoryDataService {
  static Future<int> add(Category category){
    return createDatabase().then((db){
      return db.insert('categories', category.convertToMap());
    });
  }

  static Future<List<Category>> getAll(){
    return createDatabase().then((db){
      return db.query('categories').then((mapData){
        final List<Category> categories = List();
        for(Map<String, dynamic> map in mapData){
          final Category category = Category.withID(
            map['name'],
            map['id'],
          );
          categories.add(category);
        }
        return categories;
      });
    });
  }
  static Future<Category> find(id){
    return createDatabase().then((db){
      return db.query('categories where id=${id}').then((listMapData){
        Map<String, dynamic> categoryData = listMapData[0];
        final Category category = Category.withID(
          categoryData['name'],
          categoryData['id'],
        );
        return category;
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