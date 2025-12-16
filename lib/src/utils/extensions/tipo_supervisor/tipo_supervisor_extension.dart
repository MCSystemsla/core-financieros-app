enum TipoSupervisorEnum {
  coordinador('coordinador'),
  regional('regional'),
  credito('credito'),
  riesgo('riesgo');

  final String codigo;
  const TipoSupervisorEnum(this.codigo);
}

enum SupervisionItem1 {
  bueno,
  regular,
  malo,
}

enum SupervisionItem2 {
  alquiler,
  propia,
  casaDeTrabajo,
}

enum SupervisionItem3 {
  si,
  no,
  na,
}
