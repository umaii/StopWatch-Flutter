import 'dart:async';
import 'package:flutter/material.dart';

class MiPomo extends StatefulWidget {
  @override
  MiPomoState createState() => MiPomoState();
}

int initialMinutes = 24;
int initialSeconds = 60;
String time = '25:00';
var duration = const Duration(seconds: 1);
var watch = Stopwatch();

class MiPomoState extends State<MiPomo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1F6097),
      appBar: buildAppBar(),
      body: _buildPomodoroTimer(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xff1F6097),
      centerTitle: true,
      elevation: 0,
      title: Text('MiPomo'),
    );
  }

  Widget _buildPomodoroTimer() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            stopwatch(),
            buttons(),
          ],
        ),
      ),
    );
  }

  Row buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: _restart,
          iconSize: 60,
          color: Colors.white,
        ),
        IconButton(
          icon: _isPlaying() ? Icon(Icons.pause) : Icon(Icons.play_arrow),
          onPressed: _startStopwatch,
          iconSize: 60,
          color: Colors.white,
        )
      ],
    );
  }

  void _startStopwatch() {
    if (_isPlaying()) {
      watch.stop();
    } else {
      watch.start();
      _startTimer();
    }
  }

  void _restart() {
    watch.stop();
    watch.reset();
    setState(() {
      time = '25:00';
    });
  }

  bool _isPlaying() {
    return watch.isRunning;
  }

  void _startTimer() {
    Timer(duration, _keepRunning);
  }

  void _keepRunning() {
    if (watch.isRunning) {
      _startTimer();
    }

    setState(() {
      int currentMinute = int.parse(watch.elapsed.inMinutes.toString());
      int currentSeconds = int.parse((watch.elapsed.inSeconds % 60).toString());
      int timerMinutes = initialMinutes - currentMinute;
      int timerSeconds = initialSeconds - currentSeconds;

      if (timerSeconds < 60 && timerSeconds >= 0) {
        time = timerMinutes.toString().padLeft(2, '0') +
            ':' +
            timerSeconds.toString().padLeft(2, '0');

        if (time == '00:00') {}
      }
      if (timerMinutes < 0) {
        time = '00:00';
        watch.stop();
      }
    });
  }
}

Widget stopwatch() {
  return Container(
    height: 250,
    width: 250,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(200),
      border: Border.all(
        color: Colors.red,
        width: 2,
      ),
    ),
    child: Container(
      height: 230,
      width: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
        border: Border.all(
          color: Colors.red,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          time,
          style: TextStyle(fontSize: 70, color: Colors.white),
        ),
      ),
    ),
  );
}
