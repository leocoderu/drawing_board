// Ф-ии расчета координат
import 'dart:math';
import 'dart:ui';

double GPSCToLocal(double pos, double center, double z, double offset) =>
  (pos + offset) * z + center;

double localToGPSC(double pos, double center, double z, double offset) =>
  (pos - center) / z - offset;

double lineLength(Offset one, Offset two) =>
  sqrt(pow(two.dx - one.dx, 2) + pow(two.dy - one.dy, 2));

double getAngle(Offset one, Offset two) {
  double angle = atan2(two.dy - one.dy, two.dx - one.dx);
  return (!((angle >= -pi/2) && (angle <= pi/2))) ? angle += pi : angle;
}

Offset getOffset(List<Offset> vertex, int id1, int id2, double pas) {
  int p = -1;

  int iter = 0;
  if (vertex.length > 2) {
    double cnt = 0;
    for(int i = 1; i < vertex.length-1; i++) {
      double theta = atan2(vertex[i-1].dx - vertex[i].dx, vertex[i-1].dy - vertex[i].dy)
          - atan2(vertex[i+1].dx - vertex[i].dx, vertex[i+1].dy - vertex[i].dy);

      if (theta > pi) {theta -= 2 * pi;}
      if (theta < -pi) {theta += 2 * pi;}

      theta = theta * 180.0 / pi;
      cnt += theta; //(theta > 0) ? 1 : -1;

      iter++;
    }
    print('cnt: $cnt  iter: $iter');
    if (cnt > 0) p = 1;
  }


  Offset res = Offset(0, 0);
  double rX = vertex[id2].dx - vertex[id1].dx;
  double rY = vertex[id2].dy - vertex[id1].dy;

  if (rX <= 0 && rY <= 0) {res = Offset(pas * p, pas * -p);}
  if (rX >= 0 && rY <= 0) {res = Offset(pas * p, pas * p);}
  if (rX >= 0 && rY >= 0) {res = Offset(pas * -p, pas * p);}
  if (rX <= 0 && rY >= 0) {res = Offset(pas * -p, pas * -p);}

  return res;
}