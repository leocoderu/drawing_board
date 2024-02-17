// Flutter modules
import 'package:flutter/material.dart';

// Widgets
import 'package:drawing_board/pages/home_page/widgets/board/widgets/dots_painter.dart';
//import 'package:drawing_board/pages/home_page/widgets/board/widgets/figures_painter.dart';

import 'package:model/model.dart';

class Board extends StatefulWidget {
  final Color? backColor;
  final Color? gridColor;
  final Color? borderColor;
  final Color? fillColor;
  final Widget? child;

  const Board({super.key, this.backColor, this.gridColor,
    this.borderColor, this.fillColor, this.child,
  });

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  double xPos = 0.00;
  double yPos = 0.00;
  double zPos = 1.00;
  double tPos = 1.00;
  Color? backColor;
  Color? gridColor;
  Color? borderColor;
  Color? fillColor;


  List<Offset>? vertex;
  //Figure? figure;     // TODO: Перенести в SM

  @override
  void initState() {
    super.initState();
    backColor = widget.backColor ?? Color.fromARGB(255, 227, 227, 227);
    gridColor = widget.gridColor ?? Color.fromARGB(255, 159, 205, 230);
    borderColor = widget.borderColor ?? Color.fromARGB(255, 253, 253, 253);
    fillColor = widget.borderColor ?? Color.fromARGB(255, 0, 152, 238);

    vertex = [];
    //figure!.path = [];
    //figure!.closure = false;
  }

  @override
  Widget build(BuildContext context) {
    //var vertex = figure!.path;
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: backColor,
      child: GestureDetector(
        onScaleUpdate: (scaleUpdateDetail) => setState(() {
          print('focalPoint: ${scaleUpdateDetail.focalPoint}');
          for(int i = 0; i < vertex!.length; i++) {
            if ((scaleUpdateDetail.focalPoint.dx > vertex![i].dx - 5)
                && (scaleUpdateDetail.focalPoint.dx < vertex![i].dx + 5)
                && (scaleUpdateDetail.focalPoint.dy > vertex![i].dy - 5)
                && (scaleUpdateDetail.focalPoint.dy < vertex![i].dy + 5))
              vertex![i] = scaleUpdateDetail.focalPoint;
            print(vertex![i]);
          };
        }),

          // setState(() {
          //   xPos += scaleUpdateDetail.focalPointDelta.dx;
          //   yPos += scaleUpdateDetail.focalPointDelta.dy;
          //   zPos = tPos * scaleUpdateDetail.scale;
          // }),

        //onScaleEnd: (scaleUpdateDetail) => setState(() => tPos = zPos),
        onTapUp: (tapUpDetails) => setState(() {
          final Offset tOffSet = tapUpDetails.localPosition;
          if (vertex!.length > 2 && tOffSet.dx > vertex![0].dx - 5 && tOffSet.dx < vertex![0].dx + 5
            && tOffSet.dy > vertex![0].dy - 5 && tOffSet.dy < vertex![0].dy + 5) {
            vertex!.add(vertex![0]);    // Добавляем последнюю точку как первую, дельта [-5 +5]
          } else {
            vertex!.add(Offset(tOffSet.dx - xPos, tOffSet.dy - yPos));
          }
        }),
        // onTapDown: (tapDownDetail) {
        //   for(int i = 0; i < vertex!.length; i++) {
        //     if ((tapDownDetail.localPosition.dx > vertex![i].dx - 5)
        //       && (tapDownDetail.localPosition.dx < vertex![i].dx + 5)
        //       && (tapDownDetail.localPosition.dy > vertex![i].dy - 5)
        //       && (tapDownDetail.localPosition.dy < vertex![i].dy + 5))
        //       setState(() => vertex![i] = tapDownDetail.localPosition);
        //   };
        // },
        child: CustomPaint(
          painter: DotsPainter(
              xPos: xPos, yPos: yPos, zPos: zPos,
              dotSize: 2.5, borderSize: 1.0, radius: 7.0,
              dotColor: gridColor, borderColor: borderColor, fillColor: fillColor,
              vertex: vertex, center: true,
          ),
          //foregroundPainter: FiguresPainter(xPos: xPos, yPos: yPos, zPos: zPos, dotSize: 2.0, radius: 10.0, vertex: vertex),
          child: widget.child,
        ),
      ),
    );
  }
}
