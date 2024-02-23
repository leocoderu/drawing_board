import 'dart:math';
import 'dart:ui';

// Transfer from GPSC to the Local coordinate system
double GPSCToLocal(double pos, double center, double z, double offset) =>
  (pos + offset) * z + center;

// Transfer from Local coordinate system to the GPSC
double localToGPSC(double pos, double center, double z, double offset) =>
  (pos - center) / z - offset;

// Determining the length of a line using two coordinates
double lineLength(Offset one, Offset two) =>
  sqrt(pow(two.dx - one.dx, 2) + pow(two.dy - one.dy, 2));

// Determining the angle between two vectors
double getAngle(Offset one, Offset two) => atan2(two.dy - one.dy, two.dx - one.dx);

// Determining the angle of inclination with text orientation correction
double getAngleWithCorrectTextOrientation(Offset one, Offset two) {
  double angle = getAngle(one, two);
  return (!((angle >= -pi/2) && (angle <= pi/2))) ? angle += pi : angle;
}

int getDirectionOfShape(List<Offset> vertex) {
  // Determining the orientation of the polygon (clockwise "negative" / counterclockwise "positive")
  // We determine the result by the sum of all angular deviations of the shape
  // Returns the result as "-1" for the clockwise direction and "1" counterclockwise.
  double cnt = 0;
  if (vertex.length > 2) {
    // Add the next angle after the zero one to calculate the zero angle
    List<Offset> nVertex = [...vertex, vertex[1]];
    for(int i = 1; i < nVertex.length-1; i++) {
      double theta = atan2(nVertex[i-1].dx - nVertex[i].dx, nVertex[i-1].dy - nVertex[i].dy)
          - atan2(nVertex[i+1].dx - nVertex[i].dx, nVertex[i+1].dy - nVertex[i].dy);
      theta = (theta * 180.0 / pi); // Conversion from radians to degrees
      theta = (180 * theta / theta.abs() - theta);
      if (theta.isNaN) theta = 0.0;
      cnt += theta;
    }
  }
  return (cnt > 0) ? 1 : -1;
}

// Offset of the text relative to the line
Offset getOffset(List<Offset> vertex, int id1, int id2, double pas) {
  int p = getDirectionOfShape(vertex);
  double angle = getAngle(vertex[id1], vertex[id2]);
  return Offset(cos( angle + pi/2 ) * pas * p, sin( angle + pi/2 ) * pas * p);
}

// Checking the intersection of two segments
bool hasIntersect(Offset p1, Offset p2, Offset p3, Offset p4){
  // Put the dots in ascending order
  if (p2.dx < p1.dx) { Offset tmp = p1; p1 = p2; p2 = tmp; }
  if (p4.dx < p3.dx) { Offset tmp = p3; p3 = p4; p4 = tmp; }

  // Checking the existence of a potential interval for the intersection point of the segments
  if (p2.dx < p3.dx) return false;

  // If both segments are vertical
  if((p1.dx - p2.dx == 0) && (p3.dx - p4.dx == 0)) {
    if(p1.dx == p3.dx) {
      if (!((max(p1.dy, p2.dy) < min(p3.dy, p4.dy)) || (min(p1.dy, p2.dy) > max(p3.dy, p4.dy)))) return true;
    }
    return false;
  }

  // If the fist segment is vertical, get Xa, Ya - the intersection points of two straight lines
  if (p1.dx - p2.dx == 0) {
    double Xa = p1.dx;
    double A2 = (p3.dy - p4.dy) / (p3.dx - p4.dx);
    double b2 = p3.dy - A2 * p3.dx;
    double Ya = A2 * Xa + b2;
    return (p3.dx <= Xa && p4.dx >= Xa && min(p1.dy, p2.dy) <= Ya && max(p1.dy, p2.dy) >= Ya);
  }

  // If the second segment is vertical, get Xa, Ya - the intersection points of two straight lines
  if (p3.dx - p4.dx == 0) {
    double Xa = p3.dx;
    double A1 = (p1.dy - p2.dy) / (p1.dx - p2.dx);
    double b1 = p1.dy - A1 * p1.dx;
    double Ya = A1 * Xa + b1;
    return (p1.dx <= Xa && p2.dx >= Xa && min(p3.dy, p4.dy) <= Ya && max(p3.dy, p4.dy) >= Ya);
  }

  // Both segments are non-vertical
  double A1 = (p1.dy - p2.dy) / (p1.dx - p2.dx);
  double A2 = (p3.dy - p4.dy) / (p3.dx - p4.dx);
  double b1 = p1.dy - A1 * p1.dx;
  double b2 = p3.dy - A2 * p3.dx;
  if (A1 == A2)  return false; // Parallel segments

  double Xa = (b2 - b1) / (A1 - A2); //Xa - The abscissa of the point of intersection of two straight lines
  return !((Xa < max(p1.dx, p3.dx)) || (Xa > min( p2.dx, p4.dx)));
}

// Checking the intersection of segments in a shape
bool hasIntersection(List<Offset> vertex, Offset offset) {
  bool result = false;

  if(vertex.length > 2) {
    for(int i = 0; i < vertex.length - 2 ; i++) {
      if (hasIntersect(vertex[i], vertex[i + 1], vertex[vertex.length - 1], offset)) {
        result = true;
        break;
      }
    }
  }
  return result;
}