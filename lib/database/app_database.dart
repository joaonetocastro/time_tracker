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
                'category_id INTEGER,'
                'date_time text,'
                'CONSTRAINT fk_time_focused'
                ' FOREIGN KEY(category_id)'
                ' REFERENCES categories(id))'
      );
    }, version: 1);
  });
}
