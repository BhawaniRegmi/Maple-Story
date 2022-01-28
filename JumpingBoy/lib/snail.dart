import 'dart:math';

import 'package:flutter/material.dart';

class MySnail extends StatelessWidget {
  var snailDir;
  var snailSprite;
  var intdir;

  MySnail({required this.snailDir, required this.snailSprite});
  @override
  Widget build(BuildContext context) {
    if (snailDir == "left") {
      intdir = 0;
    }
    if (snailDir == "right") {
      intdir = 1;
    }
    return Transform(
      transform: Matrix4.rotationY(pi * intdir),
      child: Container(
          height: 100,
          width: 100,
          child: Image(
            image: AssetImage("Sprites/bird" + snailSprite.toString() + ".png"),
          )),
    );
  }
}
