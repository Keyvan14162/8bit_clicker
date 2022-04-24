import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        primarySwatch: Colors.teal,
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
  int _clickCount = 0;
  var x = 0.0;
  var y = 0.0;
  var bonusx = -100.0;
  var bonusy = -100.0;
  var multiply = 1;
  var cookieMarginL = 20.0;
  var cookieMarginR = 20.0;
  var cookieMarginT = 5.0;
  var cookieMarginB = 0.0;
  var bonus_time = 0;

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
      appBar: AppBar(
        title: Text("Click'n Win"),
      ),
      body: Container(
        color: Colors.yellow,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        //cookieClick();
                      },
                      onTapDown: (TapDownDetails details) =>
                          _onTapDown(details),
                      child: Container(
                        //widh height
                        padding: EdgeInsets.all(0),
                        margin: EdgeInsets.fromLTRB(cookieMarginL,
                            cookieMarginT, cookieMarginR, cookieMarginB),

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
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      width: 2000,
                      height: 2000,
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    width: 100,
                    height: 100,
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(4, 2, 4, 2),
                    child: Text(
                      "Click Count: ${_clickCount}",
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
            ),
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
    y -= 95;
    // or user the local position method to get the offset
    print(details.localPosition);
    //print("tap down " + x.toString() + ", " + y.toString());

    cookieMarginL += 5;
    cookieMarginR += 5;
    cookieMarginT += 5;

    setState(() {
      _clickCount += multiply;
      print("Cookie click : $_clickCount");
    });
    audioPlayer.play("audios/hit.mp3");
    await Future.delayed(Duration(milliseconds: 200));
    // hit img hiding
    x = -100;
    y = -100;

    cookieMarginL -= 5;
    cookieMarginR -= 5;
    cookieMarginT -= 5;

    setState(() {});
    // her clickte cagirsi 10 da 1 ihtimalle bonus ciksin
    _showRandomBonus();
  }

  void _onBonusTapDown(TapDownDetails details) async {
    setState(() {
      _clickCount++;
      multiply += 2;
    });
    // farklı bi ses calsin bonushit.mp3
    audioPlayer.play("audios/hit.mp3");
    // hit img hiding
    bonusx = -100;
    bonusy = -100;
    await Future.delayed(Duration(milliseconds: 5000));
    multiply -= 2;

    bonus_time = 20;

    setState(() {});
  }

  void _showRandomBonus() async {
    // Random().nextInt(10) == 1
    if (true) {
      bonusx = 21 + Random().nextInt(369).toDouble();
      bonusy = 10 + Random().nextInt(370).toDouble();
    }
    // ekranda 2sn kalsın
    await Future.delayed(Duration(milliseconds: 20000));
    bonusx = -100;
    bonusy = -100;
    setState(() {});
  }
}
