import 'package:flutter/material.dart';

class Board extends StatefulWidget {
  final Color? background;
  final Color? grid;
  final Widget child;

  const Board({super.key, this.background, this.grid, required this.child});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  Color? background;
  Color? grid;

  @override
  void initState() {
    super.initState();
    background = widget.background ?? Color.fromARGB(255, 227, 227, 227);
    grid = widget.grid ?? Color.fromARGB(255, 159, 205, 230);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 227, 227, 227),
      child: Center(
        child: widget.child,
      ),
    );
  }
}
