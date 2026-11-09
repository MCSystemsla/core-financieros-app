import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/agua_y_saneamiento/agua_y_saneamiento_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/energia_limpia/energia_limpia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/estandar/estandar_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/mejora_vivienda/mejora_vivienda_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/micredi_estudio/micredi_estudio_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/migrantes_economicos/migrantes_economicos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/mujer_emprende/mujer_emprende_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_,mejora_vivienda.dart/recurrente_mejora_vivienda_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_agua_y_saniamiento/recurrente_agua_y_saneamiento_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_energia_limpia/recurrente_energia_limpia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_estandar/recurrente_estandart_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_micredi_estudio/recurrente_micredi_estudio_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_migrante_economico/recurrente_migrantes_economicos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_mujer_emprende/recurrente_mujer_emprende_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/energia_limpia_offline.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/estandar_offline_responses.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/mejora_vivienda_offline.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/micredi_estudio_responses.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/migrantes_economicos_offline.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/mujer_emprende_offline.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/recurrente_migrante_economico_offline.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/saneamiento_offline.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/card_tag_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/tipo_formulario_kiva/tipo_formulario_kiva_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

/// Revisión y envío de las respuestas Kiva guardadas en el teléfono.
///
/// Se abre desde la lista Kiva (`KivaFormScreen`) y desde el historial Kiva
/// (`needGoBack: true`, vuelve a la lista al terminar el envío). Los datos de
/// cédula/número/tipo que se envían junto a las imágenes salen de
/// `KivaRouteCubit`, que el llamador carga antes de abrir la pantalla.
class ConfirmationOfflineResponsesScreen extends StatelessWidget {
  final String typeProduct;
  final String solicitudId;
  final String nombre;
  final bool needGoBack;
  const ConfirmationOfflineResponsesScreen({
    super.key,
    required this.typeProduct,
    this.solicitudId = '',
    this.nombre = '',
    this.needGoBack = false,
  });

