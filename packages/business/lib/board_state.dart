// State of Board
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:model/model.dart';

final stateBoardProvider = StateNotifierProvider<BoardState, Board>((_) => BoardState());

class BoardState extends StateNotifier<Board> {
  BoardState() : super(Board(dx: 0.0, dy: 0.0, dz: 1.0, angle: 0.0, rotate: 0.0));

  void setValue(Board board) => state = board;
}
