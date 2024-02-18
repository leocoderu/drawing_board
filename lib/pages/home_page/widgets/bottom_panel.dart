// Flutter modules
import 'package:flutter/material.dart';
// Packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomPanel extends ConsumerWidget {
  const BottomPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Color backgroundColor = Color.fromARGB(255, 253, 253, 253);
    final Color backgroundButton = Color.fromARGB(255, 227, 227, 227);
    final Color disableColor = Color.fromARGB(255, 198, 198, 200);
    final Color enableColor = Color.fromARGB(255, 125, 125, 125);
    final bool undoExist = false;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 26.0),
      height: 66.0,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          alignment: Alignment.center,
          backgroundColor: MaterialStateProperty.all(backgroundButton),
          foregroundColor: MaterialStateProperty.all(undoExist ? enableColor : disableColor),
          elevation: MaterialStateProperty.all(0.0),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        onPressed: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cancel, size: 16),
            const Text('Отменить действие', style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
