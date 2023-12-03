import 'package:flutter/material.dart';

class Pixel extends StatelessWidget {
  var color;
  var child;
  Pixel({super.key, required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color,
          border: Border.all(color: Colors.black),
        ),
        child: Center(
            child: Text(
          child.toString(),
          style: TextStyle(fontSize: 10, color: Colors.white),
        )));
  }
}
