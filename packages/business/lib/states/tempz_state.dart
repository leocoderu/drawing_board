import 'package:flutter_riverpod/flutter_riverpod.dart';

final stateTempZProvider = StateNotifierProvider<TempZState, double>((_) => TempZState());

class TempZState extends StateNotifier<double> {
  TempZState() : super(1.0);

  void setTemp(double temp) => state = temp;

}
