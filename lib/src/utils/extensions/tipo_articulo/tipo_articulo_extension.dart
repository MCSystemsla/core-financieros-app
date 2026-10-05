enum TipoArticuloEnum {
  terreno(347),
  casa(348),
  edificio(349),
  vehiculo(350),
  maquinaria(351),
  taxi(352),
  mobiliarioYEquipo(353),
  dpf(355),
  derecho(354);

  final int codigo;

  const TipoArticuloEnum(this.codigo);
}

extension TipoArticuloEnumExtension on int {
  TipoArticuloEnum? get toTipoArticuloEnum {
    try {
      return TipoArticuloEnum.values.firstWhere(
        (tipo) => tipo.codigo == this,
      );
    } catch (e) {
      return null;
    }
  }
}
