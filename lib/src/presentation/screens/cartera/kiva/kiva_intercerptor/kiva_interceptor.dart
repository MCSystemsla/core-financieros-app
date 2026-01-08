import 'package:core_financiero_app/src/presentation/screens/forms/energia_limpia_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/estandar_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/mejora_de_vivienda_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/micredito_estudio_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/migrantes_economicos_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/mujer_emprender_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/utils/extensions/tipo_formulario_kiva/tipo_formulario_kiva_extension.dart';
import 'package:flutter/material.dart';

class KivaInterceptor extends StatelessWidget {
  final String currentRoute;
  final String solicitudId;
  final String nombre;
  final String motivoAnterior;
  final String tipoSolicitud;
  final String numero;
  final int cantidadHijos;
  final String cedula;
  final TipoFormularioKiva nombreFormularioKiva;
  final String solicitudCreditoId;
  const KivaInterceptor({
    super.key,
    required this.currentRoute,
    required this.solicitudId,
    required this.nombre,
    required this.tipoSolicitud,
    required this.numero,
    required this.cedula,
    required this.nombreFormularioKiva,
    required this.solicitudCreditoId,
    this.motivoAnterior = 'Motivo Anterior no registrado',
    this.cantidadHijos = 0,
  });

  @override
  Widget build(BuildContext context) {
    return switch (nombreFormularioKiva) {
      TipoFormularioKiva.scrKivaCreditoEstandar => EstandarScreen(
          typeProduct: nombreFormularioKiva.nombreFormularioKiva,
        ),
      TipoFormularioKiva.scrKivaCreditoEstandarRecurrente => EstandarScreen(
          typeProduct: nombreFormularioKiva.nombreFormularioKiva,
        ),
      TipoFormularioKiva.scrKivaAguaSaneamiento => SaneamientoScreen(
          typeProduct: nombreFormularioKiva.nombreFormularioKiva,
        ),
      TipoFormularioKiva.scrKivaAguaSaneamientoRecurrente => SaneamientoScreen(
          typeProduct: nombreFormularioKiva.nombreFormularioKiva,
        ),
      TipoFormularioKiva.scrKivaMejoraVivienda => MejoraDeViviendaScreen(
          typeProducto: nombreFormularioKiva.nombreFormularioKiva,
        ),
      TipoFormularioKiva.scrKivaMejoraViviendaRecurrente =>
        MejoraDeViviendaScreen(
          typeProducto: nombreFormularioKiva.nombreFormularioKiva,
        ),
      TipoFormularioKiva.scrKivaMigrantesEconomicos =>
        MigrantesEconomicosScreen(
          typeProduct: nombreFormularioKiva.nombreFormularioKiva,
        ),
      TipoFormularioKiva.scrKivaMigrantesEconomicosRecurrentes =>
        MigrantesEconomicosScreen(
          typeProduct: nombreFormularioKiva.nombreFormularioKiva,
        ),
      TipoFormularioKiva.scrKivaMujerEmprende => MujerEmprenderScreen(
          typeProduct: nombreFormularioKiva.nombreFormularioKiva,
        ),
      TipoFormularioKiva.scrKivaMujerEmprendeRecurrente => MujerEmprenderScreen(
          typeProduct: nombreFormularioKiva.nombreFormularioKiva,
        ),
      TipoFormularioKiva.scrKivaEnergiaLimpia => EnergiaLimpiaScreen(
          typeProduct: nombreFormularioKiva.nombreFormularioKiva,
        ),
      TipoFormularioKiva.scrKivaEnergiaLimpiaRecurrente => EnergiaLimpiaScreen(
          typeProduct: nombreFormularioKiva.nombreFormularioKiva,
        ),
      TipoFormularioKiva.scrKivaMiCrediEstudio => MiCreditoEstudioScreen(
          typeProduct: nombreFormularioKiva.nombreFormularioKiva,
        ),
      TipoFormularioKiva.scrKivaMiCrediEstudioRecurrente =>
        MiCreditoEstudioScreen(
          typeProduct: nombreFormularioKiva.nombreFormularioKiva,
        ),
    };
  }
}
