import 'package:flutter/material.dart';
import 'package:time_tracker/components/timing_circle.dart';
import 'package:time_tracker/screens/analytics_screen.dart';
import 'package:time_tracker/screens/promodoro_screen.dart';

class TimeTracker extends StatefulWidget{
  @override
  State<TimeTracker> createState() {
    return _TimeTrackerState();
  }

}
class _TimeTrackerState extends State<TimeTracker>{
  int _currentIndex = 0;
  PromodoroScreen _timer = PromodoroScreen();
  Widget _screenWidget;
  _TimeTrackerState(){
    this._screenWidget = _timer;
  }
  void openPromodoroScreen(){
    setState((){
      return this._screenWidget = _timer;
    });
  }
  void openAnalyticsScreen(){
    setState(() {
      return this._screenWidget = AnalyticsScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time tracker',
      home: Scaffold(
        body: Center(
          child: Container(
            child: Stack(children: <Widget>[
              Offstage(
                offstage: !(_screenWidget is PromodoroScreen),
                child: _timer
              ),
              Offstage(
                offstage: !(_screenWidget is AnalyticsScreen),
                child: AnalyticsScreen()
              ),
            ],)
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              title: Text('Timer'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.graphic_eq),
              title: Text('Analytics'),
            ),
          ],
          currentIndex: _currentIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onNavigationBarItemTapped,
        ),
      ),
    );
  }
  void _onNavigationBarItemTapped(int newIndex){
    if(newIndex == 0) openPromodoroScreen();
    else if(newIndex == 1) openAnalyticsScreen();
    setState((){
      _currentIndex = newIndex;
    });
  }
}