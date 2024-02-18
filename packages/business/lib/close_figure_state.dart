import 'package:flutter_riverpod/flutter_riverpod.dart';

final stateCloseFigureProvider = StateNotifierProvider<CloseState, bool>((_) => CloseState());

class CloseState extends StateNotifier<bool> {
  CloseState() : super(false);

  void closedTrue() => state = true;
  void closedFalse() => state = false;
}
