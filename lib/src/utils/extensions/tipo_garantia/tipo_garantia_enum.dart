enum TipoGarantiaEnum {
  liquida('GARANTIA LIQUIDA'),
  fiadorPrendario('Fiador Prendario'),
  fiadorSolidario('Fiador Solidario'),
  prendaAgraria('Prenda Agraria'),
  fiduciario('Fiduciaria'),
  hipotecario('GARANTIA HIPOTECARIA'),
  fiadorHipotecario('Fiador Hipotecario');

  final String codigo;

  const TipoGarantiaEnum(this.codigo);
}

enum TipoGarantiaEnumV2 {
  prendaria('PRENDARIA'),
  hipotecario('HIPOTECARIO'),
  liquido('LIQUIDO');

  final String codigo;

  const TipoGarantiaEnumV2(this.codigo);
}

extension TipoGarantiaEnumExtension on String {
  TipoGarantiaEnumV2? get toTipoGarantiaEnumV2 {
    try {
      return TipoGarantiaEnumV2.values.firstWhere(
        (tipo) => tipo.codigo == this,
      );
    } catch (e) {
      return null;
    }
  }
}

extension TipoGarantiaParser on String {
  TipoGarantiaEnum toTipoGarantiaEnum() => switch (this) {
        'GARANTIA LIQUIDA' => TipoGarantiaEnum.liquida,
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
