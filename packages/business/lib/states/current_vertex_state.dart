import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentVertexState extends StateNotifier<int?> {
  static final curVertexProvider = StateNotifierProvider<CurrentVertexState, int?>((_) => CurrentVertexState());

  CurrentVertexState() : super(null);

  void set(int? id) => state = id;
}