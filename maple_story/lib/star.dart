import 'package:flutter/material.dart';

class MyStar extends StatelessWidget {
  int starSprite = 2;
  MyStar({required this.starSprite});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: Image(
        image: AssetImage("Sprites/star" + starSprite.toString() + ".png"),
      ),
    );
  }
}
