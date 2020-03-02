import 'package:flutter/material.dart';
import 'package:time_tracker/screens/promodoro_screen.dart';
import 'package:time_tracker/services/categorie_data_service.dart';

void main(){
  runApp(
    MaterialApp(
      title: 'Time tracker',
      home: Scaffold(
        body: Center(
          child: Container(
            child: PromodoroScreen()
          ),
        ),
      ),
    ),
  );  
  CategorieDataService.getAll().then(
    (list) => debugPrint(list.toString())
  );
}
