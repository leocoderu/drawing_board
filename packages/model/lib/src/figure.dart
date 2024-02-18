// Model of Figure

import 'dart:ui';

class Figure {
  Figure({
    required this.path,
    required this.closure,
  });

  List<Offset> path;
  bool closure;

  Figure copyWith({List<Offset>? path, bool? closure}) =>
    Figure(path: path ?? this.path, closure: closure ?? this.closure,);

  @override
  String toString() =>
      'Figure(Has path with: ${path.length} vertexes, and property closed: ${closure})';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Figure && other.path == path && other.closure == closure;
  }

  @override
  int get hashCode => path.hashCode ^ closure.hashCode;
}