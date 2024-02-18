// Model of Board
class Board {
  double? dx, dy, dz, angle, rotate;
  Board({
    this.dx,
    this.dy,
    this.dz,
    this.angle,
    this.rotate,
  });

  Board copyWith({double? dx, double? dy, double? dz, double? angle, double? rotate}) =>
      Board(dx: dx ?? this.dx, dy: dy ?? this.dy, dz: dz ?? this.dz,
          angle: angle ?? this.angle, rotate: rotate ?? this.rotate,);

  @override
  String toString() =>
      'Board has (dx/dy/dz): $dx/$dy/$dz, angle: $angle, rotate: $rotate';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Board && other.dx == dx && other.dy == dy
        && other.dz == dz && other.angle == angle && other.rotate == rotate;
  }

  @override
  int get hashCode =>
    dx.hashCode ^ dy.hashCode ^ dz.hashCode ^ angle.hashCode ^ rotate.hashCode;
}