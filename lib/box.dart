import 'package:flutter/material.dart';

class MyBox extends StatelessWidget {
  static bool box = false;
  bool onbox() {
    return box;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          alignment: Alignment.center,
          child: const Text(
            "?",
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white // insert your font size here
                ),
          )),
      width: 30,
      height: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.brown,
          border: Border.all(width: 1, color: Colors.black)),
    );
  }
}
