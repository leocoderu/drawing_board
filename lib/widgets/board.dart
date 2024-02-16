// Flutter modules
import 'package:flutter/material.dart';

// Widgets
import 'package:drawing_board/widgets/dots_painter.dart';

class Board extends StatefulWidget {
  final Color? background;
  final Color? grid;
  final Widget child;

  const Board({super.key, this.background, this.grid, required this.child});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  double xPos = 0.00;
  double yPos = 0.00;
  double zPos = 1.00;
  double tPos = 1.00;
  Color? background;
  Color? gridColor;

  @override
  void initState() {
    super.initState();
    background = widget.background ?? Color.fromARGB(255, 227, 227, 227);
    gridColor = widget.grid ?? Color.fromARGB(255, 159, 205, 230);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: background,
      child: GestureDetector(
        onScaleUpdate: (scaleUpdateDetail) {
          setState(() {
            xPos += scaleUpdateDetail.focalPointDelta.dx;
            yPos += scaleUpdateDetail.focalPointDelta.dy;
            zPos = tPos * scaleUpdateDetail.scale;
          });
        },
        onScaleEnd: (scaleUpdateDetail) => setState(() => tPos = zPos),
        child: CustomPaint(
          painter: DotsPainter(xPos: xPos, yPos: yPos, zPos: zPos, dotSize: 2.5, color: gridColor, center: false),
          child: widget.child,
        ),
      ),
    );
  }
}
