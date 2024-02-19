// Index by Vertexes of Figure, for Undo and Redo Operations

import 'package:flutter_riverpod/flutter_riverpod.dart';

final stateIndexProvider = StateNotifierProvider<IndexState, int>((_) => IndexState());

class IndexState extends StateNotifier<int> {
  IndexState() : super(0);

  void set(int id) => state = id;
}