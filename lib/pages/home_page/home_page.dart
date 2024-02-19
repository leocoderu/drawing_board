// Flutter modules
import 'package:flutter/material.dart';
// Packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Layers
import 'package:business/business.dart';
// Widgets
import 'package:drawing_board/pages/home_page/widgets/board/board_panel.dart';
import 'package:drawing_board/pages/home_page/widgets/navigate_panel.dart';
import 'package:drawing_board/pages/home_page/widgets/notify_panel.dart';
import 'package:drawing_board/pages/home_page/widgets/bottom_panel.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(UniqueState.stateCountProvider);
    final bool close = ref.watch(stateCloseFigureProvider);
    ref.watch(VertexState.stateVertexProvider);
    return Scaffold(
      body: SafeArea(
        child: BoardPanel(
          child: Column(
            children: [
              NavigatePanel(),
              Expanded(child: const Center()),
              if (!close) NotifyPanel(),
              BottomPanel(),
            ],
          ),
        ),
      ),
    );
  }
}
