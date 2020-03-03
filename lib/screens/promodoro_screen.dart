import 'package:flutter/material.dart';
import 'package:time_tracker/components/timing_circle.dart';

class PromodoroScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        TimingCircle(timeInMinutes: 1,)
      ],
    );
  }
}