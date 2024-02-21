import 'package:flutter_riverpod/flutter_riverpod.dart';

class TempZState extends StateNotifier<double> {
  static final stateTempZProvider = StateNotifierProvider<TempZState, double>((_) => TempZState());

  TempZState() : super(1.0);

  void setTemp(double z) => (z > 0) ? state = z : 0.01;
}
