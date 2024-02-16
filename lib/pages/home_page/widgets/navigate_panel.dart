import 'package:flutter/material.dart';

class NavigatePanel extends StatefulWidget {
  const NavigatePanel({super.key});

  @override
  State<NavigatePanel> createState() => _NavigatePanelState();
}

class _NavigatePanelState extends State<NavigatePanel> {
  final Color backgroundColor = Color.fromARGB(255, 246, 246, 246);
  final Color disableColor = Color.fromARGB(255, 198, 198, 200);
  final Color enableColor = Color.fromARGB(255, 125, 125, 125);

  bool undoExist = false;
  bool redoExist = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8.0, top: 14.0),
      child: Row(
        children: [
          SizedBox(
            height: 29,
            width: 36,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(backgroundColor),
                foregroundColor: MaterialStateProperty.all(undoExist ? enableColor : disableColor),
                elevation: MaterialStateProperty.all(0.0),
                padding: MaterialStateProperty.all(EdgeInsets.all(0.0)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.horizontal(left: Radius.circular(5.0)),
                  ),
                ),
              ),
              onPressed: () {},
              child: Icon(Icons.reply),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            color: backgroundColor,
            width: 3,
            height: 29,
            child: const VerticalDivider(color: Color.fromARGB(255, 200, 200, 200)),
          ),
          SizedBox(
            height: 29,
            width: 36,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(backgroundColor),
                foregroundColor: MaterialStateProperty.all(redoExist ? enableColor : disableColor),
                elevation: MaterialStateProperty.all(0.0),
                padding: MaterialStateProperty.all(EdgeInsets.all(0.0)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.horizontal(right: Radius.circular(5.0)),
                  ),
                ),
              ),
              onPressed: () {},
              child: Icon(Icons.reply, textDirection: TextDirection.rtl,),
            ),
          ),
        ],
      ),
    );
  }
}
