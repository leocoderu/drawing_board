// Flutter modules
import 'package:drawing_board/pages/home_page/widgets/board/utilities/functions.dart';
import 'package:flutter/material.dart';
// Dart modules
import 'dart:ui';

class DotsPainter extends CustomPainter {
  final double? xPos, yPos, zPos, angle, rotate, step, dotSize, borderSize, radius;
  final Color? dotColor, borderColor, fillColor;
  final List<Offset>? vertex;
  final Offset? currentVertex;
  final Offset? centerScale;
  final bool? center;

  DotsPainter({
    this.xPos, this.yPos, this.zPos, this.angle, this.rotate, this.step, this.dotSize,
    this.borderSize, this.radius, this.dotColor, this.borderColor, this.fillColor,
    this.vertex, this.currentVertex, this.centerScale, this.center,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double xOffset = xPos ?? 0.00;
    final double yOffset = yPos ?? 0.00;
    final double zOffset = zPos ?? 1.00;
    final double stepSize = step ?? 30.00;
    final double radCircle = radius ?? 10;
    final double border = borderSize ?? 2.0;

    double xScale = centerScale == null ? (size.width / 2) : centerScale!.dx;
    double yScale = centerScale == null ? (size.height / 2) : centerScale!.dy;

    final nStep = stepSize * zOffset;
    bool inverseVertex = false;

    // Рисуем точки на поверхности стола
    final paint = Paint()
      ..strokeWidth = dotSize ?? 1.00
      ..color = dotColor ?? Colors.black
      ..strokeCap = StrokeCap.round;
    List<Offset> points = [];
    for(double x = GPSCToLocal(0.0, xScale, zOffset, xOffset) % nStep; x < size.width; x += nStep)
      for(double y = GPSCToLocal(0.0, yScale, zOffset, yOffset) % nStep; y < size.height; y += nStep)
        points.add(Offset(x, y));
    canvas.drawPoints(PointMode.points, points, paint);

    // Если указано начало координат, рисуем точку начала координат
    if (center == true) {
      final paintCenter = Paint()
        ..strokeWidth = (dotSize == null) ? 2.0 : dotSize! * 2
        ..color = Colors.red
        ..strokeCap = StrokeCap.round;
      canvas.drawPoints(PointMode.points, [Offset(GPSCToLocal(0.0, xScale, zOffset, xOffset), GPSCToLocal(0.0, yScale, zOffset, yOffset))], paintCenter);
    }

    if (vertex != null) {

      // Рисуем многоугольник
      if (vertex!.length > 2 && vertex![0] == vertex![vertex!.length-1]) {
        final figure = Paint()
          ..strokeWidth = 6.0         // TODO: Вынести в настройки Виджета
          ..color = Colors.white;     // TODO: Вынести в настройки Виджета

        final pathFigure = Path()..moveTo(GPSCToLocal(vertex![0].dx, xScale, zOffset, xOffset), GPSCToLocal(vertex![0].dy, yScale, zOffset, yOffset));

        for (int i = 1; i < vertex!.length; i++)
          pathFigure.lineTo(GPSCToLocal(vertex![i].dx, xScale, zOffset, xOffset), GPSCToLocal(vertex![i].dy, yScale, zOffset, yOffset));

        inverseVertex = true;
        pathFigure.close();
        canvas.drawPath(pathFigure, figure);
      }

      // Рисуем линии
      if (vertex!.length > 1) {
        final linePaint = Paint()
          ..strokeWidth = 6.0
          ..color = Colors.black;

        for (int i = 0; (i + 1) < vertex!.length; i++) {
          canvas.drawLine(
            Offset(GPSCToLocal(vertex![i].dx, xScale, zOffset, xOffset), GPSCToLocal(vertex![i].dy, yScale, zOffset, yOffset)),
            Offset(GPSCToLocal(vertex![i + 1].dx, xScale, zOffset, xOffset), GPSCToLocal(vertex![i + 1].dy, yScale, zOffset, yOffset)),
            linePaint,
          );
        }
      }

      final outCircle = Paint()..color = !inverseVertex ? borderColor ?? Colors.black : fillColor ?? Colors.yellow;
      final insCircle = Paint()..color = !inverseVertex ? fillColor ?? Colors.yellow : borderColor ?? Colors.black;
      final curCircle = Paint()..color = Colors.red;

      // Рисуем кружки на вершинах
      vertex!.forEach((e) {
        canvas.drawCircle(Offset(GPSCToLocal(e.dx, xScale, zOffset, xOffset), GPSCToLocal(e.dy, yScale, zOffset, yOffset)), radCircle, outCircle);
        (e == this.currentVertex)
            ? canvas.drawCircle(Offset(GPSCToLocal(e.dx, xScale, zOffset, xOffset), GPSCToLocal(e.dy, yScale, zOffset, yOffset)), (radCircle) - (border * 2), curCircle)
            : canvas.drawCircle(Offset(GPSCToLocal(e.dx, xScale, zOffset, xOffset), GPSCToLocal(e.dy, yScale, zOffset, yOffset)), (radCircle) - (border * 2), insCircle);
      });
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}