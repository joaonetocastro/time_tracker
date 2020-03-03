class TimeFocused{
  int _id;
  int _timeInMinutes;
  int _categorie_id;
  String  _dateTime;

  DateTime get dateTime => DateTime.parse(_dateTime);
  set dateTime(DateTime dateTime) => this._dateTime = dateTime.toString();

  int get id => _id;
  int get timeInMinutes => _timeInMinutes;
  TimeFocused(this._categorie_id, this._timeInMinutes){
    dateTime = DateTime.now();
  }
  TimeFocused.withID(this._categorie_id, this._timeInMinutes, this._dateTime, this._id);

  @override
  String toString(){
    return "{id: ${this._id}, categorie_id: ${this._categorie_id}, day: ${this._dateTime.split(' ')[0]}, timeInMinutes: ${this.timeInMinutes}}";
  }

  Map<String,dynamic> convertToMap(){
    Map<String, dynamic> timeFocusedMap = new Map();
    timeFocusedMap['id'] = this.id;
    timeFocusedMap['time_in_minutes'] = this.timeInMinutes;
    timeFocusedMap['categorie_id'] = this._categorie_id;
    timeFocusedMap['date_time'] = this._dateTime;
    return timeFocusedMap;
  }
}