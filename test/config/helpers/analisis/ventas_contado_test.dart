import 'package:core_financiero_app/src/config/helpers/analisis/ventas_contado.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('calcularVentasDeContado', () {
    test('sin nivel de producción promedia solo mensuales y diarias', () {
      final result = calcularVentasDeContado(
        totalVentasMensuales: 1000,
        totalVentasDiarias: 4000,
        nivelProduccion: 0,
      );

      expect(result, 2500);
    });

    test('con nivel de producción promedia las tres fuentes', () {
      final result = calcularVentasDeContado(
        totalVentasMensuales: 1000,
        totalVentasDiarias: 4000,
        nivelProduccion: 1000,
      );

      expect(result, 2000);
    });

    test('acepta montos con decimales', () {
      final result = calcularVentasDeContado(
        totalVentasMensuales: 1000.5,
        totalVentasDiarias: 999.5,
        nivelProduccion: 0,
      );

      expect(result, 1000);
    });
  });
}
