enum TipoGarantiaEnum {
  liquida('Garantía Liquida'),
  fiadorPrendario('Fiador Prendario'),
  fiadorSolidario('Fiador Solidario'),
  prendaAgraria('Prenda Agraria'),
  fiduciario('Fiduciaria'),
  hipotecario('Hipotecaria'),
  fiadorHipotecario('Fiador Hipotecario');

  final String codigo;

  const TipoGarantiaEnum(this.codigo);
}

extension TipoGarantiaParser on String {
  TipoGarantiaEnum toTipoGarantiaEnum() => switch (this) {
        'Garantía Liquida' => TipoGarantiaEnum.liquida,
        'Garantia Liquida' => TipoGarantiaEnum.liquida,
        'Fiador Prendario' => TipoGarantiaEnum.fiadorPrendario,
        'Fiador Solidario' => TipoGarantiaEnum.fiadorSolidario,
        'Prenda Agraria' => TipoGarantiaEnum.prendaAgraria,
        'Fiduciaria' => TipoGarantiaEnum.fiduciario,
        'Hipotecaria' => TipoGarantiaEnum.hipotecario,
        'Fiador Hipotecario' => TipoGarantiaEnum.fiadorHipotecario,
        _ => throw Exception('TipoGarantiaEnum no válido: $this'),
      };
}