  @override
  Widget build(BuildContext context) {
    final repository = ResponsesRepositoryImpl();
    final formulario = typeProduct.toFormularioKival();
    final numero = context.select<KivaRouteCubit, String>(
      (cubit) => cubit.state.numero,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => EstandarCubit(repository)),
        BlocProvider(create: (_) => RecurrenteEstandartCubit(repository)),
        BlocProvider(create: (_) => MicrediEstudioCubit(repository)),
        BlocProvider(create: (_) => RecurrenteMicrediEstudioCubit(repository)),
        BlocProvider(create: (_) => MejoraViviendaCubit(repository)),
        BlocProvider(create: (_) => RecurrenteMejoraViviendaCubit(repository)),
        BlocProvider(create: (_) => AguaYSaneamientoCubit(repository)),
        BlocProvider(
          create: (_) => RecurrenteAguaYSaneamientoCubit(repository),
        ),
        BlocProvider(create: (_) => EnergiaLimpiaCubit(repository)),
        BlocProvider(create: (_) => RecurrenteEnergiaLimpiaCubit(repository)),
        BlocProvider(create: (_) => MujerEmprendeCubit(repository)),
        BlocProvider(create: (_) => RecurrenteMujerEmprendeCubit(repository)),
        BlocProvider(create: (_) => MigrantesEconomicosCubit(repository)),
        BlocProvider(
          create: (_) => RecurrenteMigrantesEconomicosCubit(repository),
        ),
        BlocProvider(create: (_) => UploadUserFileCubit(repository)),
      ],
      child: Scaffold(
        backgroundColor: RedesignColors.background,
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenHeaderWidget(
                title: formulario?.etiqueta ?? 'Formulario Kiva',
                subtitle: nombre.trim().isEmpty
                    ? 'Revisa las respuestas antes de enviarlas.'
                    : '${nombre.trim()}\nRevisa las respuestas antes de enviarlas.',
                onBack: () => Navigator.of(context).maybePop(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 14),
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    const CardTagWidget(
                      label: 'Kiva',
                      color: RedesignColors.teal,
                      background: RedesignColors.tealTint,
                    ),
                    if (formulario != null)
                      CardTagWidget(
                        label: formulario.esRecurrente ? 'Recurrente' : 'Nuevo',
                        color: formulario.esRecurrente
                            ? RedesignColors.purple
                            : RedesignColors.indigo,
                        background: formulario.esRecurrente
                            ? RedesignColors.purpleTint
                            : RedesignColors.indigoTint,
                      ),
                    if (numero.trim().isNotEmpty)
                      CardTagWidget(
                        label: 'Solicitud #${numero.trim()}',
                        color: RedesignColors.inkMuted,
                        background: RedesignColors.tagBackground,
                      ),
                    const CardTagWidget(
                      label: 'Guardado en el teléfono',
                      color: RedesignColors.amber,
                      background: RedesignColors.amberTint,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _CurrentForm(
                  formulario: formulario,
                  solicitudId: int.tryParse(solicitudId) ?? 0,
                  needGoBack: needGoBack,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CurrentForm extends StatelessWidget {
  const _CurrentForm({
    required this.formulario,
    required this.solicitudId,
    required this.needGoBack,
  });

  final TipoFormularioKiva? formulario;
  final int solicitudId;
  final bool needGoBack;

  @override
  Widget build(BuildContext context) {
    final formulario = this.formulario;
    if (formulario == null) return const _FormularioDesconocido();

    return switch (formulario) {
      TipoFormularioKiva.scrKivaCreditoEstandarRecurrente =>
        EstandarOfflineForm(
          typeProduct: formulario.nombreFormularioKiva,
          solicitudId: solicitudId,
          needGoBack: needGoBack,
        ),
      TipoFormularioKiva.scrKivaCreditoEstandar => EstandarForm(
          solicitudId: solicitudId,
          needGoBack: needGoBack,
        ),
      TipoFormularioKiva.scrKivaMiCrediEstudio => MicrediEstudioForm(
          solicitudId: solicitudId,
          needGoBack: needGoBack,
        ),
      TipoFormularioKiva.scrKivaMiCrediEstudioRecurrente =>
        MiCrediEstudioRecurrenteForm(
          solicitudId: solicitudId,
          needGoBack: needGoBack,
        ),
      TipoFormularioKiva.scrKivaMejoraVivienda => ViviendaNuevaOfflineResponse(
          solicitudId: solicitudId,
          needGoBack: needGoBack,
        ),
      TipoFormularioKiva.scrKivaMejoraViviendaRecurrente =>
        RecurrenteViviendaOfflineResponse(
          solicitudId: solicitudId,
          needGoBack: needGoBack,
        ),
      TipoFormularioKiva.scrKivaAguaSaneamiento => AguaSaneamientoOffline(
          solicitudId: solicitudId,
          needGoBack: needGoBack,
        ),
      TipoFormularioKiva.scrKivaAguaSaneamientoRecurrente =>
        RecurrenteSaneamientoOffline(
          solicitudId: solicitudId,
          needGoBack: needGoBack,
        ),
      TipoFormularioKiva.scrKivaEnergiaLimpia => EnergiaLImpiaOffline(
          solicitudId: solicitudId,
          needGoBack: needGoBack,
        ),
      TipoFormularioKiva.scrKivaEnergiaLimpiaRecurrente =>
        RecurrenteEnergiaLimpiaOffline(
          solicitudId: solicitudId,
          needGoBack: needGoBack,
        ),
      TipoFormularioKiva.scrKivaMujerEmprende => MujerEmprendeOffline(
          solicitudId: solicitudId,
          needGoBack: needGoBack,
        ),
      TipoFormularioKiva.scrKivaMujerEmprendeRecurrente =>
        RecurrenteMujerEmprendeOffline(
          solicitudId: solicitudId,
          needGoBack: needGoBack,
        ),
      TipoFormularioKiva.scrKivaMigrantesEconomicos => MigranteEconomicoOffline(
          solicitudId: solicitudId,
          needGoBack: needGoBack,
        ),
      TipoFormularioKiva.scrKivaMigrantesEconomicosRecurrentes =>
        RecurrenteMigranteEconomicoOffline(
          solicitudId: solicitudId,
          needGoBack: needGoBack,
        ),
    };
  }
}

/// Antes un `nombreFormulario` desconocido dejaba la pantalla en blanco.
class _FormularioDesconocido extends StatelessWidget {
  const _FormularioDesconocido();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                color: RedesignColors.redTint,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.help_outline_rounded,
                color: RedesignColors.red,
                size: 30,
              ),
            ),
            const Gap(18),
            const Text(
              'Formulario Kiva no reconocido',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: RedesignColors.ink,
              ),
            ),
            const Gap(8),
            const Text(
              'No sabemos qué formulario corresponde a esta solicitud. '
              'Vuelve a la lista e inténtalo de nuevo.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.5,
                height: 1.45,
                color: RedesignColors.inkMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
