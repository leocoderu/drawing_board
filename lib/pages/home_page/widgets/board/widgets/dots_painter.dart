// Flutter modules
import 'package:flutter/material.dart';
// Dart modules
import 'dart:ui';

import 'package:drawing_board/pages/home_page/widgets/board/utilities/functions.dart';

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

  void _textDraw(Canvas canvas, int pos1, int pos2, double xScale, double yScale, double zOffset, double xOffset, double yOffset) { // pos1, pos2 координаты в localPosition!!!

    final double width = lineLength(vertex![pos2], vertex![pos1]);
    final String text = width.toStringAsFixed(2);
    final double angle = getAngle(vertex![pos2], vertex![pos1]) ;

    Offset pos = Offset(
        GPSCToLocal((vertex![pos2].dx - vertex![pos1].dx) / 2 + vertex![pos1].dx, xScale, zOffset, xOffset),
        GPSCToLocal((vertex![pos2].dy - vertex![pos1].dy) / 2 + vertex![pos1].dy, yScale, zOffset, yOffset),
    );

    final offset = getOffset(this.vertex!, pos1, pos2, 8.0);

    final _textPainter = TextPainter(textDirection: TextDirection.ltr);
    _textPainter.text = TextSpan(text: text, style: TextStyle(color: Colors.blue, fontSize: 15));
    _textPainter.textAlign = TextAlign.center;
    _textPainter.layout(minWidth: width);

    canvas.save();

    Offset pix = Offset(pos.dx - _textPainter.width /2 + offset.dx, pos.dy - _textPainter.height / 2 + offset.dy);
    final pivot = _textPainter.size.center(pix);
    canvas.translate(pivot.dx, pivot.dy);
    canvas.rotate(angle);
    canvas.translate(-pivot.dx + offset.dx, -pivot.dy + offset.dy);
    _textPainter.paint(canvas, pix);

    canvas.restore();
  }



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
          _textDraw(canvas, i, i + 1, xScale, yScale, zOffset, xOffset, yOffset);
        }

        //print('Gipotinuza: ${lineLength(Offset(0, 0), Offset(4, 4))}');

        // final paintPivot = Paint()
        //   ..strokeWidth = (dotSize == null) ? 2.0 : dotSize! * 2
        //   ..color = Colors.green
        //   ..strokeCap = StrokeCap.round;
        // canvas.drawPoints(PointMode.points, [Offset(100.0, 250.0)], paintPivot);
      }

      // Рисуем кружки на вершинах
      final outCircle = Paint()..color = !inverseVertex ? borderColor ?? Colors.black : fillColor ?? Colors.yellow;
      final insCircle = Paint()..color = !inverseVertex ? fillColor ?? Colors.yellow : borderColor ?? Colors.black;
      final curCircle = Paint()..color = Colors.red;

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