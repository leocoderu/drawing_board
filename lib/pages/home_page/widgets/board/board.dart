// Flutter modules
import 'package:flutter/material.dart';
// Packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Widgets
import 'package:drawing_board/pages/home_page/widgets/board/widgets/dots_painter.dart';
// Layers
import 'package:model/model.dart';
import 'package:business/business.dart';

class BoardPanel extends ConsumerWidget {
  final Color? backColor;
  final Color? gridColor;
  final Color? borderColor;
  final Color? fillColor;
  final Widget? child;

  const BoardPanel({super.key, this.backColor, this.gridColor,
    this.borderColor, this.fillColor, this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final BoardState boardProvider = ref.watch(stateBoardProvider.notifier);
    final TempZState tempZProvider = ref.watch(stateTempZProvider.notifier);
    final VertexState vertexProvider = ref.watch(VertexState.stateVertexProvider.notifier);
    final CloseState closeStateProvider = ref.watch(stateCloseFigureProvider.notifier);

    final board = ref.watch(stateBoardProvider);
    final vertex = ref.watch(VertexState.stateVertexProvider);
    final close = ref.watch(stateCloseFigureProvider);

    final double xBoard = board.dx ?? 0.0;
    final double yBoard = board.dy ?? 0.0;
    final double zBoard = board.dz ?? 0.0;

    int? idV;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: this.backColor ?? Color.fromARGB(255, 227, 227, 227),
      child: GestureDetector(
        onScaleUpdate: (detail) {
          final Offset fPoint = detail.focalPoint;
          if (idV != null) {
            //if (ref.watch(stateCloseFigureProvider) && (idV == 0 || idV == (vertex.length - 1))) {
            if (close && (idV == 0 || idV == (vertex.length - 1))) {
              vertexProvider.changeVertex(0, Offset(fPoint.dx - xBoard, fPoint.dy - yBoard));
              vertexProvider.changeVertex((vertex.length - 1), Offset(fPoint.dx - xBoard, fPoint.dy - yBoard));
            } else {
              vertexProvider.changeVertex(idV!, Offset(fPoint.dx - xBoard, fPoint.dy - yBoard));
            }
            // Так делать нельзя, но после этой строки идет обновление UI и точки на экране видны
            // boardProvider.setValue(Board(dx: ref.watch(stateBoardProvider).dx, dy: ref.watch(stateBoardProvider).dy, dz: ref.watch(stateBoardProvider).dz, angle: 0.0, rotate: 0.0));
          } else {
            boardProvider.setValue(
              Board(
                dx: (ref.watch(stateBoardProvider).dx ?? 0.0) + detail.focalPointDelta.dx,
                dy: (ref.watch(stateBoardProvider).dy ?? 0.0) + detail.focalPointDelta.dy,
                dz: ref.watch(stateTempZProvider) * detail.scale,
                angle: 0.0,
                rotate: 0.0,
              ),
            );
          }
        },

        onScaleEnd: (scaleUpdateDetail) => tempZProvider.setTemp(ref.watch(stateBoardProvider).dz ?? 1.0),
        onTapUp: (tapUpDetails) {
          idV = null;

          final Offset tOffSet = tapUpDetails.localPosition;

          if (!ref.watch(stateCloseFigureProvider))   // Добавляем последнюю точку как первую, дельта [-5 +5]
            if (vertex.length > 2 && tOffSet.dx - (ref.watch(stateBoardProvider).dx ?? 0.0) > vertex[0].dx - 5 && tOffSet.dx - (ref.watch(stateBoardProvider).dx ?? 0.0) < vertex[0].dx + 5
              && tOffSet.dy - (ref.watch(stateBoardProvider).dy ?? 0.0) > vertex[0].dy - 5 && tOffSet.dy - (ref.watch(stateBoardProvider).dy ?? 0.0) < vertex[0].dy + 5) {
              vertexProvider.addVertex(vertex[0]);
              closeStateProvider.closedTrue();
            } else {
              vertexProvider.addVertex(Offset(tOffSet.dx - (ref.watch(stateBoardProvider).dx ?? 0.0), tOffSet.dy - (ref.watch(stateBoardProvider).dy ?? 0.0)));
            }

          // TODO NB: после смещения фигуры, ее нельзя замкнуть, явна проблема с координатами, которые не учитывают смещение !!!
          // Так делать нельзя, но после этой строки идет обновление UI и точки на экране видны
          boardProvider.setValue(Board(dx: ref.watch(stateBoardProvider).dx, dy: ref.watch(stateBoardProvider).dy, dz: ref.watch(stateBoardProvider).dz, angle: 0.0, rotate: 0.0));
        },
        onTapDown: (detail) {
          // По нажатию на вершину, определяем ее id от 0
           for(int i = 0; i < vertex.length; i++) {
            if ((detail.localPosition.dx - xBoard > vertex[i].dx - 5)
             && (detail.localPosition.dx - xBoard < vertex[i].dx + 5)
             && (detail.localPosition.dy - yBoard > vertex[i].dy - 5)
             && (detail.localPosition.dy - yBoard < vertex[i].dy + 5))
             idV = i;
           };
         },
        child: CustomPaint(
          //key: UniqueKey(),
          painter: DotsPainter(
            xPos: ref.watch(stateBoardProvider).dx ?? 0.0 + 1.0,
            yPos: ref.watch(stateBoardProvider).dy,
            zPos: ref.watch(stateBoardProvider).dz,
            dotSize: 2.5, borderSize: 1.0, radius: 7.0,
            dotColor: this.gridColor ?? Color.fromARGB(255, 159, 205, 230),
            borderColor: this.borderColor ?? Color.fromARGB(255, 253, 253, 253),
            fillColor: this.borderColor ?? Color.fromARGB(255, 0, 152, 238),
            vertex: ref.watch(VertexState.stateVertexProvider),
            center: true,
          ),
          child: this.child,
        ),
      ),
    );
  }
}
