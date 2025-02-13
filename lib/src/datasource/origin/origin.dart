class Origin {
  final String nombre;
  final String valor;

  Origin({required this.nombre, required this.valor});
  static final List<Origin> comunidades = [
    Origin(nombre: 'Rural', valor: 'RUR'),
    Origin(nombre: 'Urbano', valor: 'URB'),
  ];
}
