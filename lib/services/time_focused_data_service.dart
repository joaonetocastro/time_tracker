import 'package:time_tracker/database/app_database.dart';
import 'package:time_tracker/models/category.dart';
import 'package:time_tracker/models/time_focused.dart';
import 'package:time_tracker/services/category_data_service.dart';

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
            map['category_id'],
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
  static Future<List<TimeFocused>> getAllFromCategory(int category_id){
    return createDatabase().then((db){
      return db.query('time_focused where category_id=${category_id}').then((listMapData){
        List<TimeFocused> timeFocusedList = List();
        for(var timeFocusedData in listMapData){
          final TimeFocused timeFocused = TimeFocused.withID(
            timeFocusedData['category_id'],
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
  static Future<int> timeSpentTodayInCategory(int category_id) async{
    List<TimeFocused> timeFocusedList = await TimeFocusedDataService.getAllFromCategory(category_id);
    int totalTimeInMinutes = 0;
    for(TimeFocused timeFocused in timeFocusedList){
      totalTimeInMinutes = totalTimeInMinutes + timeFocused.timeInMinutes;
    }
    return totalTimeInMinutes;
  }
  static Future<Map<String,double>> timeSpentTodayByCategory() async{
    List<Category> categoryList = await CategoryDataService.getAll();

    Map<String, double> dataMap = new Map();
    for(Category category in categoryList){
      int timeSpent = await timeSpentTodayInCategory(category.id);
      dataMap.putIfAbsent(category.name, () => timeSpent.toDouble());
    }
    return dataMap;

  }
}