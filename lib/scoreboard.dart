// scoreboard.dart
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ScoreBoard extends StatefulWidget {
  const ScoreBoard({Key? key}) : super(key: key);

  @override
  ScoreBoardState createState() => ScoreBoardState();
}

class ScoreBoardState extends State<ScoreBoard> {
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _loadScore();
  }

  // Load score from Hive
  void _loadScore() async {
    final box = await Hive.openBox('scoreBox');
    setState(() {
      _score = box.get('score', defaultValue: 0);
    });
  }

  // Save score to Hive
  void _saveScore() async {
    final box = await Hive.openBox('scoreBox');
    box.put('score', _score);
  }

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
      _saveScore(); // Save the score whenever it is updated
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      child: ClipPath(
        clipper: SemicircleClipper(),
        child: Container(
           width: 180,
          height: 80,
          decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100.0),
                        topRight: Radius.circular(100.0),
                      ),
                      border: Border(
                      top: BorderSide(width: 5.0, color: Color.fromARGB(255, 255, 235, 119)),
                      left: BorderSide(width: 5.0, color: Color.fromARGB(255, 255, 235, 119)),
                      right: BorderSide(width: 5.0, color: Color.fromARGB(255, 255, 235, 119)),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 255, 235, 119),
                          blurRadius: 1.0,
                          spreadRadius: 1.0,
                          blurStyle: BlurStyle.inner,
                        ),
                      ],
                     ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Score',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 235, 119),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$_score',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 235, 119),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SemicircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, size.height)
      ..arcToPoint(
        Offset(size.width, size.height),
        radius: Radius.circular(size.width),
        clockwise: false,
      )
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
