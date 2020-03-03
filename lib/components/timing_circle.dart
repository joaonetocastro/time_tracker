import 'dart:math';

import 'package:flutter/material.dart';
import 'package:time_tracker/components/center_text.dart';
import 'package:time_tracker/components/circled_icon_button.dart';
import 'package:time_tracker/helpers/dialogs_helper.dart';
import 'package:time_tracker/models/categorie.dart';
import 'package:time_tracker/models/time_focused.dart';
import 'package:time_tracker/services/time_focused_data_service.dart';

class TimingCircle extends StatefulWidget with ChangeNotifier{
  int _totalTimeInSeconds;
  double _size = 250.0;
  bool get isRunning => _state.isRunning;
  _TimingCircleState _state = _TimingCircleState();

  TimingCircle({int timeInMinutes = 25}){
    this._totalTimeInSeconds = timeInMinutes*60;
  }

  @override
  _TimingCircleState createState() => _state;
  

  void startRunning(Categorie categorie){
    if(!isRunning){
      _state.startRunning(categorie);
    } 
    notifyListeners();
  }
  void stopRunning(){
    if(isRunning) {
      _state.stopRunning();
      notifyListeners();
    }
  }
}

class _TimingCircleState extends State<TimingCircle> {
  Categorie _categorie;
  int _timeElapsed = 0;
  bool _running = false;

  double get _percentageTimeLeft{
    return timeRemainingInSeconds/widget._totalTimeInSeconds*100;
  }

  bool get isRunning{
    return _running;
  }
  int get minutes{
    return timeRemainingInSeconds ~/ 60;
  }
  int get seconds{
    return timeRemainingInSeconds - 60*minutes;
  }
  int get timeRemainingInSeconds{
    return widget._totalTimeInSeconds - _timeElapsed;
  }
  int get timeElapsedInMinutes{
    return _timeElapsed ~/ 60;
  }
  
  void startRunning(Categorie categorie){
    _categorie = categorie;
    _running = true;
    _countOneSecond();
  }
  void stopRunning(){
    TimeFocusedDataService.add(
      TimeFocused(
        this._categorie.id, 
        timeElapsedInMinutes
      )
    );
    TimeFocusedDataService.getAll().then((timeFocusedList){
      debugPrint(timeFocusedList.toString());
    });
    setState((){
      _timeElapsed = 0;
      _running = false;
    });
  }
  
  void _countOneSecond(){
    setState(() {
        if(isRunning && _timeElapsed < widget._totalTimeInSeconds){
          Future.delayed(Duration(seconds: 1), (){
              _timeElapsed++;
              _countOneSecond();
          });
        }else{
         stopRunning();
        }
    });
  }

  String _getTimingFormatted(){
    return '${minutes >=10 ? minutes : '0$minutes'}:${seconds >=10 ? seconds : '0$seconds'}';
  }
  
  @override
  Widget build(BuildContext context) {
    CircledIconButton button;
    if(this.isRunning){
      button = CircledIconButton(Icon(Icons.stop), onClick: (){
        this.stopRunning();
      });
    }else{
      button = CircledIconButton(Icon(Icons.play_arrow), onClick: (){
        showChooseCategoriesDialog(context, startRunning);
      });
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Stack(
          children: <Widget>[
            new SizedBox(
              width: widget._size,
              height: widget._size,
              child: new CustomPaint(
                painter: new _ArcPainter(percentageTimeLeft: _percentageTimeLeft),
              ),
            ),
          Container(child: CenterText(_getTimingFormatted(), size:60), width: widget._size, height: widget._size),
          ],
        ),
        button
      ],
    );

  }
}

class _ArcPainter extends CustomPainter {
  double percentageTimeLeft;
  Color color;
  _ArcPainter({
    this.percentageTimeLeft = 100,
    this.color = Colors.orange
  });

  @override
  bool shouldRepaint(_ArcPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    if(percentageTimeLeft != 0){
      Path path = Path()..arcTo(rect, -pi/2, 1.9999*pi*percentageTimeLeft/100, true);
      canvas.drawPath(
          path,
          Paint()
            ..color = color
            ..strokeWidth = 5.0
            ..style = PaintingStyle.stroke);
    }
  }
}