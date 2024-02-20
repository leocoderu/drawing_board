// Flutter modules
import 'package:flutter/material.dart';
// Packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Widgets
import 'package:drawing_board/pages/home_page/widgets/board/widgets/dots_painter.dart';
import 'package:drawing_board/pages/home_page/widgets/board/utilities/functions.dart';
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

    final boardProvider = ref.watch(BoardState.stateBoardProvider.notifier);
    final tempZProvider = ref.watch(TempZState.stateTempZProvider.notifier);
    final vertexProvider = ref.watch(VertexState.stateVertexProvider.notifier);
    final curVertexProvider = ref.watch(CurrentVertexState.curVertexProvider.notifier);
    final closeStateProvider = ref.watch(CloseState.stateCloseFigureProvider.notifier);

    final curVertex = ref.watch(CurrentVertexState.curVertexProvider);

    final board = ref.watch(BoardState.stateBoardProvider);
    final vertex = ref.watch(VertexState.stateVertexProvider);
    final close = ref.watch(CloseState.stateCloseFigureProvider);

    final double xBoard = board.dx ?? 0.0;
    final double yBoard = board.dy ?? 0.0;
    final double zBoard = board.dz ?? 1.0;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: this.backColor ?? Color.fromARGB(255, 227, 227, 227),
      child: GestureDetector(

        onScaleUpdate: (detail) {

          final Offset fPoint = detail.localFocalPoint;

          if (curVertex != null) {
            if (close && (curVertex == 0 || curVertex == (vertex.length - 1))) {
              vertexProvider.changeVertex(0,
                Offset(
                  fPoint.dx - (ref.watch(BoardState.stateBoardProvider).dx ?? 0.0),
                  fPoint.dy - (ref.watch(BoardState.stateBoardProvider).dy ?? 0.0),
                ),
              );
              vertexProvider.changeVertex((vertex.length - 1),
                Offset(
                  fPoint.dx - (ref.watch(BoardState.stateBoardProvider).dx ?? 0.0),
                  fPoint.dy - (ref.watch(BoardState.stateBoardProvider).dy ?? 0.0),
                ),
              );
            } else {
              vertexProvider.changeVertex(curVertex,
                Offset(
                  fPoint.dx - (ref.watch(BoardState.stateBoardProvider).dx ?? 0.0),
                  fPoint.dy - (ref.watch(BoardState.stateBoardProvider).dy ?? 0.0),
                ),
              );
            }
          }
          else {
            boardProvider.setValue(
              Board(
                dx: (ref.watch(BoardState.stateBoardProvider).dx ?? 0.0) + detail.focalPointDelta.dx,
                dy: (ref.watch(BoardState.stateBoardProvider).dy ?? 0.0) + detail.focalPointDelta.dy,
                dz: ref.watch(TempZState.stateTempZProvider) * detail.scale,
                angle: 0.0,
                rotate: 0.0,
              ),
            );
          }
        },

        //onScaleEnd: (scaleUpdateDetail) => tempZProvider.setTemp(ref.watch(BoardState.stateBoardProvider).dz ?? 1.0),
        onScaleEnd: (scaleUpdateDetail) => tempZProvider.setTemp(zBoard),
        onTapUp: (detail) {
          final pos = detail.localPosition;
          final delta = 5 / zBoard;

          //print('Screen width :${MediaQuery.of(context).size.width}');
          //print('Screen height:${MediaQuery.of(context).size.height}');


          if (!close)
            if (vertex.length > 2
              && pos.dx - xBoard > vertex[0].dx - delta
              && pos.dx - xBoard < vertex[0].dx + delta
              && pos.dy - yBoard > vertex[0].dy - delta
              && pos.dy - yBoard < vertex[0].dy + delta) {
                vertexProvider.addVertex(vertex[0]);
                closeStateProvider.closedTrue();
            } else {
              vertexProvider.addVertex(Offset(pos.dx - xBoard, pos.dy - yBoard));
              // vertexProvider.addVertex(Offset(
              //     pos.dx,// - xBoard,
              //     getCord2(pos.dy, 412 / zBoard, zBoard, yBoard),// - yBoard,
              // //   (pos.dx - 207) * zBoard + xBoard,
              // //     //getCord(pos.dx, 207, zBoard, xBoard),// - xBoard,
              // //     getCord(pos.dy, 412, zBoard, yBoard),// - yBoard,
              // ));
              // print('pos: [ ${pos.dx} , ${pos.dy} ]');
              // print('${getCord(pos.dx, 207, zBoard, xBoard) - xBoard} , ${getCord(pos.dy, 412, zBoard, yBoard) - yBoard}');
              // print('xBoard / yBoard / zBoard : $xBoard / $yBoard / $zBoard');
              // print('con: ${pos.dx / zBoard}');
            }
        },

        // Выделение вершиды для послкдующего изменения
        onTapDown: (detail) {
          final pos = detail.localPosition;
          final delta = 5 / zBoard;
          // По нажатию на вершину, определяем ее id от 0 до length-1
          bool vSearch = false;
          for(int i = 0; i < vertex.length; i++) {
            if ((pos.dx > getCord(vertex[i].dx - delta, 207, zBoard, xBoard))
              && pos.dx < getCord(vertex[i].dx + delta, 207, zBoard, xBoard)
              && pos.dy > getCord(vertex[i].dy - delta, 412, zBoard, yBoard)
              && pos.dy < getCord(vertex[i].dy + delta, 412, zBoard, yBoard))
                { curVertexProvider.set(i); vSearch = true; break;}
          };
          if (!vSearch) curVertexProvider.set(null);
        },

        child: CustomPaint(
          painter: DotsPainter(
            xPos: ref.watch(BoardState.stateBoardProvider).dx,
            yPos: ref.watch(BoardState.stateBoardProvider).dy,
            zPos: ref.watch(BoardState.stateBoardProvider).dz,
            dotSize: 2.5, borderSize: 1.0, radius: 7.0,
            dotColor: this.gridColor ?? Color.fromARGB(255, 159, 205, 230),
            borderColor: this.borderColor ?? Color.fromARGB(255, 253, 253, 253),
            fillColor: this.borderColor ?? Color.fromARGB(255, 0, 152, 238),
            vertex: ref.watch(VertexState.stateVertexProvider),
            currentVertex: curVertex != null ? vertex[curVertex] : null,
            //centerScale: Offset(getWidth(), getHeight()), // Центр масштабирования
            center: true,
          ),
          child: child,
        ),
      ),
    );
  }
}
