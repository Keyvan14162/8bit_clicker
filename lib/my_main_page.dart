import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:deneme/score_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:deneme/data/boss_names.dart';
import 'package:deneme/progress_bar.dart';
import 'package:deneme/slidig_text_widget.dart';
import 'package:deneme/boss_info.dart';
import 'package:flutter/material.dart';
import 'package:deneme/score_widget.dart';
import 'package:palette_generator/palette_generator.dart';

int _score = 0;

class MyMainPage extends StatefulWidget {
  MyMainPage({
    Key? key,
  }) : super(key: key);

  final ScoreStorage cs = ScoreStorage();

  @override
  State<MyMainPage> createState() => MyMainPageState();
}

class MyMainPageState extends State<MyMainPage> {
  MyMainPageState() {}

  Future<File> _increamentScore() {
    setState(() {
      _score++;
    });
    return widget.cs.writeScore(_score);
  }

  var x = -100.0;
  var y = -100.0;
  var bonus1x = -100.0;
  var bonus1y = -100.0;
  var bonus2x = -100.0;
  var bonus2y = -100.0;
  var multiply = 1;
  var currentStage = 1;

  var cookiePadding = 0.0;

  var bossName = "DJ SKULL";

  var slidingText = " 8BIT CLICKER ";
  var slidingTextSize = 45.0;
  var slidingTextVelocity = 100.0;

  var linearProgressIndicatorValue = 1.0;
  var remainingValueToNextLLevel = 100;
  double progressDecrease = 0.1;

  var stageCount = BossNames.BOSS_NAMES.length - 1;

  var backgroundColor = Colors.white;

  late PaletteGenerator _generator;
  Color slidingTextBackgroundColor = Colors.red;

  var hitImg = Image.asset(
    "./assets/images/hit.png",
  );
  var bonus1Img = Image.asset(
    "./assets/images/bonus1.png",
  );
  var bonus2Img = Image.asset(
    "./assets/images/bonus2.png",
  );

  final audioPlayer = AudioCache();

  final random = Random();

  @override
  void initState() {
    super.initState();
    playBackgroundMusic();
    Timer.periodic(
      Duration(milliseconds: 500),
      (timer) {
        changeBackgroundColor();
      },
    );
    widget.cs.readScore().then((value) {
      setState(() {
        _score = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: backgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: [
                    // Progress Bar
                    ProgressBar(
                        linearProgressIndicatorValue:
                            linearProgressIndicatorValue),
                    // stage bar
                    StageBar(
                      bossName: bossName,
                      linearIndicatorValue: linearProgressIndicatorValue,
                    ),
                  ],
                )
              ],
            ),
            // Boss Part
            Container(
              decoration: BoxDecoration(),
              child: Stack(
                alignment: Alignment.center,
                textDirection: TextDirection.rtl,
                fit: StackFit.loose,
                clipBehavior: Clip.antiAlias,
                children: [
                  // Boss
                  Container(
                    child: GestureDetector(
                      onTapDown: (TapDownDetails details) =>
                          _onTapDown(details),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 1.8,
                        padding: EdgeInsets.all(cookiePadding),
                        margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
                        child: Image.asset(
                          "./assets/images/stage ($currentStage).png",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),

                  // bonus1img
                  Positioned(
                    top: bonus1y,
                    left: bonus1x,
                    child: Container(
                      child: GestureDetector(
                        onTapDown: (TapDownDetails details) =>
                            onBonusTapDown(details, 1),
                        child: Container(
                          width: 60,
                          height: 60,
                          child: bonus1Img,
                        ),
                      ),
                    ),
                  ),

                  // bonus2img
                  Positioned(
                    top: bonus2y,
                    left: bonus2x,
                    child: Container(
                      child: GestureDetector(
                        onTapDown: (TapDownDetails details) =>
                            onBonusTapDown(details, 2),
                        child: Container(
                          width: 60,
                          height: 60,
                          child: bonus2Img,
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

            SizedBox(
              height: 10,
            ),

            // Sliding Text
            SlidingTextWidget(
                slidingText: slidingText,
                slidingTextSize: slidingTextSize,
                slidingTextVelocity: slidingTextVelocity,
                backgroundColor: slidingTextBackgroundColor),

            // Bottom score and multiply
            ScoreWidget(
              score: _score,
              currentStage: currentStage,
              stageCount: stageCount,
            ),
          ],
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) async {
    await audioPlayer.play("audios/hit.mp3");

    x = details.globalPosition.dx;
    y = details.globalPosition.dy;
    // IDK WHY BUT THIS SHOWS THE TRUE
    // TOUCHED LOCATION
    x -= 15;
    y -= 75;

    cookiePadding += 5;

    changeBackgroundColor();

    // OLMAZSA GERI AC
    // _score++;
    _increamentScore();

    // hit img hiding
    await Future.delayed(
      Duration(milliseconds: 50),
      () {
        x = -100;
        y = -100;
      },
    );

    cookiePadding -= 5;

    changeProgressBar();

    setState(() {});
    // show bonus1
    if (Random().nextInt(10) == 1) {
      _showRandomBonus(1);
    }
    // show bonus2
    if (Random().nextInt(20) == 1) {
      _showRandomBonus(2);
    }
  }

  void onBonusTapDown(TapDownDetails details, int bonusNumber) {
    audioPlayer.play("audios/bonusHit.mp3");

    // hit img hiding
    bonus1x = -100;
    bonus1y = -100;
    bonus2x = -100;
    bonus2y = -100;
    _score++;
    if (bonusNumber == 1) linearProgressIndicatorValue -= 0.05;
    if (bonusNumber == 2) linearProgressIndicatorValue -= 0.1;
    setState(() {});
  }

  void changeProgressBar() async {
    linearProgressIndicatorValue -= progressDecrease;
    // linearProgressIndicatorValue = 0.0; // for the test
    if (linearProgressIndicatorValue <= 0.0) {
      await audioPlayer.play("audios/bossDeath.mp3");
      if (currentStage == stageCount) currentStage = 0;
      progressDecrease = 1.0 / (currentStage * 10);
      linearProgressIndicatorValue = 1.0;
      currentStage++;
      _changeSlidingText();
      findPngColor();
    }
    setState(() {});
  }

  // bonus1, bonus2
  void _showRandomBonus(int bonusNumber) {
    if (bonusNumber == 1) {
      bonus1x = 21 + Random().nextInt(360).toDouble();
      bonus1y = 10 + Random().nextInt(360).toDouble();

      Future.delayed(
        Duration(milliseconds: 20000),
        () {
          bonus1x = -100;
          bonus1y = -100;
        },
      );
    }
    if (bonusNumber == 2) {
      bonus2x = 21 + Random().nextInt(360).toDouble();
      bonus2y = 10 + Random().nextInt(360).toDouble();

      Future.delayed(Duration(milliseconds: 20000), () {
        bonus1x = -100;
        bonus1y = -100;
      });
    }

    setState(() {});
  }

  void _changeSlidingText() {
    bossName = BossNames.BOSS_NAMES[currentStage];
    slidingText = BossNames.BOSS_DIALOGUES[currentStage];
  }

  void playBackgroundMusic() {
    audioPlayer.loop("audios/background.mp3");
  }

  void changeBackgroundColor() {
    backgroundColor = Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
    setState(() {});
  }

  void findPngColor() async {
    _generator = await PaletteGenerator.fromImageProvider(
      AssetImage("assets/images/stage (${currentStage}).png"),
    );
    slidingTextBackgroundColor = _generator.dominantColor!.color;
  }
}
