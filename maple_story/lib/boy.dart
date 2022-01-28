import 'dart:math';

import 'package:flutter/material.dart';

class MyBoy extends StatelessWidget {
  String boyDir = '';
  int boySprite = 0;
  int intDirBoy = 0;

  MyBoy(this.boyDir, this.boySprite);
  @override
  Widget build(BuildContext context) {
    if (boyDir == "right") {
      intDirBoy = 1;
    }
    if (boyDir == "left") {
      intDirBoy = 0;
    }
    return Transform(
        alignment: Alignment.center,
        child: Container(
          color: Colors.blue,
          height: 100,
          width: 100,
          child: Image(
            image: AssetImage("Sprites/tile00" + boySprite.toString() + ".png"),
          ),
        ),
        transform: Matrix4.rotationY(pi * intDirBoy));
  }
}
