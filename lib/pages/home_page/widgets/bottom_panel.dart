// Flutter modules
import 'package:business/business.dart';
import 'package:flutter/material.dart';
// Packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomPanel extends ConsumerWidget {
  const BottomPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vertex = ref.watch(VertexState.stateVertexProvider);
    final vertexProvider = ref.watch(VertexState.stateVertexProvider.notifier);
    final closeProvider = ref.watch(CloseState.stateCloseFigureProvider.notifier);
    final currentVertexProvider = ref.watch(CurrentVertexState.curVertexProvider.notifier);

    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 253, 253, 253),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 26.0),
      height: 66.0,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          alignment: Alignment.center,
          backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 227, 227, 227)),
          foregroundColor: MaterialStateProperty.all(
            vertex.length > 0
              ? Color.fromARGB(255, 125, 125, 125)
              : Color.fromARGB(255, 198, 198, 200),
          ),
          elevation: MaterialStateProperty.all(0.0),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        onPressed: () {
          vertexProvider.clearVertex();
          closeProvider.closedFalse();
          currentVertexProvider.set(null);
        },
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
