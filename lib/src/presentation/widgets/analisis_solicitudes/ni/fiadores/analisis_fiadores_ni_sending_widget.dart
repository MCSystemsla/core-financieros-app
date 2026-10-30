import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/ni/analisis_fiadores/analisis_fiadores_ni_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/analisis_interceptor_by_flavor.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/fiadores/fiadores_ni_pendientes_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/exit_confirmation_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/sending_status_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Pantalla de envío del fiador NI. Tiene dos modos:
/// - Enviar (`guardarLocal: false`): `POST /cartera/analisis-fiador/create`.
///   Si falla por red, ofrece guardar el fiador en el teléfono.
/// - Guardar local (`guardarLocal: true`): lo guarda en ObjectBox para
///   enviarlo después desde `FiadoresNiPendientesScreen`.
class AnalisisFiadoresNiSendingWidget extends StatefulWidget {
  final int numeroSolicitud;
  final bool guardarLocal;
  const AnalisisFiadoresNiSendingWidget({
    super.key,
    required this.numeroSolicitud,
    this.guardarLocal = false,
  });

  @override
  State<AnalisisFiadoresNiSendingWidget> createState() =>
      _AnalisisFiadoresNiSendingWidgetState();
}

class _AnalisisFiadoresNiSendingWidgetState
    extends State<AnalisisFiadoresNiSendingWidget> {
  late bool _modoLocal = widget.guardarLocal;

  @override
  void initState() {
    super.initState();
    _modoLocal ? _guardar() : _send();
  }

  void _send() {
    context.read<AnalisisFiadoresNiCubit>().createAnalisisFiador(
          numeroSolicitud: widget.numeroSolicitud,
        );
  }

  void _guardar() {
    setState(() => _modoLocal = true);
    context.read<AnalisisFiadoresNiCubit>().guardarFiadorLocal(
          numeroSolicitud: widget.numeroSolicitud,
        );
  }

  void _goToAnalisis() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const AnalisisInterceptorByFlavor(),
      ),
    );
  }

  /// Cierra esta pantalla y el formulario. Si debajo ya estaba la lista de
  /// pendientes (se entró por "Nuevo fiador"), vuelve a ella, que se recarga
  /// sola; si no, la abre.
  void _goToPendientes() {
    final navigator = Navigator.of(context);
    var popped = 0;
    var hayPendientesAbajo = false;
    // Pila: [..., anterior, formulario, envío]. Se sacan las dos últimas.
    navigator.popUntil((route) {
      if (popped == 2 || route.isFirst) {
        hayPendientesAbajo =
            route.settings.name == FiadoresNiPendientesScreen.routeName;
        return true;
      }
      popped++;
      return false;
    });
    if (!hayPendientesAbajo) {
      navigator.push(
        FiadoresNiPendientesScreen.route(
          numeroSolicitud: widget.numeroSolicitud,
        ),
      );
    }
  }

  void _onClose(Status status) {
    if (_modoLocal && status == Status.done) {
      _goToPendientes();
      return;
    }
    ExitConfirmationDialog(
      context: context,
      title: '¿Estás seguro de que quieres salir?',
      onYes: _modoLocal
          ? () {
              // Cerrar el diálogo antes: _goToPendientes cuenta las rutas.
              Navigator.pop(context);
              _goToPendientes();
            }
          : _goToAnalisis,
    ).showDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    final numeroSolicitud = widget.numeroSolicitud.toString();
    return BlocBuilder<AnalisisFiadoresNiCubit, AnalisisFiadoresNiState>(
      builder: (context, state) {
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
          body: _modoLocal
              ? _buildLocal(state, numeroSolicitud)
              : _buildEnvio(state, numeroSolicitud),
        );
      },
    );
  }

  Widget _buildEnvio(AnalisisFiadoresNiState state, String numeroSolicitud) {
    return switch (state.status) {
      Status.inProgress => SendingStatusView(
          artTint: RedesignColors.tealTint,
          art: const SendingStatusLottie(
            asset: ImageAsset.nuevaMenorUploading,
          ),
          title: 'Enviando fiador…',
          message: 'No cierres la app. Esto suele tardar menos de un minuto.',
          steps: const [
            SendingStep(
              label: 'Creando fiador en el servidor',
              state: SendingStepState.active,
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
          message: 'Los datos del fiador quedaron registrados.',
          steps: const [
            SendingStep(
              label: 'Fiador creado en el servidor',
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
          // Los datos viven en el cubit mientras el formulario siga abierto.
          message: state.isNetworkError
              ? 'No hay conexión con el servidor. Puedes reintentar o guardar el fiador en el teléfono para enviarlo después.'
              : 'Los datos siguen en el formulario. Puedes reintentar o volver para corregirlos.',
          errorDetail: state.errorMsg,
          value: numeroSolicitud,
          actions: [
            CustomElevatedButton(
              text: 'Reintentar envío',
              color: RedesignColors.green,
              onPressed: _send,
            ),
            if (state.isNetworkError)
              CustomElevatedButton(
                text: 'Guardar para enviar después',
                color: RedesignColors.amber,
                onPressed: _guardar,
              ),
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

  Widget _buildLocal(AnalisisFiadoresNiState state, String numeroSolicitud) {
    return switch (state.status) {
      Status.inProgress => SendingStatusView(
          artTint: RedesignColors.amberTint,
          art: const Icon(
            Icons.save_alt_rounded,
            size: 58,
            color: RedesignColors.amber,
          ),
          title: 'Guardando fiador…',
          message: 'Se guarda en el teléfono, sin conexión.',
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
              label: 'Guardado en el teléfono',
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
