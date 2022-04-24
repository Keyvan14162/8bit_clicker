import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:deneme/slidig_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marquee/marquee.dart';
import 'package:deneme/bottom_widget.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("MyApp build worked");
    return MaterialApp(
      title: "Clicker",
      theme: ThemeData(
          //primarySwatch: Colors.teal,
          ),
      home: _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  const _MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<_MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  int _score = 0;
  var x = 0.0;
  var y = 0.0;
  var bonusx = -100.0;
  var bonusy = -100.0;
  var multiply = 1;

  var cookiePadding = 0.0;

  var slidingText = "CLICK AND GO ";
  var slidingTextSize = 45.0;
  var slidingTextVelocity = 100.0;

  var linearProgressIndicatorValue = 0.0;
  var remainingValueToNextLLevel = 100;

  var cookieImg = Image.asset(
    "./assets/images/cookie2.png",
    fit: BoxFit.cover,
  );
  var hitImg = Image.asset(
    "./assets/images/hit.png",
    // fit: BoxFit.cover,
  );
  var bonusImg = Image.asset(
    "./assets/images/hit.png",
    // fit: BoxFit.cover,
  );

  final audioPlayer = AudioCache();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      appBar: AppBar(
        title: Text("Click'n Win"),
      ),*/
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // top bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: [
                    Container(
                      child: Text(
                        "Remaining to next stage",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 30,
                      child: LinearProgressIndicator(
                        value: linearProgressIndicatorValue,
                        color: Color.fromARGB(255, 13, 138, 196),
                        backgroundColor: Color.fromARGB(82, 0, 103, 163),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Container(
              child: Stack(
                alignment: Alignment.center,
                textDirection: TextDirection.rtl,
                fit: StackFit.loose,
                // overflow: Overflow.visible,
                clipBehavior: Clip.antiAlias,
                children: [
                  // Cookie
                  Container(
                    decoration: BoxDecoration(),
                    child: GestureDetector(
                      onTap: () {
                        //cookieClick();
                      },
                      onTapDown: (TapDownDetails details) =>
                          _onTapDown(details),
                      child: Container(
                        //widh height
                        padding: EdgeInsets.all(cookiePadding),
                        margin: EdgeInsets.fromLTRB(20, 5, 20, 0),

                        //color: Colors.orange,
                        child: cookieImg,
                      ),
                    ),
                  ),

                  // bonusimg
                  Positioned(
                    top: bonusy,
                    left: bonusx,
                    child: Container(
                      //width: 30,
                      //height: 30,
                      child: GestureDetector(
                        onTap: () {},
                        onTapDown: (TapDownDetails details) =>
                            _onBonusTapDown(details),
                        child: Container(
                          width: 30,
                          height: 30,
                          child: hitImg,
                        ),
                      ),
                    ),
                  ),

                  // hit img
                  Positioned(
                    top: y,
                    left: x,
                    child: Container(
                      child: hitImg,
                      width: 30,
                      height: 30,
                    ),
                  ),
                ],
              ),
            ),
            SlidingTextWidget(
                slidingText: slidingText,
                slidingTextSize: slidingTextSize,
                slidingTextVelocity: slidingTextVelocity),
            ScoreWidget(score: _score, multiply: multiply),
          ],
        ),
      ),
    );
  }

  //void cookieClick() async {}

  void _onTapDown(TapDownDetails details) async {
    x = details.globalPosition.dx;
    y = details.globalPosition.dy;
    // IDK WHY BUT THIS SHOWS THE TRUE
    // TOUCHED LOCATION
    x -= 15;
    y -= 55;
    // or user the local position method to get the offset
    print(details.localPosition);
    //print("tap down " + x.toString() + ", " + y.toString());

    cookiePadding += 5;
    //slidingTextSize += 3;

    setState(() {
      _score += multiply;
    });
    audioPlayer.play("audios/hit.mp3");
    await Future.delayed(Duration(milliseconds: 200), () {
      x = -100;
      y = -100;
    });
    // hit img hiding

    cookiePadding -= 5;
    // slidingTextSize -= 3;

    setState(() {});
    // her clickte cagirsi 10 da 1 ihtimalle bonus ciksin
    _showRandomBonus();

    //await Future.delayed(Duration(milliseconds: 10000));
    //_score = 0;

    changeProgressBar();
    setState(() {});
  }

  void _onBonusTapDown(TapDownDetails details) async {
    setState(() {
      _score++;
      multiply += 2;
      slidingTextVelocity += 100;
      _changeSlidingText();
    });
    // farklı bi ses calsin bonushit.mp3
    audioPlayer.play("audios/hit.mp3");
    // hit img hiding
    bonusx = -100;
    bonusy = -100;
    await Future.delayed(Duration(milliseconds: 5000), () {
      multiply -= 2;

      slidingTextVelocity -= 100;
      _changeSlidingText();
    });

    setState(() {});
  }

  void changeProgressBar() {
    linearProgressIndicatorValue +=
        (1 / remainingValueToNextLLevel) + multiply / 100;
    print(linearProgressIndicatorValue);
    if (linearProgressIndicatorValue >= 1.0) {
      linearProgressIndicatorValue = 0.0;
      remainingValueToNextLLevel = remainingValueToNextLLevel + 200;
    }
    setState(() {});
  }

  void _showRandomBonus() async {
    // Random().nextInt(10) == 1
    if (true) {
      bonusx = 21 + Random().nextInt(360).toDouble();
      bonusy = 10 + Random().nextInt(360).toDouble();
    }
    // ekranda 2sn kalsın

    await Future.delayed(Duration(milliseconds: 20000), () {
      bonusx = -100;
      bonusy = -100;
    });

    setState(() {});
  }

  void _changeSlidingText() async {
    if (multiply == 1) {
      slidingText = "WARM UP";
    }
    if (multiply == 3) {
      slidingText = "EASY GOIN";
    }
    if (multiply == 5) {
      slidingText = "GETTING HARD";
    }
    if (multiply == 7) {
      slidingText = "DIRTY FINGERS";
    }
    if (multiply == 9) {
      slidingText = "FASTER!!!!";
    }
    if (multiply == 11) {
      slidingText = "SPEED OF LIGHT";
    }
    if (multiply == 13) {
      slidingText = "HUMAN'T";
    }
    if (multiply == 15) {
      slidingText = "GODLIKE";
    }
  }
}
