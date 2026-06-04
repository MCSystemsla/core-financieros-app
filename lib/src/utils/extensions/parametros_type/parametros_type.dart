enum ParametroType {
  edadMinimaCliente('EDADMINIMAGUARDASISTEMA'),
  edadMaximaCliente('EDADMAXIMACLIENTE'),
  incobrablesDeCXCobrar('INCOBRABLESDECXCOBRAR'),
  fechaOperacion('FECHAOPERACION'),
  menorMil('MENORMIL'),
  relacionMinimaRazonCuotaCredtioRecurrente(
      'RELACIONMINRAZONCUOTACREDITORECURRENTE'),
  relacionMaximaRazonCuotaCreditoNuevo('RELACIONMAXRAZONCUOTACREDITONUEVO');

  final String codigo;
  const ParametroType(this.codigo);
}
