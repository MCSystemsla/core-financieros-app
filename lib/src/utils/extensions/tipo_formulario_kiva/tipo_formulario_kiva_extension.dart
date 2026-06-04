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
}

extension TipoFormularioKivaX on String {
  TipoFormularioKiva? toFormularioKival() {
    return TipoFormularioKiva.values
        .where((e) => e.nombreFormularioKiva == this)
        .cast<TipoFormularioKiva?>()
        .firstOrNull;
  }
}
