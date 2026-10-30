import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_fiadores/analisis_fiadores_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/analisis_interceptor_by_flavor.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/fiadores/fiadores_hn_pendientes_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/exit_confirmation_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/sending_status_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Pantalla de envío del fiador HN. Tiene dos modos:
/// - Enviar (`guardarLocal: false`): crea el fiador, envía la firma y sube la
///   cédula, como siempre.
/// - Guardar local (`guardarLocal: true`): lo guarda en ObjectBox, con copias
///   de las fotos y la firma, para enviarlo después desde
///   `FiadoresHnPendientesScreen`.
class AnalisisFiadoresSendingWidget extends StatefulWidget {
  final bool guardarLocal;
  const AnalisisFiadoresSendingWidget({
    super.key,
    this.guardarLocal = false,
  });

  @override
  State<AnalisisFiadoresSendingWidget> createState() =>
      _AnalisisFiadoresSendingWidgetState();
}

class _AnalisisFiadoresSendingWidgetState
    extends State<AnalisisFiadoresSendingWidget> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<AnalisisFiadoresCubit>();
    if (widget.guardarLocal) {
      cubit.guardarFiadorLocal();
      return;
    }
    cubit.createAnalisisFiador();
  }

  void _goToAnalisis() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const AnalisisInterceptorByFlavor(),
      ),
    );
  }

  /// Cierra esta pantalla, el formulario y la búsqueda por documento, y abre
  /// la lista de pendientes sobre `FiadoresHnScreen`. Si ya había una lista
  /// de pendientes debajo, vuelve a ella.
  void _goToPendientes() {
    final navigator = Navigator.of(context);
    final numeroSolicitud =
        context.read<AnalisisFiadoresCubit>().state.numeroSolicitud;
    var popped = 0;
    var hayPendientesAbajo = false;
    // Pila: [..., FiadoresHnScreen, búsqueda, formulario, envío].
    navigator.popUntil((route) {
      if (route.settings.name == FiadoresHnPendientesScreen.routeName) {
        hayPendientesAbajo = true;
        return true;
      }
      if (popped == 3 || route.isFirst) return true;
      popped++;
      return false;
    });
    if (!hayPendientesAbajo) {
      navigator.push(
        FiadoresHnPendientesScreen.route(numeroSolicitud: numeroSolicitud),
      );
    }
  }

  void _onClose(Status status) {
    if (widget.guardarLocal) {
      // Guardado: a la lista. Si no, de vuelta al formulario, que conserva
      // los datos.
      if (status == Status.done) {
        _goToPendientes();
      } else if (status != Status.inProgress) {
        Navigator.pop(context);
      }
      return;
    }
    ExitConfirmationDialog(
      context: context,
      title: '¿Estás seguro de que quieres salir?',
      onYes: _goToAnalisis,
    ).showDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalisisFiadoresCubit, AnalisisFiadoresState>(
      builder: (context, state) {
        final numeroSolicitud =
            state.numeroSolicitud == 0 ? '' : state.numeroSolicitud.toString();

        return Scaffold(
          backgroundColor: RedesignColors.background,
          appBar: AppBar(
            backgroundColor: RedesignColors.background,
            surfaceTintColor: RedesignColors.background,
            elevation: 0,
            titleSpacing: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
              child: SendingCloseButton(
                onPressed: () => _onClose(state.status),
              ),
            ),
            title: const Text(
              'FIADOR',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
                color: RedesignColors.inkMuted,
              ),
            ),
          ),
          body: widget.guardarLocal
              ? _buildLocal(state, numeroSolicitud)
              : _buildEnvio(state, numeroSolicitud),
        );
      },
    );
  }

  Widget _buildEnvio(AnalisisFiadoresState state, String numeroSolicitud) {
    return switch (state.status) {
      Status.inProgress => SendingStatusView(
          artTint: RedesignColors.tealTint,
          art: const SendingStatusLottie(
            asset: ImageAsset.nuevaMenorUploading,
          ),
          title: 'Enviando fiador…',
          message: 'No cierres la app. Esto suele tardar menos de un minuto.',
          steps: [
            SendingStep(
              label: state.fiadorId.isEmpty
                  ? 'Creando fiador en el servidor'
                  : 'Fiador creado en el servidor',
              state: state.fiadorId.isEmpty
                  ? SendingStepState.active
                  : SendingStepState.done,
            ),
            SendingStep(
              label: 'Registrando firma del fiador',
              state: state.firmaStatus == Status.inProgress
                  ? SendingStepState.active
                  : SendingStepState.pending,
            ),
          ],
          value: numeroSolicitud,
        ),
      Status.done => SendingStatusView(
          artTint: RedesignColors.greenTint,
          art: const SendingStatusLottie(
            asset: ImageAsset.nuevaMenorSuccess,
            repeat: false,
          ),
          title: 'Fiador creado',
          message:
              'Los datos y la firma del fiador quedaron registrados correctamente.',
          steps: const [
            SendingStep(
              label: 'Fiador creado en el servidor',
              state: SendingStepState.done,
            ),
            SendingStep(
              label: 'Firma del fiador registrada',
              state: SendingStepState.done,
            ),
            SendingStep(
              label: 'Fotos de cedula registradas',
              state: SendingStepState.done,
            ),
          ],
          value: numeroSolicitud,
          actions: [
            CustomElevatedButton(
              text: 'Volver a análisis',
              color: RedesignColors.green,
              onPressed: _goToAnalisis,
            ),
          ],
        ),
      Status.error => SendingStatusView(
          artTint: RedesignColors.indigoTint,
          art: const Icon(
            Icons.warning_amber_rounded,
            size: 58,
            color: RedesignColors.indigo,
          ),
          title: 'Fiador no se pudo enviar',
          message:
              'Guardamos los datos en el dispositivo, puedes reintentar sin perder la información.',
          errorDetail: state.errorMsg,
          value: numeroSolicitud,
          actions: [
            CustomElevatedButton(
              text: state.fiadorId.isEmpty
                  ? 'Reintentar envío'
                  : 'Reintentar firma',
              color: RedesignColors.green,
              onPressed: () {
                final cubit = context.read<AnalisisFiadoresCubit>();
                if (cubit.state.fiadorId.isNotEmpty) {
                  cubit.fiadoresEnviarFirmaDigital();
                  return;
                }
                cubit.createAnalisisFiador();
              },
            ),
            CustomOutLineButton(
              text: 'Volver',
              color: RedesignColors.border,
              textColor: RedesignColors.ink,
              borderRadius: 12,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      _ => const SizedBox.shrink(),
    };
  }

  Widget _buildLocal(AnalisisFiadoresState state, String numeroSolicitud) {
    return switch (state.status) {
      Status.inProgress => SendingStatusView(
          artTint: RedesignColors.amberTint,
          art: const Icon(
            Icons.save_alt_rounded,
            size: 58,
            color: RedesignColors.amber,
          ),
          title: 'Guardando fiador…',
          message: 'Se guardan los datos, las fotos de la cédula y la firma.',
          steps: const [
            SendingStep(
              label: 'Guardando en el teléfono',
              state: SendingStepState.active,
            ),
          ],
          value: numeroSolicitud,
        ),
      Status.done => SendingStatusView(
          artTint: RedesignColors.amberTint,
          art: const Icon(
            Icons.save_alt_rounded,
            size: 58,
            color: RedesignColors.amber,
          ),
          title: 'Fiador guardado en el teléfono',
          message: 'Envíalo cuando tengas conexión.',
          steps: const [
            SendingStep(
              label: 'Datos del fiador guardados',
              state: SendingStepState.done,
            ),
            SendingStep(
              label: 'Fotos de cédula y firma guardadas',
              state: SendingStepState.done,
            ),
          ],
          value: numeroSolicitud,
          actions: [
            CustomElevatedButton(
              text: 'Ver fiadores pendientes',
              color: RedesignColors.amber,
              onPressed: _goToPendientes,
            ),
          ],
        ),
      Status.error => SendingStatusView(
          artTint: RedesignColors.indigoTint,
          art: const Icon(
            Icons.warning_amber_rounded,
            size: 58,
            color: RedesignColors.indigo,
          ),
          title: 'Fiador no se pudo guardar',
          message:
              'Los datos siguen en el formulario. Vuelve para corregirlos.',
          errorDetail: state.errorMsg,
          value: numeroSolicitud,
          actions: [
            CustomOutLineButton(
              text: 'Volver al formulario',
              color: RedesignColors.border,
              textColor: RedesignColors.ink,
              borderRadius: 12,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      _ => const SizedBox.shrink(),
    };
  }
}
