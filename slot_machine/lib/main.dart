// main.dart

import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roll_slot_machine/roll_slot.dart';
import 'package:roll_slot_machine/roll_slot_controller.dart';
import 'package:roll_slot_machine/scoreboard.dart'; // Add this import for scoreboard // Add this import for darkBlue1

class Assets {
  static const seventhIc = 'assets/images/777.svg';
  static const cherryIc = 'assets/images/cherry.svg';
  static const appleIc = 'assets/images/apple.svg';
  static const barIc = 'assets/images/bar.svg';
  static const coinIc = 'assets/images/coin.svg';
  static const crownIc = 'assets/images/crown.svg';
  static const lemonIc = 'assets/images/lemon.svg';
  static const watermelonIc = 'assets/images/watermelon.svg';
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roll Slot Machine',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: 'home',
      onGenerateRoute: onGenerateRoute,
    );
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == 'home') {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return MyHomePage(
            title: 'Slot Machine',
          );
        },
      );
    }
    return null;
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> values = List.generate(100, (index) => index);

  final _rollSlotController = RollSlotController();
  final _rollSlotController1 = RollSlotController();
  final _rollSlotController2 = RollSlotController();
  final _rollSlotController3 = RollSlotController();
  final _scoreBoardKey = GlobalKey<ScoreBoardState>(); // Use the correct class type here
  final random = Random();
  final List<String> prizesList = [
    Assets.seventhIc,
    Assets.cherryIc,
    Assets.appleIc,
    Assets.barIc,
    Assets.coinIc,
    Assets.crownIc,
    Assets.lemonIc,
    Assets.watermelonIc,
  ];

  @override
  void initState() {
    _rollSlotController.addListener(() {
      setState(() {});
    });
    _rollSlotController1.addListener(() {
      setState(() {});
    });
    _rollSlotController2.addListener(() {
      setState(() {});
    });
    _rollSlotController3.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  void _updateScore() {
    final centerImages = [
      prizesList[_rollSlotController.centerIndex],
      prizesList[_rollSlotController1.centerIndex],
      prizesList[_rollSlotController2.centerIndex],
      prizesList[_rollSlotController3.centerIndex],
    ];

    _scoreBoardKey.currentState?.updateScore(centerImages);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'SLOT MACHINE',
          style: TextStyle(color: Color.fromARGB(255, 255, 217, 0)),
        ),
        centerTitle: true,
      ),
            backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 5,
                    color: Color.fromARGB(255, 255, 217, 0),
                  ),
                ),
                height: 200,
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    RollSlotWidget(
                      prizesList: prizesList,
                      rollSlotController: _rollSlotController,
                    ),
                    RollSlotWidget(
                      prizesList: prizesList,
                      rollSlotController: _rollSlotController1,
                    ),
                    RollSlotWidget(
                      prizesList: prizesList,
                      rollSlotController: _rollSlotController2,
                    ),
                    RollSlotWidget(
                      prizesList: prizesList,
                      rollSlotController: _rollSlotController3,
                    ),
                  ],
                ),
              ),
            ),
          ),
          ScoreBoard(key: _scoreBoardKey),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () {
          final index = prizesList.length - 1;
          _rollSlotController.animateRandomly(
              topIndex: Random().nextInt(index),
              centerIndex: Random().nextInt(index),
              bottomIndex: Random().nextInt(index));
          _rollSlotController1.animateRandomly(
              topIndex: Random().nextInt(index),
              centerIndex: Random().nextInt(index),
              bottomIndex: Random().nextInt(index));
          _rollSlotController2.animateRandomly(
              topIndex: Random().nextInt(index),
              centerIndex: Random().nextInt(index),
              bottomIndex: Random().nextInt(index));
          _rollSlotController3.animateRandomly(
              topIndex: Random().nextInt(index),
              centerIndex: Random().nextInt(index),
              bottomIndex: Random().nextInt(index));

          // Stop each roll independently after a random duration between 3 to 6 seconds
          Timer(Duration(seconds: 3 + Random().nextInt(2)), () {
            _rollSlotController.stop();
            if (_rollSlotController1.state == RollSlotControllerState.stopped &&
                _rollSlotController2.state == RollSlotControllerState.stopped &&
                _rollSlotController3.state == RollSlotControllerState.stopped) {
              _updateScore();
            }
          });
          Timer(Duration(seconds: 3 + Random().nextInt(2)), () {
            _rollSlotController1.stop();
            if (_rollSlotController.state == RollSlotControllerState.stopped &&
                _rollSlotController2.state == RollSlotControllerState.stopped &&
                _rollSlotController3.state == RollSlotControllerState.stopped) {
              _updateScore();
            }
          });
          Timer(Duration(seconds: 3 + Random().nextInt(2)), () {
            _rollSlotController2.stop();
            if (_rollSlotController.state == RollSlotControllerState.stopped &&
                _rollSlotController1.state == RollSlotControllerState.stopped &&
                _rollSlotController3.state == RollSlotControllerState.stopped) {
              _updateScore();
            }
          });
          Timer(Duration(seconds: 3 + Random().nextInt(2)), () {
            _rollSlotController3.stop();
            if (_rollSlotController.state == RollSlotControllerState.stopped &&
                _rollSlotController1.state == RollSlotControllerState.stopped &&
                _rollSlotController2.state == RollSlotControllerState.stopped) {
              _updateScore();
            }
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 255, 217, 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        ),
        child: Text(
          'SPIN',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}

class RollSlotWidget extends StatelessWidget {
  final List<String> prizesList;
  final RollSlotController rollSlotController;

  const RollSlotWidget(
      {Key? key, required this.prizesList, required this.rollSlotController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: RollSlot(
                itemExtend: 115,
                rollSlotController: rollSlotController,
                children: prizesList.map(
                  (e) {
                    return BuildItem(
                      asset: e,
                    );
                  },
                ).toList()),
          ),
        ],
      ),
    );
  }
}

class BuildItem extends StatelessWidget {
  const BuildItem({
    Key? key,
    required this.asset,
  }) : super(key: key);

  final String asset;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color:  Color(0xff2f5d62).withOpacity(.2),
            offset: Offset(5, 5),
          ),
          BoxShadow(
            color:  Color(0xff2f5d62).withOpacity(.2),
            offset: Offset(-5, -5),
          ),
        ],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color:  Color(0xff2f5d62),
        ),
      ),
      alignment: Alignment.center,
      child: SvgPicture.asset(
        asset,
        key: Key(asset),
      ),
    );
  }
}

