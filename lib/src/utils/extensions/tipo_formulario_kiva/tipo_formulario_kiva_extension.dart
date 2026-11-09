enum TipoFormularioKiva {
  scrKivaCreditoEstandarRecurrente('ScrKivaCreditoEstandarRecurrente'),
  scrKivaCreditoEstandar('ScrKivaCreditoEstandar'),
  scrKivaMiCrediEstudio('ScrKivaMiCrediEstudio'),
  scrKivaMiCrediEstudioRecurrente('ScrKivaMiCrediEstudioRecurrente'),
  scrKivaMejoraVivienda('ScrKivaMejoraVivienda'),
  scrKivaMejoraViviendaRecurrente('ScrKivaMejoraViviendaRecurrente'),
  scrKivaAguaSaneamiento('ScrKivaAguaSaneamiento'),
  scrKivaAguaSaneamientoRecurrente('ScrKivaAguaSaneamientoRecurrente'),
  scrKivaEnergiaLimpia('ScrKivaEnergiaLimpia'),
  scrKivaEnergiaLimpiaRecurrente('ScrKivaEnergiaLimpiaRecurrente'),
  scrKivaMujerEmprende('ScrKivaMujerEmprende'),
  scrKivaMujerEmprendeRecurrente('ScrKivaMujerEmprendeRecurrente'),
  scrKivaMigrantesEconomicos('ScrKivaMigrantesEconomicos'),
  scrKivaMigrantesEconomicosRecurrentes(
      'ScrKivaMigrantesEconomicosRecurrentes');

  final String nombreFormularioKiva;
  const TipoFormularioKiva(this.nombreFormularioKiva);

  bool get esRecurrente => nombreFormularioKiva.contains('Recurrente');

  /// Nombre del producto Kiva para mostrar en pantalla.
  String get etiqueta => switch (this) {
        scrKivaCreditoEstandar ||
        scrKivaCreditoEstandarRecurrente =>
          'Crédito estándar',
        scrKivaMiCrediEstudio ||
        scrKivaMiCrediEstudioRecurrente =>
          'MiCrédi Estudio',
        scrKivaMejoraVivienda ||
        scrKivaMejoraViviendaRecurrente =>
          'Mejora de vivienda',
        scrKivaAguaSaneamiento ||
        scrKivaAguaSaneamientoRecurrente =>
          'Agua y saneamiento',
        scrKivaEnergiaLimpia ||
        scrKivaEnergiaLimpiaRecurrente =>
          'Energía limpia',
        scrKivaMujerEmprende ||
        scrKivaMujerEmprendeRecurrente =>
          'Mujer emprende',
        scrKivaMigrantesEconomicos ||
        scrKivaMigrantesEconomicosRecurrentes =>
          'Migrantes económicos',
      };
}

extension TipoFormularioKivaX on String {
  TipoFormularioKiva? toFormularioKival() {
    return TipoFormularioKiva.values
        .where((e) => e.nombreFormularioKiva == this)
        .cast<TipoFormularioKiva?>()
        .firstOrNull;
  }
}
