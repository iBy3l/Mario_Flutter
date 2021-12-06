import 'dart:math';

import "package:flutter/material.dart";

class JumpingMario extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final direction;
  final size;
  // ignore: use_key_in_widget_constructors
  const JumpingMario({this.direction, this.size});

  @override
  Widget build(BuildContext context) {
    if (direction == "right") {
      return Container(
        width: size,
        height: size,
        child: Image.asset("lib/images/jumpingmario.png"),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
          width: size,
          height: size,
          child: Image.asset("lib/images/jumpingmario.png"),
        ),
      );
    }
  }
}
