import 'package:flutter/material.dart';

class MyShroom extends StatelessWidget {
  const MyShroom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: 35,
      child: Image.asset("lib/images/mushroom.png"),
    );
  }
}
