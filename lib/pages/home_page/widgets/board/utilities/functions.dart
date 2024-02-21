// Ф-ии расчета координат
double GPSCToLocal(double pos, double center, double z, double offset) =>
  (pos + offset) * z + center;

double localToGPSC(double pos, double center, double z, double offset) =>
  (pos - center) / z - offset;