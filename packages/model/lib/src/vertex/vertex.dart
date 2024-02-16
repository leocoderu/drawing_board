// Model of Vertex

class Vertex {
  Vertex({
    required this.X,
    required this.Y,
    this.Z,
  });

  final double X;
  final double Y;
  final double? Z;

  Vertex copyWith({double? X, double? Y, double? Z,}) =>
    Vertex(X: X ?? this.X, Y: Y ?? this.Y, Z: Z ?? this.Z,);

  @override
  String toString() => 'Vertex(X: $X, Y: $Y, Z: $Z)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Vertex && other.X == X && other.Y == Y && other.Z == Z;
  }

  @override
  int get hashCode => X.hashCode ^ Y.hashCode ^ Z.hashCode;
}