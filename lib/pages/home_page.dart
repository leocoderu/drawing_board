import 'package:flutter/material.dart';

import 'package:drawing_board/widgets/board.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Board(
          child: const Center(
              child: Text('Drawing Board',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
              ),
          ),
        ),
      ),
    );
  }
}
