class WaterProperties {
  // T °C, rho kg/m3, mu Pa.s, K Pa.
  static const table = [
    [0.0, 999.84, 1.792e-3, 2.04e9],
    [5.0, 999.97, 1.519e-3, 2.10e9],
    [10.0, 999.70, 1.307e-3, 2.15e9],
    [15.0, 999.10, 1.138e-3, 2.19e9],
    [20.0, 998.21, 1.002e-3, 2.20e9],
    [25.0, 997.05, 0.890e-3, 2.22e9],
    [30.0, 995.65, 0.798e-3, 2.23e9],
    [40.0, 992.22, 0.653e-3, 2.25e9],
    [50.0, 988.05, 0.547e-3, 2.27e9],
    [60.0, 983.20, 0.467e-3, 2.28e9],
    [80.0, 971.80, 0.355e-3, 2.31e9],
    [100.0,958.40, 0.282e-3, 2.25e9],
  ];

  static double density(double t) => _interp(t, 1);
  static double dynamicViscosity(double t) => _interp(t, 2);
  static double bulkModulus(double t) => _interp(t, 3);
  static double kinematicViscosity(double t) => dynamicViscosity(t) / density(t);
  static double specificWeight(double t) => density(t) * 9.80665;

  static double _interp(double x, int c) {
    if (x < table.first[0] || x > table.last[0]) {
      throw ArgumentError('La temperatura debe estar entre 0 y 100 °C.');
    }
    for (var i = 0; i < table.length - 1; i++) {
      final x1 = table[i][0], x2 = table[i + 1][0];
      if (x >= x1 && x <= x2) {
        final y1 = table[i][c], y2 = table[i + 1][c];
        return y1 + (y2 - y1) * (x - x1) / (x2 - x1);
      }
    }
    return table.last[c];
  }
}
