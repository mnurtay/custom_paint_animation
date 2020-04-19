import 'dart:async';
import 'dart:ui';

import 'package:custom_paint_animation/progress_painter.dart';
import 'package:flutter/material.dart';

class CustomDemo extends StatefulWidget {
  @override
  _CustomDemoState createState() => _CustomDemoState();
}

class _CustomDemoState extends State<CustomDemo>
    with SingleTickerProviderStateMixin {
  Timer timer;
  double _percentage = 0.0;
  double _nextPercent = 0.0;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    initController();
  }

  void initController() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..addListener(() {
        setState(() {
          _percentage =
              lerpDouble(_percentage, _nextPercent, _animationController.value);
        });
      });
  }

  void startTimer() {
    Timer.periodic(Duration(milliseconds: 10), handleTicker);
  }

  void handleTicker(Timer t) {
    timer = t;
    if (_nextPercent < 100) {
      publishProgress();
    } else {
      t.cancel();
    }
  }

  void startProgress() {
    if (timer != null && timer.isActive) {
      timer.cancel();
    }
    setState(() {
      _percentage = 0;
      _nextPercent = 0;
      startTimer();
    });
  }

  void publishProgress() {
    setState(() {
      _percentage = _nextPercent;
      _nextPercent += 0.04;
      if (_percentage > 100) {
        _percentage = 0;
        _nextPercent = 0;
      }
      _animationController.forward(from: 0.0);
    });
  }

  Widget getProgressText() {
    return Text('${_percentage.toInt()}',
        style: TextStyle(
            fontSize: 40, fontWeight: FontWeight.w600, color: Colors.green));
  }

  Widget progressView() {
    return CustomPaint(
      child: Padding(
        padding: EdgeInsets.all(50.0),
        child: Center(child: getProgressText()),
      ),
      foregroundPainter: ProgressPainter(
        defaultColor: Colors.amber,
        percentageColor: Colors.green,
        completedPercentage: _percentage,
        circleWidth: 5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Paint Demo'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            progressView(),
            SizedBox(height: 30),
            OutlineButton(
              child: Text('START'),
              onPressed: () => startProgress(),
            ),
          ],
        ),
      ),
    );
  }
}
