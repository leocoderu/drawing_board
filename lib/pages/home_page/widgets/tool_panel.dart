import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:business/business.dart';

class ToolPanel extends ConsumerWidget {
  const ToolPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boardProvider = ref.watch(BoardState.stateBoardProvider.notifier);
    final tempZProvider = ref.watch(TempZState.stateTempZProvider.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 40.0,
          child: Column(
            children: [
              IconButton(
                tooltip: 'Zoom In',
                onPressed: () {
                  boardProvider.zoomIn();
                  tempZProvider.setTemp(ref.watch(BoardState.stateBoardProvider).dz ?? 1.0);
                },
                icon: Icon(Icons.zoom_in),
              ),
              IconButton(
                tooltip: 'Zoom Out',
                onPressed: () {
                  boardProvider.zoomOut();
                  tempZProvider.setTemp(ref.watch(BoardState.stateBoardProvider).dz ?? 1.0);
                },
                icon: Icon(Icons.zoom_out),
              ),
              IconButton(
                tooltip: 'Zoom 100%',
                onPressed: () {
                  boardProvider.zoomZero();
                  tempZProvider.setTemp(ref.watch(BoardState.stateBoardProvider).dz ?? 1.0);
                },
                icon: Icon(Icons.zoom_in_map),
              ),
              IconButton(
                tooltip: 'Null Position',
                onPressed: boardProvider.posZero,
                icon: Icon(Icons.near_me_outlined, textDirection: TextDirection.rtl),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
