// Ф-я расчета координат с учётом масштабирования
double getCord(double pos, double center, double z, double offset){
  return (pos - center) * z + center + offset;
}

double getCord2(double pos, double center, double z, double offset){
  return (pos * z) - center +(center * z) + center;
}