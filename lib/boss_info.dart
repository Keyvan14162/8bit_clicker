import 'package:flutter/material.dart';

class StageBar extends StatelessWidget {
  StageBar({
    Key? key,
    required this.bossName,
    required this.linearIndicatorValue,
  }) : super(key: key);

  final String bossName;
  final linearIndicatorValue;

  final colorizeColors = [
    Color.fromARGB(255, 255, 255, 255),
    Color.fromARGB(255, 0, 0, 0),
    // Colors.yellow,
    //  Colors.red,
  ];

  final colorizeTextStyle = TextStyle(
    fontSize: 50.0,
    fontFamily: 'Horizon',
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Text(
        "${bossName} HP:%${(100 - (1.0 - linearIndicatorValue) * 100).toStringAsFixed(2)}",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
