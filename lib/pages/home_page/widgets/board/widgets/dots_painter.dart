// Flutter modules
import 'package:flutter/material.dart';
// Dart modules
import 'dart:ui';

class DotsPainter extends CustomPainter {
  final double? xPos, yPos, zPos, angle, rotate, step, dotSize, borderSize, radius;
  final Color? dotColor, borderColor, fillColor;
  final List<Offset>? vertex;
  final bool? center;

  DotsPainter({
    this.xPos, this.yPos, this.zPos, this.angle, this.rotate, this.step, this.dotSize,
    this.borderSize, this.radius, this.dotColor, this.borderColor, this.fillColor,
    this.vertex, this.center,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double xOffset = xPos ?? 0.00;
    final double yOffset = yPos ?? 0.00;
    final double zOffset = zPos ?? 1.00;
    final double stepSize = step ?? 30.00;
    final double radCircle = radius ?? 10;
    final double border = borderSize ?? 2.0;

    final nStep = stepSize * zOffset;

    // Рисуем точки стола
    List<Offset> points = [];
    for(double x = ((size.width / 2) + xOffset) % nStep; x < size.width; x += nStep)
      for(double y = ((size.height / 2) + yOffset) % nStep; y < size.height; y += nStep)
        points.add(Offset(x, y));

    final paint = Paint()
      ..strokeWidth = dotSize ?? 1.00
      ..color = dotColor ?? Colors.black
      ..strokeCap = StrokeCap.round;

    canvas.drawPoints(PointMode.points, points, paint);

    // Если указано начало координат, рисуем точку начала координат
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

    if (vertex != null) {
      if (vertex!.length > 2 && vertex![0] == vertex![vertex!.length-1]) {
        // Рисуем многоугольник
        final figure = Paint()
          ..strokeWidth = 6.0         // TODO: Вынести в настройки Виджета
          ..color = Colors.white;     // TODO: Вынести в настройки Виджета

        final pathFigure = Path()..moveTo(vertex![0].dx * zOffset + xOffset, vertex![0].dy * zOffset + yOffset);

        for (int i = 1; i < vertex!.length; i++)
          pathFigure.lineTo(vertex![i].dx * zOffset + xOffset, vertex![i].dy * zOffset + yOffset);

        pathFigure.close();
        canvas.drawPath(pathFigure, figure);
      }

      if (vertex!.length > 1) {
        final linePaint = Paint()
          ..strokeWidth = 6.0
          ..color = Colors.black;

        for (int i = 0; (i + 1) < vertex!.length; i++) {
          canvas.drawLine(
            Offset((vertex![i].dx * zOffset) + xOffset, (vertex![i].dy * zOffset) + yOffset),
            Offset((vertex![i + 1].dx * zOffset) + xOffset, (vertex![i + 1].dy * zOffset) + yOffset),
            linePaint,
          );
        }
      }

      final outCircle = Paint()..color = borderColor ?? Colors.black;
      final insCircle = Paint()..color = fillColor ?? Colors.yellow;

      // Рисуем кружочки на вершинах
      vertex!.forEach((e) {
        canvas.drawCircle(Offset(e.dx * zOffset + xOffset, e.dy * zOffset + yOffset), radCircle, outCircle);
        canvas.drawCircle(Offset(e.dx * zOffset + xOffset, e.dy * zOffset + yOffset), (radCircle) - (border * 2), insCircle);
      });
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}