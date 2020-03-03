import 'package:time_tracker/database/app_database.dart';
import 'package:time_tracker/models/time_focused.dart';

class TimeFocusedDataService{
  static Future<int> add(TimeFocused timeFocused){
    return createDatabase().then((db){
      return db.insert('time_focused', timeFocused.convertToMap());
    });
  }
  static Future<List<TimeFocused>> getAll(){
    return createDatabase().then((db){
      return db.query('time_focused').then((mapData){
        final List<TimeFocused> timeFocusedList = List();
        for(Map<String, dynamic> map in mapData){
          final TimeFocused timeFocused = TimeFocused.withID(
            map['categorie_id'],
            map['time_in_minutes'],
            map['date_time'],
            map['id'],
          );
          timeFocusedList.add(timeFocused);
        }
        return timeFocusedList;
      });
    });
  }
  static Future<List<TimeFocused>> getAllFromCategorie(int categorie_id){
    return createDatabase().then((db){
      return db.query('time_focused where categorie_id=${categorie_id}').then((listMapData){
        List<TimeFocused> timeFocusedList = List();
        for(var timeFocusedData in listMapData){
          final TimeFocused timeFocused = TimeFocused.withID(
            timeFocusedData['categorie_id'],
            timeFocusedData['time_in_minutes'],
            timeFocusedData['date_time'],
            timeFocusedData['id']
          );
          timeFocusedList.add(timeFocused);
        }
        return timeFocusedList;
      });
    });
  }
  static Future<int> timeSpentTodayInCategorie(int categorie_id) async{
    List<TimeFocused> timeFocusedList = await TimeFocusedDataService.getAllFromCategorie(categorie_id);
    int totalTimeInMinutes = 0;
    for(TimeFocused timeFocused in timeFocusedList){
      totalTimeInMinutes = totalTimeInMinutes + timeFocused.timeInMinutes;
    }
    return totalTimeInMinutes;
  }
}