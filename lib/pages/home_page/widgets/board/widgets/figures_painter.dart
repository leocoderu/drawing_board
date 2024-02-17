// // Flutter modules
// import 'package:flutter/material.dart';
//
// class FiguresPainter extends CustomPainter {
//   final double? xPos, yPos, zPos, angle, rotate, dotSize, radius;
//   final Color? borderColor, fillColor;
//   final List<Offset>? vertex;
//
//   FiguresPainter({
//     this.xPos, this.yPos, this.zPos, this.angle, this.rotate, this.dotSize,
//     this.radius, this.borderColor, this.fillColor, this.vertex,
//   });
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final double radCircle = radius ?? 10;
//     final double border = dotSize ?? 2.0;
//
//     final outCircle = Paint()..color = borderColor ?? Colors.black;
//     final insCircle = Paint()..color = fillColor ?? Colors.yellow;
//
//     if (vertex != null) {
//       vertex!.forEach((e) {
//         canvas.drawCircle(Offset(e.dx + (xPos ?? 0.0), e.dy + (yPos ?? 0.0)), radCircle, outCircle);
//         canvas.drawCircle(Offset(e.dx + (xPos ?? 0.0), e.dy + (yPos ?? 0.0)), (radCircle) - (border * 2), insCircle);
//       });
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
