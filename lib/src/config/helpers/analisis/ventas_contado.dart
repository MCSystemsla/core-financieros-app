/// Promedio mensual de ventas de contado del estado de resultado.
///
/// El nivel de producción es opcional: si no se llenó, el promedio es solo
/// entre ventas mensuales y diarias.
double calcularVentasDeContado({
  required num totalVentasMensuales,
  required num totalVentasDiarias,
  required num nivelProduccion,
}) {
  final fuentes = nivelProduccion > 0 ? 3 : 2;
  return (totalVentasMensuales + totalVentasDiarias + nivelProduccion) /
      fuentes;
}
