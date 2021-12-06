import 'dart:math';

import 'package:flutter/material.dart';

class MyMario extends StatelessWidget {
  final direction;
  final midrum;
  final size;

  MyMario({this.direction, this.midrum, this.size});

  @override
  Widget build(BuildContext context) {
    if (direction == "right") {
      return Container(
        width: size,
        height: size,
        child: midrum
            ? Image.asset("lib/images/standingmario.png")
            : Image.asset("lib/images/runningmario.png"),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
          width: size,
          height: size,
          child: midrum
              ? Image.asset("lib/images/standingmario.png")
              : Image.asset("lib/images/runningmario.png"),
        ),
      );
    }
  }
}
