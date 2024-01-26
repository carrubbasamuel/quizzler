import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import 'quizzbrain.dart';

class ScorePage extends StatefulWidget {
  final int score;
  final QuizzBrain quizzer;

  ScorePage({Key? key, required this.score, required this.quizzer})
      : super(key: key);

  @override
  State<ScorePage> createState() => _ScorePage();
}

class _ScorePage extends State<ScorePage> {
  late ConfettiController _controllerCenterRight;
  late ConfettiController _controllerCenterLeft;

  @override
  void initState() {
    super.initState();
    _controllerCenterRight =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenterLeft =
        ConfettiController(duration: const Duration(seconds: 10));

    // Avvia l'animazione non appena la pagina viene caricata
    _controllerCenterRight.play();
    _controllerCenterLeft.play();
  }

  @override
  void dispose() {
    _controllerCenterRight.dispose();
    _controllerCenterLeft.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: ConfettiWidget(
                confettiController: _controllerCenterRight,
                blastDirection: pi,
                // radial value - RIGHT
                emissionFrequency: 0.6,
                minimumSize: const Size(10, 10),
                // set the minimum potential size for the confetti (width, height)
                maximumSize: const Size(50, 50),
                // set the maximum potential size for the confetti (width, height)
                numberOfParticles: 1,
                gravity: 0.1,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: ConfettiWidget(
                confettiController: _controllerCenterLeft,
                blastDirection: 0,
                // radial value - RIGHT
                emissionFrequency: 0.6,
                minimumSize: const Size(10, 10),
                // set the minimum potential size for the confetti (width, height)
                maximumSize: const Size(50, 50),
                // set the maximum potential size for the confetti (width, height)
                numberOfParticles: 1,
                gravity: 0.1,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your Score',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    '${widget.score}',
                    style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: MaterialButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  onPressed: () {
                    widget.quizzer.points = 0;
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.replay,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Play Again',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
