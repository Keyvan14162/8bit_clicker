import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class SlidingTextWidget extends StatelessWidget {
  const SlidingTextWidget({
    Key? key,
    required this.slidingText,
    required this.slidingTextSize,
    required this.slidingTextVelocity,
  }) : super(key: key);

  final String slidingText;
  final double slidingTextSize;
  final double slidingTextVelocity;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              width: 2000,
              height: 2000,
              margin: const EdgeInsets.all(8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [
                    0.0,
                    0.5,
                    1.0,
                  ],
                  colors: [
                    Color.fromARGB(255, 206, 36, 87),
                    Color.fromARGB(255, 18, 91, 201),
                    Color.fromARGB(255, 156, 26, 207),
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Marquee(
                text: slidingText,
                style:
                    TextStyle(color: Colors.white, fontSize: slidingTextSize),
                velocity: slidingTextVelocity,
                blankSpace: 100.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
