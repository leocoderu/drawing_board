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

GlobalKey _keyRender = GlobalKey();

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

    final delta = 8 / zBoard;

    return Container(
      key: _keyRender,
      width: double.infinity,
      height: double.infinity,
      color: this.backColor ?? Color.fromARGB(255, 227, 227, 227),
      child: GestureDetector(
        onScaleUpdate: (detail) {
          final pos = detail.localFocalPoint;
          final int lastV = vertex.length - 1;

          final Size center = Size(_keyRender.currentContext!.size!.width / 2, _keyRender.currentContext!.size!.height / 2);

          if (curVertex != null) {
            final Offset _offset = Offset(localToGPSC(pos.dx, center.width, zBoard, xBoard), localToGPSC(pos.dy, center.height, zBoard, yBoard));
            // Concurrent movement of the first and last vertices in a closed shape
            if (close && (curVertex == 0 || curVertex == lastV)) {
              vertexProvider.changeVertex(0, _offset);
              vertexProvider.changeVertex(lastV, _offset);
            } else {
              // Moving selected vertex in an open figure
              vertexProvider.changeVertex(curVertex, _offset);
              // Magnetization of extreme vertices in an open figure
              if (vertex.length > 3) {
                if ((curVertex == 0)
                    && (vertex[0].dx > (vertex[lastV].dx - delta)) && (vertex[0].dx < (vertex[lastV].dx + delta))
                    && (vertex[0].dy > (vertex[lastV].dy - delta)) && (vertex[0].dy < (vertex[lastV].dy + delta))){
                  vertexProvider.changeVertex(0, vertex[lastV]);
                }
                if ((curVertex == lastV)
                    && (vertex[lastV].dx > (vertex[0].dx - delta)) && (vertex[lastV].dx < (vertex[0].dx + delta))
                    && (vertex[lastV].dy > (vertex[0].dy - delta)) && (vertex[lastV].dy < (vertex[0].dy + delta))){
                  vertexProvider.changeVertex(lastV, vertex[0]);
                }
              }
            }
          }
          else {
            // Moving and Scale Drawing Board
            boardProvider.setValue(
              Board(
                dx: (ref.watch(BoardState.stateBoardProvider).dx ?? 0.0) + (detail.focalPointDelta.dx / zBoard),
                dy: (ref.watch(BoardState.stateBoardProvider).dy ?? 0.0) + (detail.focalPointDelta.dy / zBoard),
                dz: ref.watch(TempZState.stateTempZProvider) * detail.scale,
                angle: 0.0, rotate: 0.0,
              ),
            );
          }
        },

        onScaleEnd: (_) {
          tempZProvider.setTemp(zBoard);
          // Fixing the magnetized extreme vertices of a shape
          if ((vertex.length > 3) && (vertex[vertex.length - 1] == vertex[0])) closeStateProvider.closedTrue();
        },

        // Fixing vertexes and closing shape
        onTapUp: (detail) {
          final pos = detail.localPosition;
          final Size center = Size(_keyRender.currentContext!.size!.width / 2, _keyRender.currentContext!.size!.height / 2);
          final posX = localToGPSC(pos.dx, center.width, zBoard, xBoard);
          final posY = localToGPSC(pos.dy, center.height, zBoard, yBoard);

          if (!close)
            if ((vertex.length > 2)
              && (posX  > (vertex[0].dx - delta)) && (posX  < (vertex[0].dx + delta))
              && (posY > (vertex[0].dy - delta))  && (posY < (vertex[0].dy + delta))) {
                vertexProvider.addVertex(vertex[0]);
                closeStateProvider.closedTrue();
            } else {
              vertexProvider.addVertex(
                Offset(localToGPSC(pos.dx, center.width, zBoard, xBoard), localToGPSC(pos.dy, center.height, zBoard, yBoard)),
              );
            }
        },

        // Выделение вершины для последующего изменения
        onTapDown: (detail) {
          final pos = detail.localPosition;
          final Size center = Size(_keyRender.currentContext!.size!.width / 2, _keyRender.currentContext!.size!.height / 2);
          // По нажатию на вершину, определяем ее id от 0 до length-1
          bool vSearch = false;
          for(int i = 0; i < vertex.length; i++) {
            if ((localToGPSC(pos.dx, center.width, zBoard, xBoard)  > vertex[i].dx - delta)
             && (localToGPSC(pos.dx, center.width, zBoard, xBoard)  < vertex[i].dx + delta)
             && (localToGPSC(pos.dy, center.height, zBoard, yBoard) > vertex[i].dy - delta)
             && (localToGPSC(pos.dy, center.height, zBoard, yBoard) < vertex[i].dy + delta))
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
