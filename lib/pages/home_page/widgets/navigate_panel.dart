import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:business/business.dart';

class NavigatePanel extends ConsumerWidget {
  const NavigatePanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Color backgroundColor = Color.fromARGB(255, 246, 246, 246);
    final Color disableColor = Color.fromARGB(255, 198, 198, 200);
    //final Color enableColor = Color.fromARGB(255, 125, 125, 125);

    //final vertex = ref.watch(VertexState.stateVertexProvider);
    //final board = ref.watch(BoardState.stateBoardProvider);

    //final bool undoExist = false;
    //final bool redoExist = false;

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
                foregroundColor: MaterialStateProperty.all(disableColor), //undoExist ? enableColor : disableColor),
                elevation: MaterialStateProperty.all(0.0),
                padding: MaterialStateProperty.all(EdgeInsets.all(0.0)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.horizontal(left: Radius.circular(5.0)),
                  ),
                ),
              ),
              onPressed: null, //!undoExist ? null : () {},
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
                foregroundColor: MaterialStateProperty.all(disableColor), // redoExist ? enableColor : disableColor),
                elevation: MaterialStateProperty.all(0.0),
                padding: MaterialStateProperty.all(EdgeInsets.all(0.0)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.horizontal(right: Radius.circular(5.0)),
                  ),
                ),
              ),
              onPressed: null, //!redoExist ? null : () {},
              child: Icon(Icons.reply, textDirection: TextDirection.rtl,),
            ),
          ),
          // SizedBox(width: 10.0),
          // Expanded(
          //   child: Container(
          //     decoration: BoxDecoration(color: Color.fromARGB(255, 250, 250, 250), border: Border.all(color: Color.fromARGB(255, 153, 153, 153))),
          //     padding: EdgeInsets.all(5.0),
          //     margin: EdgeInsets.only(right: 10.0),
          //     height: 100.0,
          //     width: double.infinity,
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text('DX: ${board.dx!.toStringAsFixed(4)}  '
          //              'DY: ${board.dy!.toStringAsFixed(4)}  '
          //              'DZ: ${board.dz!.toStringAsFixed(4)}',
          //               style: TextStyle(fontFamily: "Courier",fontSize: 11.0, fontWeight: FontWeight.bold),
          //         ),
          //         SizedBox(height: 5.0,),
          //         Container(
          //           height: 65,
          //           width: double.infinity,
          //           child: ListView.builder(
          //             itemCount: vertex.length,
          //             itemBuilder: (context, index) {
          //               return Text('DX: ${vertex[index].dx.toStringAsFixed(6)}       '
          //                   'DY: ${vertex[index].dy.toStringAsFixed(6)}',
          //                 style: TextStyle(fontFamily: "Courier",fontSize: 12.0, fontWeight: FontWeight.bold),
          //               );
          //             },
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
