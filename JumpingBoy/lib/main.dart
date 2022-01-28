import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maple_story/boy.dart';
import 'package:maple_story/snail.dart';
import 'package:maple_story/star.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      title: "MapleStory",
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //

  double snailPosY = 1;
  //
  var attackBoySpriteCount;
  int snailSprite = 1;
  int deadSnailSprite = 0;
  String snailDir = "left";
  var loadinScreenColor;
  var loadingScreenTextColor;
  var snailPosX = 0.8;
  var boyPosX = -0.8;
  var boyPosY = 1.0;
  String boyDir = "right";
  var starX = -0.8;
  var starY;
  int boySpriteCount = 1;
  var mana;
  int cashSprite = 0;
  double cashY = 0.0;
  var starSprite = 1;
  var timeCounter = 3;
  void timer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        timeCounter--;
      });
      if (timeCounter == 0) {
        setState(() {
          loadinScreenColor = Colors.transparent;
          loadingScreenTextColor = Colors.transparent;
          timeCounter = 3;
        });

        timer.cancel();
      }
    });
  }

  void attack() {
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        attackBoySpriteCount++;
      });
      if (attackBoySpriteCount == 5) {
        if (boyDir == "left" && boyPosX + 0.2 > snailPosX) {
          print("heat");
        } else {
          print("missed");
        }
        timer.cancel();
      }
    });
  }

  void star() {
    setState(() {
      starX = boyPosX + 0.1;
      starY = 0.9;
      mana -= 20;
    });
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      starX += 0.05;
      starSprite++;
      if (starX - snailPosX < 0.1) {
        timer.cancel();

        starX = 20;
      }
    });
  }

  void jump() {
    double initialHeight = boyPosY;
    double time = 0;
    double height = 0;
    Timer.periodic(Duration(milliseconds: 80), (timer) {
      setState(() {
        time += 0.05;
        height = -4.9 * time * time + 2.5 * time;
      });
      if (initialHeight - height > 1) {
        boyPosY = 1;
        timer.cancel();
      } else {
        boyPosY = initialHeight - height;
      }
    });
  }

  void getCash() {
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (boyPosX + cashY.abs() < 0.1) {
        timer.cancel();
      }
      setState(() {
        cashSprite++;
      });
    });
  }

  void collectItem() {
    double initilHeight = cashY;
    double time = 0;
    double height = 0.0;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (initilHeight - height > 0.9) {
        timer.cancel();
        cashY -= 2;
      } else {
        cashY = initilHeight - height;
      }
      setState(() {
        time += 0.05;
        height = -4.9 * time * time + 2.5 * time;
        cashSprite = 2;
      });
    });
  }

  fly() {
    double time = 0;
    double height = 0;
    double initailHeight = 0;
    snailPosY = initailHeight;
    Timer.periodic(Duration(milliseconds: 70), (timer) {
      setState(() {
        time += 0.05;
        height = -4.9 * time * time + 2.5 * time;
      });
      if (initailHeight - height > 1) {
        snailPosY = 1;
        timer.cancel();
      } else {
        snailPosY = initailHeight - height;
      }
    });
  }

  moveSnail() {
    Timer.periodic(Duration(milliseconds: 200), (timer) {
      setState(() {
        snailSprite += 1;
        if (snailSprite == 4) {
          snailSprite = 1;
        }
        if (snailPosX > 1) {
          snailDir = "left";
        }
        if (snailPosX < -1) {
          snailDir = "right";
        }
        if (snailDir == "left") {
          snailPosX -= 0.1;
        }
        if (snailDir == "right") {
          snailPosX += 0.1;
        }
      });
    });
  }

  moveBoy() {
    Timer.periodic(Duration(milliseconds: 200), (timer) {
      setState(() {
        boySpriteCount++;
        if (boySpriteCount == 4) {
          boySpriteCount = 1;
        }
        if (boyPosX < -1) {
          boyDir = "right";
        }
        if (boyPosX > 1) {
          boyDir = "left";
        }
        if (boyDir == "left") {
          boyPosX -= 0.1;
        }
        if (boyDir == "right") {
          boyPosX += 0.1;
        }
      });
    });
  }

  throwStar() {
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        starSprite++;
        starX += 0.1;
        if (snailPosX - starX < 0.1) {
          timer.cancel();
          starX = 5;
        }
        if (starSprite == 2) {
          starSprite = 1;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
              child: Container(
            color: Colors.blue,
            child: Stack(
              children: [
                Container(
                  alignment: Alignment(starX, 1.0),
                  child: MyStar(starSprite: 2),
                ),
                Container(
                  color: Colors.blue,
                  alignment: Alignment(boyPosX, boyPosY),
                  child:
                      MyBoy(boyDir = boyDir, boySpriteCount = boySpriteCount),
                ),
                Container(
                    alignment: Alignment(snailPosX, snailPosY),
                    child:
                        MySnail(snailDir: snailDir, snailSprite: snailSprite)),
              ],
            ),
          )),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: MaterialButton(
                      color: Colors.amber,
                      child: Text("Snail"),
                      onPressed: () {
                        moveSnail();
                      }),
                ),
                Expanded(
                  child: MaterialButton(
                      color: Colors.deepPurple,
                      child: Text("Boy"),
                      onPressed: () {
                        moveBoy();
                      }),
                ),
                Expanded(
                  child: MaterialButton(
                      color: Colors.amber,
                      child: Text("Jump"),
                      onPressed: () {
                        jump();
                      }),
                ),
                Expanded(
                    child: MaterialButton(
                        child: Text("attack"),
                        color: Colors.indigo,
                        onPressed: () {
                          throwStar();
                        }))
              ],
            ),
            height: 150,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
