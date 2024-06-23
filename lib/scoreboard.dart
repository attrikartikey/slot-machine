// scoreboard.dart

import 'package:flutter/material.dart';

class ScoreBoard extends StatefulWidget {
  const ScoreBoard({Key? key}) : super(key: key);

  @override
  ScoreBoardState createState() => ScoreBoardState();
}

class ScoreBoardState extends State<ScoreBoard> {
  int _score = 0;

  void updateScore(List<String> images) {
    final imageCounts = <String, int>{};
    for (var image in images) {
      if (imageCounts.containsKey(image)) {
        imageCounts[image] = imageCounts[image]! + 1;
      } else {
        imageCounts[image] = 1;
      }
    }

    int points = 0;
    if (imageCounts.containsValue(4)) {
      points = 100;
    } else if (imageCounts.containsValue(3)) {
      points = 20;
    } else if (imageCounts.containsValue(2)) {
      points = 10;
    }

    setState(() {
      _score += points;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      right: 20,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          'Score: $_score',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
