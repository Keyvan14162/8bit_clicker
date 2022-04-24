import 'package:flutter/material.dart';

class ScoreWidget extends StatelessWidget {
  const ScoreWidget({
    Key? key,
    required int score,
    required this.multiply,
  })  : _score = score,
        super(key: key);

  final int _score;
  final int multiply;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            width: 100,
            height: 100,
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(4, 2, 4, 4),
            child: Text(
              "Score: ${_score}",
              style: TextStyle(fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade500.withOpacity(0.5),
                    spreadRadius: 0.6,
                    blurRadius: 06,
                    offset: (Offset(0, -3))),
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: 100,
            height: 100,
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(4, 2, 4, 2),
            child: Text(
              "${multiply}X",
              style: TextStyle(fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
