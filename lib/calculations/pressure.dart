class Pressure {
  static const g = 9.80665;

  static double gauge(double rho, double h) {
    if (h < 0) throw ArgumentError('La profundidad no puede ser negativa.');
    return rho * g * h;
  }

  static double absolute(double patm, double pgauge) => patm + pgauge;

  static double toMca(double pressurePa, double rhoWater) =>
      pressurePa / (rhoWater * g);
}
