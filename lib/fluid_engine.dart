import 'calculations/atmosphere.dart';
import 'calculations/pressure.dart';
import 'calculations/water.dart';
import 'models/fluid_results.dart';

class FluidEngine {
  static FluidResults calculate({
    required double altitudeM,
    required double waterTemperatureC,
    required double waterDepthM,
  }) {
    final airT = Atmosphere.temperatureK(altitudeM);
    final patm = Atmosphere.pressurePa(altitudeM);
    final rhoAir = Atmosphere.density(altitudeM);
    final gammaAir = Atmosphere.specificWeight(altitudeM);
    final muAir = Atmosphere.dynamicViscosity(altitudeM);

    final rho = WaterProperties.density(waterTemperatureC);
    final gamma = WaterProperties.specificWeight(waterTemperatureC);
    final mu = WaterProperties.dynamicViscosity(waterTemperatureC);
    final nu = WaterProperties.kinematicViscosity(waterTemperatureC);
    final k = WaterProperties.bulkModulus(waterTemperatureC);

    final pg = Pressure.gauge(rho, waterDepthM);
    final pa = Pressure.absolute(patm, pg);

    return FluidResults(
      altitudeM: altitudeM,
      waterTemperatureC: waterTemperatureC,
      waterDepthM: waterDepthM,
      airTemperatureK: airT,
      atmosphericPressurePa: patm,
      airDensityKgM3: rhoAir,
      airSpecificWeightNm3: gammaAir,
      airDynamicViscosityPaS: muAir,
      waterDensityKgM3: rho,
      waterSpecificWeightNm3: gamma,
      waterDynamicViscosityPaS: mu,
      waterKinematicViscosityM2S: nu,
      waterBulkModulusPa: k,
      gaugePressurePa: pg,
      absolutePressurePa: pa,
      atmosphericHeadMca: Pressure.toMca(patm, rho),
      gaugeHeadMca: Pressure.toMca(pg, rho),
      absoluteHeadMca: Pressure.toMca(pa, rho),
    );
  }
}
