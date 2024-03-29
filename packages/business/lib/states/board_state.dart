// State of the drawing board
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

class BoardState extends StateNotifier<Board> {
  static final stateBoardProvider = StateNotifierProvider<BoardState, Board>((_) => BoardState());

  BoardState() : super(Board(dx: 0.0, dy: 0.0, dz: 1.0, angle: 0.0, rotate: 0.0));

  void setValue(Board board) => state = board;
  void zoomIn() => state = Board(dx: state.dx ?? 0.0, dy: state.dy ?? 0.0, dz: (state.dz ?? 1.0) + 0.1, angle: state.angle ?? 0.0, rotate: state.rotate ?? 0.0);
  void zoomOut() => state = Board(dx: state.dx ?? 0.0, dy: state.dy ?? 0.0, dz:(((state.dz ?? 1.0) - 0.1) > 0) ? (state.dz ?? 1.0) - 0.1 : (state.dz ?? 1.0), angle: state.angle ?? 0.0, rotate: state.rotate ?? 0.0);
  void zoomZero() => state = Board(dx: state.dx ?? 0.0, dy: state.dy ?? 0.0, dz: 1.0, angle: state.angle ?? 0.0, rotate: state.rotate ?? 0.0);
  void posZero() => state = Board(dx: 0.0, dy: 0.0, dz: (state.dz ?? 1.0), angle: 0.0, rotate: 0.0);
}
