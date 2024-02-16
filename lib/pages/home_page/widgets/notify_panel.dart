import 'package:flutter/material.dart';

class NotifyPanel extends StatelessWidget {
  const NotifyPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 253, 253, 253),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(8.0),
      width: double.infinity,
      height: 48.0,
      child: const Text('Нажмите на любую точку экрана, чтобы построить угол',
        style: TextStyle(
          height: 1.0,
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
