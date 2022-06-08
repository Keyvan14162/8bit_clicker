import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class SlidingTextWidget extends StatefulWidget {
  SlidingTextWidget(
      {Key? key,
      required this.slidingText,
      required this.slidingTextSize,
      required this.slidingTextVelocity,
      required this.backgroundColor})
      : super(key: key);

  final String slidingText;
  final double slidingTextSize;
  final double slidingTextVelocity;
  final Color backgroundColor;

  @override
  State<SlidingTextWidget> createState() => _SlidingTextWidgetState();
}

class _SlidingTextWidgetState extends State<SlidingTextWidget> {
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

              //decoration: const BoxDecoration(
              color: widget.backgroundColor,
              /*
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [
                    0.0,
                    0.5,
                    1.0,
                  ],
                  colors: [
                    Color.fromARGB(255, 255, 255, 255),
                    Color.fromRGBO(255, 238, 0, 1),
                    Color.fromARGB(255, 251, 255, 0),
                    /*  Color.fromARGB(255, 206, 36, 87),
                    Color.fromARGB(255, 18, 91, 201),
                    Color.fromARGB(255, 156, 26, 207),*/
                  ],
                ),*/
              //   borderRadius: BorderRadius.all(
              //     Radius.circular(10),
              //  ),
              //  ),
              child: Container(
                child: Marquee(
                  text: widget.slidingText,
                  style: TextStyle(
                      color: Colors.white, fontSize: widget.slidingTextSize),
                  velocity: widget.slidingTextVelocity,
                  blankSpace: 100.0,
                ),
                decoration: const BoxDecoration(
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
          )
        ],
      ),
    );
  }
}
