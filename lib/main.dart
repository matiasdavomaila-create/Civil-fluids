import 'package:flutter/material.dart';
import 'fluid_engine.dart';
import 'calculations/conversions.dart';

void main() => runApp(const CivilFluidsApp());

class CivilFluidsApp extends StatelessWidget {
  const CivilFluidsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Civil Fluids',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final altitude = TextEditingController(text: '0');
  final temperature = TextEditingController(text: '20');
  final depth = TextEditingController(text: '5');

  String? error;
  dynamic result;

  void calculate() {
    try {
      final z = double.parse(altitude.text.replaceAll(',', '.'));
      final t = double.parse(temperature.text.replaceAll(',', '.'));
      final h = double.parse(depth.text.replaceAll(',', '.'));

      setState(() {
        error = null;
        result = FluidEngine.calculate(
          altitudeM: z,
          waterTemperatureC: t,
          waterDepthM: h,
        );
      });
    } catch (e) {
      setState(() => error = e.toString().replaceFirst('Invalid argument(s): ', ''));
    }
  }

  Widget field(String label, TextEditingController c, String unit) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: label,
          suffixText: unit,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget resultCard(String title, List<String> rows) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...rows.map((r) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Text(r),
            )),
          ],
        ),
      ),
    );
  }

  String f(double x, [int n = 3]) => x.toStringAsFixed(n);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CIVIL FLUIDS')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Propiedades de fluidos e hidráulica',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          field('Cota / altitud', altitude, 'm s.n.m.'),
          field('Temperatura del agua', temperature, '°C'),
          field('Profundidad del agua', depth, 'm'),
          FilledButton.icon(
            onPressed: calculate,
            icon: const Icon(Icons.calculate),
            label: const Padding(
              padding: EdgeInsets.all(12),
              child: Text('CALCULAR'),
            ),
          ),
          if (error != null) ...[
            const SizedBox(height: 12),
            Text(error!, style: const TextStyle(color: Colors.red)),
          ],
          if (result != null) ...[
            const SizedBox(height: 20),
            resultCard('🌎 Atmósfera', [
              'Temperatura: ${f(result.airTemperatureK)} K',
              'Presión atmosférica: ${f(PressureConversions.pa(result.atmosphericPressurePa), 1)} Pa',
              'Presión atmosférica: ${f(PressureConversions.kpa(result.atmosphericPressurePa))} kPa',
              'Presión atmosférica: ${f(PressureConversions.mpa(result.atmosphericPressurePa), 4)} MPa',
              'Presión atmosférica: ${f(PressureConversions.bar(result.atmosphericPressurePa), 4)} bar',
              'Presión atmosférica: ${f(PressureConversions.psi(result.atmosphericPressurePa))} psi',
              'Presión atmosférica: ${f(PressureConversions.atm(result.atmosphericPressurePa), 4)} atm',
              'Densidad del aire: ${f(result.airDensityKgM3, 4)} kg/m³',
              'Peso específico: ${f(result.airSpecificWeightNm3, 3)} N/m³',
              'Viscosidad dinámica: ${result.airDynamicViscosityPaS.toStringAsExponential(4)} Pa·s',
            ]),
            resultCard('💧 Agua', [
              'Densidad: ${f(result.waterDensityKgM3, 3)} kg/m³',
              'Peso específico: ${f(result.waterSpecificWeightNm3, 3)} N/m³',
              'Viscosidad dinámica: ${result.waterDynamicViscosityPaS.toStringAsExponential(4)} Pa·s',
              'Viscosidad cinemática: ${result.waterKinematicViscosityM2S.toStringAsExponential(4)} m²/s',
              'Módulo volumétrico: ${result.waterBulkModulusPa.toStringAsExponential(4)} Pa',
            ]),
            resultCard('📐 Presiones', [
              'Manométrica: ${f(PressureConversions.pa(result.gaugePressurePa), 1)} Pa',
              'Manométrica: ${f(PressureConversions.kpa(result.gaugePressurePa))} kPa',
              'Manométrica: ${f(PressureConversions.mpa(result.gaugePressurePa), 4)} MPa',
              'Manométrica: ${f(PressureConversions.bar(result.gaugePressurePa), 4)} bar',
              'Manométrica: ${f(PressureConversions.psi(result.gaugePressurePa))} psi',
              'Manométrica: ${f(PressureConversions.atm(result.gaugePressurePa), 4)} atm',
              'Manométrica: ${f(result.gaugeHeadMca)} m.c.a.',
              'Absoluta: ${f(PressureConversions.pa(result.absolutePressurePa), 1)} Pa',
              'Absoluta: ${f(PressureConversions.kpa(result.absolutePressurePa))} kPa',
              'Absoluta: ${f(PressureConversions.mpa(result.absolutePressurePa), 4)} MPa',
              'Absoluta: ${f(PressureConversions.bar(result.absolutePressurePa), 4)} bar',
              'Absoluta: ${f(PressureConversions.psi(result.absolutePressurePa))} psi',
              'Absoluta: ${f(PressureConversions.atm(result.absolutePressurePa), 4)} atm',
              'Atmosférica: ${f(result.atmosphericHeadMca)} m.c.a.',
            ]),
          ],
        ],
      ),
    );
  }
}
