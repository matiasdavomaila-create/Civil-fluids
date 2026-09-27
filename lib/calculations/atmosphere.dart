import 'dart:math' as math;

class Atmosphere {
  static const g = 9.80665;
  static const p0 = 101325.0;
  static const t0 = 288.15;
  static const lapse = 0.0065;
  static const rAir = 287.058;

  static double temperatureK(double z) {
    if (z < 0 || z > 11000) {
      throw ArgumentError('La cota debe estar entre 0 y 11 000 m en esta versión.');
    }
    return t0 - lapse * z;
  }

  static double pressurePa(double z) {
    final t = temperatureK(z);
    return p0 * math.pow(t / t0, g / (rAir * lapse));
  }

  static double density(double z) {
    final t = temperatureK(z);
    return pressurePa(z) / (rAir * t);
  }

  static double specificWeight(double z) => density(z) * g;

  static double dynamicViscosity(double z) {
    final t = temperatureK(z);
    const mu0 = 1.716e-5;
    const tRef = 273.15;
    const s = 111.0;
    return mu0 * math.pow(t / tRef, 1.5) * ((tRef + s) / (t + s));
  }
}
