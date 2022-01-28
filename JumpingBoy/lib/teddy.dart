import 'dart:math';

import 'package:flutter/material.dart';

class MyTeddy extends StatelessWidget {
  int teddySprite = 0;
  String teddyDir = '';

  MyTeddy({teddySprite, teddyDir});

  @override
  Widget build(BuildContext context) {
    if (teddyDir == "left") {
      return Container(
        alignment: Alignment.bottomCenter,
        child: Image.asset("Sprite/teddy" + teddySprite.toString() + "png"),
      );
    } else {
      return Transform(
        
          child: Container(
            alignment: Alignment.center,
            child: Image.asset("Sprite/teddy" + teddySprite.toString() + "png"),
          ),
          transform: Matrix4.rotationY(pi));
    }
  }
}
