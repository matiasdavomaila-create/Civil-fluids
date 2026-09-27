# CIVIL FLUIDS

Aplicación móvil para cálculos básicos de propiedades de fluidos, presión e hidráulica orientada a Ingeniería Civil.

## Entradas
- Cota / altitud (m s.n.m.)
- Temperatura del agua (°C)
- Profundidad del agua (m)

## Resultados
- Presión atmosférica
- Densidad, peso específico y viscosidad del aire
- Densidad, peso específico, viscosidad y módulo volumétrico del agua
- Presión manométrica y absoluta
- Altura de presión en m.c.a.
- Conversiones de presión: Pa, kPa, MPa, bar, psi y atm

## Compilación en Codemagic
El repositorio no necesita contener manualmente la carpeta `android/`: `codemagic.yaml` ejecuta `flutter create --platforms=android` durante la compilación y después genera el APK de prueba.
