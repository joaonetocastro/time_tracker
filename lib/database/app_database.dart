import 'package:flutter/material.dart';
import 'package:time_tracker/models/categorie.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase(){
  return getDatabasesPath().then((dbPath){
    final String path = join(dbPath, 'time_tracker.db');
    return openDatabase(path, onCreate: (db, version){
      db.execute('CREATE TABLE categories('
                  'id INTEGER PRIMARY KEY AUTOINCREMENT, '
                  'name text)'          
      );
      db.execute('CREATE TABLE time_focused('
                'id INTEGER PRIMARY KEY AUTOINCREMENT, '
                'time_in_minutes INTEGER,'
                'categorie_id INTEGER,'
                'date_time text,'
                'CONSTRAINT fk_time_focused'
                ' FOREIGN KEY(categorie_id)'
                ' REFERENCES categories(id))'
      );
    }, version: 1);
  });
}

// Future<int> saveCategorie(Categorie categorie){
//   return createDatabase().then((db){
//     return db.insert('categories', categorie.convertToMap());
//   });
// }

// Future<int> saveTimeFocused(TimeFocused timeFocused){
//   return createDatabase().then((db){
//     return db.insert('time_focused', timeFocused.convertToMap());
//   });
// }

// Future<List<Categorie>> findAllCategories(){
//   return createDatabase().then((db){
//     return db.query('categories').then((mapData){
//       final List<Categorie> categories = List();
//       for(Map<String, dynamic> map in mapData){
//         final Categorie categorie = Categorie(
//           map['id'],
//           map['name']
//         );
//         categories.add(categorie);
//       }
//       return categories;
//     });
//   });
// }

// Future<List<TimeFocused>> findAllTimeFocused(){
//   return createDatabase().then((db){
//     return db.query('time_focused').then((mapData){
//       final List<TimeFocused> wholeTimeFocused = List();
//       for(Map<String, dynamic> map in mapData){
//         final TimeFocused timeFocused = TimeFocused(
//           map['categorie_id'],
//           map['time_in_minutes']
//         );
//         wholeTimeFocused.add(timeFocused);
//         debugPrint(wholeTimeFocused.toString());
//       }
//       return wholeTimeFocused;
//     });
//   });
// }