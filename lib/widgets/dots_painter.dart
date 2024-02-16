import 'package:flutter/material.dart';
import 'dart:ui';

class DotsPainter extends CustomPainter{
  final double? xPos;
  final double? yPos;
  final double? zPos;
  final double? angle;
  final double? step;
  final double? dotSize;
  final Color? color;
  final bool? center;

  DotsPainter({this.xPos, this.yPos, this.zPos, this.angle, this.step, this.dotSize, this.color, this.center});

  @override
  void paint(Canvas canvas, Size size) {
    final xOffset = xPos ?? 0.00;
    final yOffset = yPos ?? 0.00;
    final zOffset = zPos ?? 1.00;
    final stepSize = step ?? 30.00;

    final nStep = stepSize * zOffset;

    List<Offset> points = [];
    for(double x = ((size.width / 2) + xOffset) % nStep; x < size.width; x += nStep) {
      for(double y = ((size.height / 2) + yOffset) % nStep; y < size.height; y += nStep) {
        points.add(Offset(x, y));
      };
    };

    final paint = Paint()
      ..strokeWidth = dotSize ?? 1.00
      ..color = color ?? Colors.black
      ..strokeCap = StrokeCap.round;

    canvas.drawPoints(PointMode.points, points, paint);

    if (center == true) {
      final paintCenter = Paint()
        ..strokeWidth = (dotSize == null) ? 2.0 : dotSize! * 2
        ..color = Colors.red
        ..strokeCap = StrokeCap.round;
      canvas.drawPoints(
        PointMode.points,
        [Offset((size.width / 2) + xOffset, (size.height / 2) + yOffset)],
        paintCenter,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}