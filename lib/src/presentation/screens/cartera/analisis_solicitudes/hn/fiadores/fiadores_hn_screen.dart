import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/fiadores/fiador_solicitud_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_fiador_aval/analisis_fiador_aval_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/fiadores_solicitud/fiadores_solicitud_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/fiadores/fiadores_hn_form_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/fiadores/fiadores_hn_pendientes_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/fiadores/fiadores_search_by_document_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/borrador_sin_numero/sin_numero_notice_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/fiadores/registrados/desvincular_fiador_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/fiadores/registrados/fiadores_registrados_section.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/module_tile_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class FiadoresHnScreen extends StatefulWidget {
  final int numeroSolicitud;
  final String tipoSolicitud;
  const FiadoresHnScreen({
    super.key,
    required this.numeroSolicitud,
    required this.tipoSolicitud,
  });

  @override
  State<FiadoresHnScreen> createState() => _FiadoresHnScreenState();
}

class _FiadoresHnScreenState extends State<FiadoresHnScreen> {
  final _localDb = global<AnalisisBoxServiceHn>();
  int _pendientes = 0;
  StreamSubscription<void>? _pendientesSub;
  final _registradosCubit =
      FiadoresSolicitudHnCubit(AnalisisRepositoryHNImpl());
  late final bool _consultaBackend;

  @override
  void initState() {
    super.initState();
    _consultaBackend =
        context.read<InternetConnectionCubit>().state.isConnected &&
            widget.numeroSolicitud >= 0;
    if (_consultaBackend) _loadRegistrados();
    _pendientes = _getPendientesCount();
    // La lista de pendientes también se abre desde la pantalla de envío
    // (al guardar sin conexión), así que el conteo escucha los cambios del
    // box en vez de recargar solo al volver de `_goToPendientes`.
    _pendientesSub = _localDb.analisisFiadorHnLocalDbBox
        .query()
        .watch()
        .listen((_) => _countPendientes());
  }

  @override
  void dispose() {
    _pendientesSub?.cancel();
    _registradosCubit.close();
    super.dispose();
  }

  void _loadRegistrados() {
    _registradosCubit.load(numeroSolicitud: widget.numeroSolicitud);
  }

  int _getPendientesCount() {
    return _localDb
        .getFiadoresHnPendientes(
          numeroSolicitud: widget.numeroSolicitud,
          userId: LocalStorage().userId,
        )
        .length;
  }

  void _countPendientes() {
    if (!mounted) return;
    final count = _getPendientesCount();
    if (count != _pendientes) setState(() => _pendientes = count);
  }

