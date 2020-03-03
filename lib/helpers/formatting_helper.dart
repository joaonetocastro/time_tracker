String timeInMinutesToClockFormat(totalTimeInMinutes){
  int hours = totalTimeInMinutes ~/ 60;
  int minutes = totalTimeInMinutes % 60; 
  return '${hours >=10 ? hours : '0$hours'}:${minutes >=10 ? minutes : '0$minutes'}';
}