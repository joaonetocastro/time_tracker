import 'package:flutter/material.dart';

class CenterText extends StatelessWidget {
  final String text;
  final double size;
  CenterText(this.text,{this.size = 40.0});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          // fontWeight: FontWeight.bold,
          fontSize: size
        ),
      ),
    );
  }
}