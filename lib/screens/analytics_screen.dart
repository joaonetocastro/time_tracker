import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:time_tracker/components/center_text.dart';
import 'package:time_tracker/helpers/formatting_helper.dart';
import 'package:time_tracker/models/time_focused.dart';
import 'package:time_tracker/services/time_focused_data_service.dart';

class AnalyticsScreen extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    Future<Map<String, double>> timeFocusedList = TimeFocusedDataService.timeSpentTodayByCategory();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        CenterText("Analytics"),
        FutureBuilder(
          future: timeFocusedList,
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.hasData){
              return PieChart(
                dataMap: snapshot.data,
                animationDuration: Duration(milliseconds: 1000),
                showChartValuesInPercentage: false,
                formatChartValues: (value) => timeInMinutesToClockFormat(value ~/ 1),
              );
            }else{
              return Text("Loading Data");
            }
          }
        )
      ],
    );
  }
  
}