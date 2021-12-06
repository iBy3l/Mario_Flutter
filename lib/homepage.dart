import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_fonts/google_fonts.dart';
import 'package:mario_game/box.dart';
import 'package:mario_game/button.dart';
import 'package:mario_game/jumpingmario.dart';
import 'package:mario_game/mario.dart';
import 'dart:async';

import 'package:mario_game/shrooms.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double marioX = 0;
  static double marioY = 1;
  double marioSize = 50;
  double shroonX = 0.5;
  double shroonY = 1;
  double time = 0;
  double height = 0;
  double initialHeight = marioY;
  String direction = "right";
  bool midrum = false;
  bool midjump = false;
  var gamefont = GoogleFonts.pressStart2p(
      textStyle: const TextStyle(color: Colors.white, fontSize: 20));
  static double boxX = -0.3;
  static double boxY = 0.3;

  void checkIfateShrooms() {
    if ((marioX - shroonX).abs() < 0.05 && (marioY - shroonY).abs() < 0.05) {
      setState(() {
        //mover o gogumelo para fora da tela
        shroonX = 2;
        marioSize = 100;
      });
    }
  }

  void preJump() {
    time = 0;
    initialHeight = marioY;
  }

  void jump() {
    // Essa primeira instrução é para tirar o salto duplo
    if (midjump == false) {
      midjump = true;
      // * Gravidade
      preJump();
      Timer.periodic(const Duration(milliseconds: 50), (timer) {
        time += 0.05;
        //      ! Tempo que o mario vai ficar no ar após pular.
        height = -4.9 * time * time + 5 * time;

        if (initialHeight - height > 1) {
          midjump = false;
          setState(() {
            marioY = 1;
          });
          timer.cancel();
        } else {
          setState(() {
            marioY = initialHeight - height;
          });
        }
      });
    }
  }

  void moveRight() {
    direction = "right";
    checkIfateShrooms();

    Timer.periodic(Duration(milliseconds: 50), (timer) {
      checkIfateShrooms();
      if (MyButton().userIsHoldingButton() == true && marioX + 0.02 < 1) {
        setState(() {
          marioX += 0.03;
          midrum = !midrum;
        });
      } else {
        timer.cancel();
      }
    });
  }

  bool onBox(double x, double y) {
    if ((x - boxX).abs() < 0.05 && (y - boxY).abs() < 0.3) {
      midjump = false;
      marioX = boxY - 0.28;
      return false;
    } else {
      return true;
    }
  }

  void moveLeft() {
    direction = "left";
    checkIfateShrooms();

    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      checkIfateShrooms();
      if (const MyButton().userIsHoldingButton() == true && marioX + 0.02 < 1) {
        setState(() {
          marioX -= 0.03;
          midrum = !midrum;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  // ignore: unused_element
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                Container(
                  color: Colors.blue,
                  child: AnimatedContainer(
                    alignment: Alignment(marioX, marioY),
                    duration: const Duration(milliseconds: 0),
                    child: midjump
                        ? JumpingMario(
                            direction: direction,
                            size: marioSize,
                          )
                        : MyMario(
                            direction: direction,
                            midrum: midrum,
                            size: marioSize,
                          ),
                  ),
                ),
                Container(
                  alignment: Alignment(boxX, boxY),
                  child: MyBox(),
                ),
                Container(
                    alignment: Alignment(shroonX, shroonY), child: MyShroom()),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "MARIO",
                            style: gamefont,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("0000", style: gamefont),
                        ],
                      ),
                      Column(
                        children: [
                          Text("WORD", style: gamefont),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("1-1", style: gamefont),
                        ],
                      ),
                      Column(
                        children: [
                          Text("TIME", style: gamefont),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("99999", style: gamefont),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    function: moveLeft,
                  ),
                  MyButton(
                    child: const Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                    ),
                    function: jump,
                  ),
                  MyButton(
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                    function: moveRight,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
