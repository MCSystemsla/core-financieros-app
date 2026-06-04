enum CatalogoType {
  tipoPersonaCredito('TIPOSPERSONACREDITO'),
  sexo('SEXO'),
  moneda('MONEDA'),
  tipoDocumentoPersona('TIPODOCUMENTOPERSONA'),
  tipoVivienda('TIPOVIVIENDA'),
  estadoCivil('ESTADOCIVIL'),
  escolaridad('ESCOLARIDAD'),
  tipoPersonaCNBS('TIPOPERSONACNBS'),
  tipoCliente('TIPOCLIENTE'),
  ocupacion('OCUPACION'),
  nivelaproximadoIngresos('NIVELAPROXIMADOINGRESOS'),
  tipoSolicitudCredito('TIPOSOLICITUDCREDITO'),
  estatusCliente('ESTATUSCLIENTE'),
  profesion('PROFESION'),
  destinoCredito('DESTINOCREDITO'),
  sectorEconomico('SECTORECONOMICO'),
  actividadEconomica('ACTIVIDADECONOMICA'),
  medidasConocimiento('MEDIDASCONOCIMIENTO'),
  parentesco('PARENTESCO'),
  estadoPrestamo('ESTADOPRESTAMO'),
  relacionPersonas('RELACIONPERSONAS'),
  tipoGarantia('TIPOGARANTIA'),
  tipoPersona('TIPOPERSONA'),
  ubicacionGPS('UBICACIONGPS'),
  actividadesEconomicasCNBS('ACTIVIDADESECONOMICASCNBS'),
  empleados('EMPLEADOS'),
  producto('PRODUCTO'),
  cargosDisponibles('CARGOSDISPONIBLES'),
  gruposActivos('GRUPOSACTIVOS'),
  programa('PROGRAMA'),
  tipoDesembolsos('TIPOSDESEMBOLSOS'),
  parentescoPeps('PARENTESCOPEPS');

  final String codigo;

  const CatalogoType(this.codigo);
}
