import 'package:flutter/material.dart';

import 'package:drawing_board/pages/home_page/widgets/board/board.dart';
import 'package:drawing_board/pages/home_page/widgets/navigate_panel.dart';
import 'package:drawing_board/pages/home_page/widgets/notify_panel.dart';
import 'package:drawing_board/pages/home_page/widgets/bottom_panel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool closedFigure = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Board(
          child: Column(
            children: [
              NavigatePanel(),
              Expanded(
                child: const Center(),
              ),
              if (!closedFigure) NotifyPanel(),
              BottomPanel(),
            ],
          ),
        ),
      ),
    );
  }
}
