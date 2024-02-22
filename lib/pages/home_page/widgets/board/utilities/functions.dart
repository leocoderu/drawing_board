// Ф-ии расчета координат
import 'dart:math';
import 'dart:ui';

double GPSCToLocal(double pos, double center, double z, double offset) =>
  (pos + offset) * z + center;

double localToGPSC(double pos, double center, double z, double offset) =>
  (pos - center) / z - offset;

double lineLength(Offset one, Offset two) =>
  sqrt(pow(two.dx - one.dx, 2) + pow(two.dy - one.dy, 2));

double getAngle(Offset one, Offset two) => atan2(two.dy - one.dy, two.dx - one.dx);

double getAngleWithCorrectTextOrientation(Offset one, Offset two) {
  double angle = getAngle(one, two);
  return (!((angle >= -pi/2) && (angle <= pi/2))) ? angle += pi : angle;
}

Offset getOffset(List<Offset> vertex, int id1, int id2, double pas) {
  int p = -1;
  // Определяем ориентацию многоугольника (по часовой стрелке "отрицательный" / против часовой стрелки "положительный")
  // Сумма всех углов отклонений
  if (vertex.length > 2) {
    List<Offset> nVertex = [...vertex, vertex[1]]; // добавляем следующий угол за нулевым, для расчета нулевого угла
    double cnt = 0;
    for(int i = 1; i < nVertex.length-1; i++) {
      double theta = atan2(nVertex[i-1].dx - nVertex[i].dx, nVertex[i-1].dy - nVertex[i].dy)
          - atan2(nVertex[i+1].dx - nVertex[i].dx, nVertex[i+1].dy - nVertex[i].dy);
      theta = (theta * 180.0 / pi);
      theta = (180 * theta / theta.abs() - theta);
      if (theta.isNaN) theta = 0.0;
      cnt += theta;
    }
    if (cnt > 0) p = 1;
  }
  double angle = getAngle(vertex[id1], vertex[id2]);
  return Offset(cos( angle + pi/2 ) * pas * p, sin( angle + pi/2 ) * pas * p);
}