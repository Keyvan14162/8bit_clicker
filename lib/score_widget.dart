import 'package:deneme/data/boss_names.dart';
import 'package:flutter/material.dart';

class ScoreWidget extends StatelessWidget {
  const ScoreWidget({
    Key? key,
    required int score,
    required this.currentStage,
    required this.stageCount,
  })  : _score = score,
        super(key: key);

  final int _score;
  final currentStage;
  final stageCount;

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
              border: const Border(
                bottom: BorderSide(
                  width: 8.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                right: BorderSide(
                  width: 8.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
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
              "Next Boss :\n${nextBossName()}",
              style: TextStyle(fontSize: 25),
            ),
            decoration: const BoxDecoration(
              color: Colors.amber,
              border: Border(
                bottom: BorderSide(
                  width: 8.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                right: BorderSide(
                  width: 8.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String nextBossName() {
    if (stageCount == currentStage) {
      return "END";
    } else {
      return BossNames.BOSS_NAMES[currentStage + 1];
    }
  }
}
