import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

import 'buttonBuilder.dart';
import 'quizzbrain.dart';
import 'scorePage.dart';

QuizzBrain quizzBrain = QuizzBrain();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizzler',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Icon> scoreKeeper = [];

  void sayAnswer(bool userPickedAnswer) {
    setState(() {
      if (quizzBrain.getQuestionAnswer() == userPickedAnswer) {
        scoreKeeper.add(Icon(Icons.check, color: Colors.green));
        quizzBrain.nextQuestion(1);
      } else {
        scoreKeeper.add(Icon(Icons.close, color: Colors.red));
        quizzBrain.nextQuestion(0);
      }

      if (quizzBrain.shouldAlert()) {
        showScoreAlert();
      }
    });
  }

  void showScoreAlert() {
    scoreKeeper = [];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ScorePage(score: quizzBrain.points, quizzer: quizzBrain),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final trueButton = ButtonBuilder.buildButton(
      onTap: () {
        if (quizzBrain.shouldAlert()) {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.custom,
            widget: Container(
              height: 200,
              child: Column(
                children: [
                  const Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 50.0,
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'YOU DO IT!',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          sayAnswer(true);
        }
      },
      text: 'True',
      color: Colors.green,
    );

    final falseButton = ButtonBuilder.buildButton(
      onTap: () {
        if (quizzBrain.shouldAlert()) {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            text: 'YOU DO IT!',
            autoCloseDuration: const Duration(seconds: 2),
          );
        } else {
          sayAnswer(false);
        }
      },
      text: 'False',
      color: Colors.red,
    );

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: scoreKeeper),
              ),
            ),
            Expanded(
              flex: 5,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    quizzBrain.getQuestionText(),
                    style: TextStyle(color: Colors.white, fontSize: 30.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 13.0, horizontal: 16.0),
                child: trueButton,
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 13.0),
                child: falseButton,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
