import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    Key? key,
    required this.linearProgressIndicatorValue,
  }) : super(key: key);

  final double linearProgressIndicatorValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromARGB(255, 99, 0, 0),
            Color.fromARGB(255, 158, 0, 0)
          ],
        ),
        border: Border(
          bottom: BorderSide(width: 4.0, color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      height: 30,
      child: LinearProgressIndicator(
        value: linearProgressIndicatorValue,
        color: Color.fromARGB(255, 255, 0, 0),
        backgroundColor: Color.fromARGB(0, 255, 0, 0),
      ),
    );
  }
}
