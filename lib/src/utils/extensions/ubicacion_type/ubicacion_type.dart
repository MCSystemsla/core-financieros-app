enum UbicacionType {
  pais('PAIS'),
  municipio('MUN'),
  departamento('DEP'),
  aldea('ALD'),
  caserio('CAS'),
  barrio('BR');

  final String codigo;
  const UbicacionType(this.codigo);
}
