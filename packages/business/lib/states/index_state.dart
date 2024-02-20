// Index by Vertexes of Figure, for Undo and Redo Operations
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IndexState extends StateNotifier<int> {
  static final stateIndexProvider = StateNotifierProvider<IndexState, int>((_) => IndexState());

  IndexState() : super(0);

  void set(int id) => state = id;
}