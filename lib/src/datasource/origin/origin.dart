class Origin {
  final String nombre;
  final String valor;

  Origin({required this.nombre, required this.valor});
  static final List<Origin> comunidades = [
    Origin(nombre: 'Rural', valor: 'RUR'),
    Origin(nombre: 'Urbano', valor: 'URB'),
  ];
  static final List<Origin> originCatalogosValores = [
    Origin(nombre: 'BOACO', valor: 'BOA'),
    Origin(nombre: 'CARAZO', valor: 'CZ'),
    Origin(nombre: 'CHINANDEGA', valor: 'CH'),
    Origin(nombre: 'CHONTALES', valor: 'CHO'),
    Origin(nombre: 'ESTELI', valor: 'ES'),
    Origin(nombre: 'GRANADA', valor: 'GR'),
    Origin(nombre: 'JINOTEGA', valor: 'JN'),
    Origin(nombre: 'LEON', valor: 'LN'),
    Origin(nombre: 'MADRIZ', valor: 'MZ'),
    Origin(nombre: 'MANAGUA', valor: 'MGA'),
    Origin(nombre: 'MASAYA', valor: 'MY'),
    Origin(nombre: 'MATAGALPA', valor: 'MAT'),
    Origin(nombre: 'NUEVA SEGOVIA', valor: 'NS'),
    Origin(nombre: 'RIO SAN JUAN', valor: 'RJ'),
    Origin(nombre: 'RIVAS', valor: 'RV'),
    Origin(nombre: 'RAAS', valor: 'AS'),
    Origin(nombre: 'RAAN', valor: 'AN'),
  ];
}
