import 'package:flutter/material.dart';
import 'dart:math';

class ProgressPainter extends CustomPainter {
  Color defaultColor;
  Color percentageColor;
  double completedPercentage;
  double circleWidth;

  ProgressPainter(
      {this.defaultColor,
      this.percentageColor,
      this.circleWidth,
      this.completedPercentage});

  Paint getPaint(Color color) {
    return Paint()
      ..color = color
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.stroke
      ..strokeWidth = circleWidth;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint defaultPaint = getPaint(defaultColor);
    Paint progressPaint = getPaint(percentageColor);

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    // canvas.drawCircle(center, radius, defaultPaint);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(center.dx - 75, center.dy - 75, 150, 150),
        Radius.circular(20),
      ),
      defaultPaint,
    );

    double arcAngle = 2 * pi * (completedPercentage / 100);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