  Future<void> _goToSearch(FiadoresHnFormType typeForm) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => FiadoresSearchByDocumentScreen(
          typeForm: typeForm,
          numeroSolicitud: widget.numeroSolicitud,
        ),
      ),
    );
    // Un fiador recién creado en línea aparece en "Registrados en el sistema".
    if (mounted && _consultaBackend) _loadRegistrados();
  }

  void _verRegistrado(FiadorSolicitudHn fiador) {
    _registradosCubit.verDetalle(
      numeroSolicitud: widget.numeroSolicitud,
      cedula: fiador.fiador.cedula,
    );
  }

  /// Abre el detalle cargado en solo lectura, o muestra el error (SPEC 10).
  void _onDetalle(BuildContext context, FiadoresSolicitudHnState state) {
    final detalle = state.detalle;
    final error = state.detalleError;
    if (detalle == null && error == null) return;
    _registradosCubit.limpiarDetalle();

    if (detalle != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => FiadoresHnFormScreen(
            type: FiadoresHnFormType.fromCodigo(
              detalle.fiador.tipoFiadorCodigo,
            ),
            numeroSolicitud: widget.numeroSolicitud,
            fiadorRegistrado: detalle,
          ),
        ),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error!)),
    );
  }

  /// Desvincula un fiador registrado (SPEC 11). [context] debe estar debajo
  /// del `BlocProvider` de [AnalisisFiadorAvalCubit].
  Future<void> _desvincular(
    BuildContext context,
    FiadorSolicitudHn fiador,
  ) async {
    final avalCubit = context.read<AnalisisFiadorAvalCubit>();
    final messenger = ScaffoldMessenger.of(context);
    final mensaje = await DesvincularFiadorDialog.show(
      context,
      fiador: fiador,
      numeroSolicitud: widget.numeroSolicitud,
    );
    if (mensaje == null || !mounted) return;

    messenger.showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: RedesignColors.green,
      ),
    );
    _loadRegistrados();
    // Actualiza las etiquetas "Registrado" y el bloqueo de Cónyuge.
    avalCubit.checkFiadorAval(
      numeroSolicitud: widget.numeroSolicitud,
      tipoSolicitud: widget.tipoSolicitud,
    );
  }

  void _goToPendientes() {
    FiadoresHnPendientesScreen.open(
      context,
      numeroSolicitud: widget.numeroSolicitud,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Sin conexión, o sin número de solicitud (SPEC 06), no se revisa qué
    // fiadores tiene la solicitud en el backend.
    final numeroSolicitud = widget.numeroSolicitud;
    final isConnected =
        context.read<InternetConnectionCubit>().state.isConnected &&
            numeroSolicitud >= 0;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) {
            final cubit = AnalisisFiadorAvalCubit(AnalisisRepositoryHNImpl());
            if (isConnected) {
              cubit.checkFiadorAval(
                numeroSolicitud: numeroSolicitud,
                tipoSolicitud: widget.tipoSolicitud,
              );
            }
            return cubit;
          },
        ),
        BlocProvider.value(value: _registradosCubit),
      ],
      child: BlocListener<FiadoresSolicitudHnCubit, FiadoresSolicitudHnState>(
        listenWhen: (previous, current) =>
            previous.detalle != current.detalle ||
            previous.detalleError != current.detalleError,
        listener: _onDetalle,
        child: Scaffold(
          backgroundColor: RedesignColors.background,
          body: SafeArea(
            bottom: false,
            child:
                BlocBuilder<AnalisisFiadorAvalCubit, AnalisisFiadorAvalState>(
              builder: (context, state) {
                final isLoading = state.status == Status.inProgress;
                String? registradoTag(bool tieneFiador) =>
                    isConnected && !isLoading && tieneFiador
                        ? 'Registrado'
                        : null;

                return ListView(
                  padding: const EdgeInsets.only(bottom: 24),
                  children: [
                    ScreenHeaderWidget(
                      title: 'Fiadores',
                      subtitle:
                          'Elige el tipo de fiador para la solicitud ${numeroSolicitudLabel(numeroSolicitud)}. Luego buscarás a la persona por su documento.',
                      onBack: () => Navigator.pop(context),
                    ),
                    const Gap(24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          if (isLoading) ...[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: const LinearProgressIndicator(
                                minHeight: 3,
                                color: RedesignColors.green,
                                backgroundColor: RedesignColors.greenTint,
                              ),
                            ),
                            const Gap(14),
                          ],
                          if (_pendientes > 0) ...[
                            ModuleTileWidget(
                              icon: Icons.cloud_upload_outlined,
                              iconColor: RedesignColors.amber,
                              iconBackground: RedesignColors.amberTint,
                              title: 'Pendientes en el teléfono ($_pendientes)',
                              subtitle: 'Fiadores guardados sin conexión. '
                                  'Envíalos cuando tengas conexión',
                              onPressed: _goToPendientes,
                            ),
                            const Gap(10),
                          ],
                          ModuleTileWidget(
                            icon: Icons.favorite_border_rounded,
                            iconColor: RedesignColors.purple,
                            iconBackground: RedesignColors.purpleTint,
                            title: 'Cónyuge',
                            subtitle:
                                'Crear fiador cónyuge. Solo se permite uno',
                            tag: registradoTag(state.tieneConyugue),
                            onPressed: () {
                              final tieneConyugePendiente =
                                  _localDb.existsConyugeHnPendiente(
                                numeroSolicitud: numeroSolicitud,
                                userId: LocalStorage().userId,
                              );
                              if (state.tieneConyugue ||
                                  tieneConyugePendiente) {
                                CustomAlertDialog(
                                  onDone: () => context.pop(),
                                  context: context,
                                  title:
                                      'No se puede crear mas de un fiador cónyuge',
                                ).showDialog(
                                  context,
                                  dialogType: DialogType.infoReverse,
                                );
                                return;
                              }
                              _goToSearch(FiadoresHnFormType.conyugue);
                            },
                          ),
                          const Gap(10),
                          ModuleTileWidget(
                            icon: Icons.verified_user_outlined,
                            iconColor: RedesignColors.indigo,
                            iconBackground: RedesignColors.indigoTint,
                            title: 'Aval',
                            subtitle: 'Crear fiador aval',
                            tag: registradoTag(state.tieneAval),
                            onPressed: () =>
                                _goToSearch(FiadoresHnFormType.aval),
                          ),
                          const Gap(10),
                          ModuleTileWidget(
                            icon: Icons.group_add_outlined,
                            iconColor: RedesignColors.teal,
                            iconBackground: RedesignColors.tealTint,
                            title: 'Codeudor',
                            subtitle: 'Crear fiador codeudor',
                            tag: registradoTag(state.tieneCodeudor),
                            onPressed: () =>
                                _goToSearch(FiadoresHnFormType.codeudor),
                          ),
                          if (_consultaBackend) ...[
                            const Gap(24),
                            FiadoresRegistradosSection(
                              onRetry: _loadRegistrados,
                              onTap: _verRegistrado,
                              onDesvincular: (fiador) =>
                                  _desvincular(context, fiador),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
