class FluidResults {
  final double altitudeM, waterTemperatureC, waterDepthM;
  final double airTemperatureK, atmosphericPressurePa, airDensityKgM3;
  final double airSpecificWeightNm3, airDynamicViscosityPaS;
  final double waterDensityKgM3, waterSpecificWeightNm3;
  final double waterDynamicViscosityPaS, waterKinematicViscosityM2S;
  final double waterBulkModulusPa;
  final double gaugePressurePa, absolutePressurePa;
  final double atmosphericHeadMca, gaugeHeadMca, absoluteHeadMca;

  const FluidResults({
    required this.altitudeM,
    required this.waterTemperatureC,
    required this.waterDepthM,
    required this.airTemperatureK,
    required this.atmosphericPressurePa,
    required this.airDensityKgM3,
    required this.airSpecificWeightNm3,
    required this.airDynamicViscosityPaS,
    required this.waterDensityKgM3,
    required this.waterSpecificWeightNm3,
    required this.waterDynamicViscosityPaS,
    required this.waterKinematicViscosityM2S,
    required this.waterBulkModulusPa,
    required this.gaugePressurePa,
    required this.absolutePressurePa,
    required this.atmosphericHeadMca,
    required this.gaugeHeadMca,
    required this.absoluteHeadMca,
  });
}
