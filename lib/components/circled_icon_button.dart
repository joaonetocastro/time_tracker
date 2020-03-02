import 'package:flutter/material.dart';

class CircledIconButton extends StatelessWidget {
  final Icon icon;
  final Color color;
  final Function onClick;
  CircledIconButton(this.icon, {this.color = Colors.redAccent,@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: icon,
      backgroundColor: color,
      onPressed: () => onClick(),
    );
  }
}