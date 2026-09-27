class PressureConversions {
  static double pa(double pa) => pa;
  static double kpa(double pa) => pa / 1000;
  static double mpa(double pa) => pa / 1e6;
  static double bar(double pa) => pa / 1e5;
  static double psi(double pa) => pa / 6894.757293168;
  static double atm(double pa) => pa / 101325;
}
