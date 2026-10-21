/// Tipos de fiador de Nicaragua.
///
/// Códigos PROVISIONALES: solo `FIA` viene confirmado por backend. Se
/// reemplazan por los reales de NI cuando backend los defina.
enum FiadoresNiFormType {
  fiador('FIA'),
  conyuge('CON'),
  codeudor('COD');

  final String codigo;
  const FiadoresNiFormType(this.codigo);
}
