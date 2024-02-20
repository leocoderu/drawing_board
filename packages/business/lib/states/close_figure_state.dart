import 'package:flutter_riverpod/flutter_riverpod.dart';

class CloseState extends StateNotifier<bool> {
  static final stateCloseFigureProvider = StateNotifierProvider<CloseState, bool>((_) => CloseState());

  CloseState() : super(false);

  void closedTrue() => state = true;
  void closedFalse() => state = false;
}
