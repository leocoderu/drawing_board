import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stateVertexProvider = StateNotifierProvider<VertexState, List<Offset>>((_) => VertexState());

class VertexState extends StateNotifier<List<Offset>> {
  VertexState() : super([]);

  void addVertex(Offset value) => state.add(value);
  void changeVertex(int id, Offset value) => state[id] = value;
  void clearVertex() => state.clear();
  //void undoVertex() => state.removeLast();
  //void
}
