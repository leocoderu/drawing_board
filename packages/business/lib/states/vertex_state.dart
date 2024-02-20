import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VertexState extends StateNotifier<List<Offset>> {
  static final stateVertexProvider = StateNotifierProvider<VertexState, List<Offset>> ((ref) => VertexState());

  VertexState() : super(<Offset>[]);

  void addVertex(Offset value) => state = [...state, value];
  void changeVertex(int id, Offset value) {
    final List<Offset> newIds = state;
    newIds[id] = value;
    state = [];
    state = newIds;
  }

  void clearVertex() => state.clear();
}
