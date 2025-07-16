enum EstadoCredito {
  rechazada('RECH'),
  desembolsada('DESEMB'),
  asignada('AUT'),
  registrada('REG'),
  enComite('CERRADA'),
  enRevision('REV'),
  procesada('PROC'),
  enPreCierre('PRECIERRE'),
  formalizada('FORM'),
  prorrogado('PRORRAD'),
  pendiente('PEND'),
  desistimiento('DESI');

  final String codigo;

  const EstadoCredito(this.codigo);
}
