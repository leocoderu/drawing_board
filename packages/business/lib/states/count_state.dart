import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UniqueState extends StateNotifier<UniqueKey> {
  static final stateCountProvider = StateNotifierProvider<UniqueState, UniqueKey>((_) => UniqueState());

  UniqueState() : super(UniqueKey());

  void set(UniqueKey key) => state = key;
}