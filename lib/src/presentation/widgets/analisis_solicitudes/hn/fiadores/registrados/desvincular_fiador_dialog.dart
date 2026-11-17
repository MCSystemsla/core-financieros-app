import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/fiadores/fiador_solicitud_hn.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/desvincular_fiador/desvincular_fiador_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/info_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DesvincularFiadorDialog extends StatefulWidget {
  static const motivoMinimo = 10;
  static const motivoMaximo = 250;

  final FiadorSolicitudHn fiador;
  final int numeroSolicitud;

  const DesvincularFiadorDialog({
    super.key,
    required this.fiador,
    required this.numeroSolicitud,
  });

  /// Devuelve el `message` del backend si se desvinculó, o `null` si se
  /// canceló.
  static Future<String?> show(
    BuildContext context, {
    required FiadorSolicitudHn fiador,
    required int numeroSolicitud,
  }) {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (_) => BlocProvider(
        create: (_) => DesvincularFiadorHnCubit(AnalisisRepositoryHNImpl()),
        child: DesvincularFiadorDialog(
          fiador: fiador,
          numeroSolicitud: numeroSolicitud,
        ),
      ),
    );
  }

  @override
  State<DesvincularFiadorDialog> createState() =>
      _DesvincularFiadorDialogState();
}

class _DesvincularFiadorDialogState extends State<DesvincularFiadorDialog> {
  final _formKey = GlobalKey<FormState>();
  final _motivoController = TextEditingController();

  @override
  void dispose() {
    _motivoController.dispose();
    super.dispose();
  }

  String? _validarMotivo(String? value) {
    final motivo = (value ?? '').trim();
    if (motivo.isEmpty) return 'Escribe el motivo';
    if (motivo.length < DesvincularFiadorDialog.motivoMinimo) {
      return 'El motivo debe tener al menos '
          '${DesvincularFiadorDialog.motivoMinimo} caracteres';
    }
    return null;
  }

  void _desvincular() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<DesvincularFiadorHnCubit>().desvincular(
          numeroSolicitud: widget.numeroSolicitud,
          fiadorId: widget.fiador.idFiador,
          motivo: _motivoController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DesvincularFiadorHnCubit, DesvincularFiadorHnState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == Status.done) {
          Navigator.of(context).pop(state.mensaje);
        }
      },
      builder: (context, state) {
        final enviando = state.status == Status.inProgress;
        return PopScope(
          canPop: !enviando,
          child: Dialog(
            backgroundColor: RedesignColors.surface,
            insetPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '¿Desvincular fiador?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: RedesignColors.ink,
                      ),
                    ),
                    const Gap(6),
                    Text(
                      'El fiador deja de estar vinculado a la solicitud '
                      '${widget.numeroSolicitud}.',
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.35,
                        color: RedesignColors.inkMuted,
                      ),
                    ),
                    const Gap(16),
                    InfoRowWidget(
                      icon: Icons.person_2_outlined,
                      color: RedesignColors.indigo,
                      background: RedesignColors.indigoTint,
                      label: 'Fiador',
                      value: widget.fiador.nombreCompleto,
                    ),
                    const Gap(8),
                    InfoRowWidget(
                      icon: Icons.badge_outlined,
                      color: RedesignColors.teal,
                      background: RedesignColors.tealTint,
                      label: 'Cédula',
                      value: widget.fiador.fiador.cedula,
                    ),
                    const Gap(16),
                    TextFormField(
                      controller: _motivoController,
                      enabled: !enviando,
                      minLines: 3,
                      maxLines: 5,
                      maxLength: DesvincularFiadorDialog.motivoMaximo,
                      textCapitalization: TextCapitalization.sentences,
                      validator: _validarMotivo,
                      decoration: InputDecoration(
                        labelText: 'Motivo',
                        hintText: 'Escribe por qué se desvincula el fiador',
                        alignLabelWithHint: true,
                        filled: true,
                        fillColor: RedesignColors.background,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: RedesignColors.border),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: RedesignColors.border),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: RedesignColors.ink),
                        ),
                      ),
                    ),
                    if (state.status == Status.error) ...[
                      const Gap(8),
                      _ErrorMensaje(texto: state.errorMsg),
                    ],
                    const Gap(16),
                    _BotonDesvincular(
                      enviando: enviando,
                      onPressed: _desvincular,
                    ),
                    const Gap(8),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed:
                            enviando ? null : () => Navigator.of(context).pop(),
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _BotonDesvincular extends StatelessWidget {
  final bool enviando;
  final VoidCallback onPressed;

  const _BotonDesvincular({required this.enviando, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        // Sin `null` al enviar: el botón conserva el rojo y solo ignora toques.
        onPressed: enviando ? () {} : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: RedesignColors.red,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: enviando
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Text(
                'Desvincular',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }
}

class _ErrorMensaje extends StatelessWidget {
  final String texto;

  const _ErrorMensaje({required this.texto});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: RedesignColors.redTint,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        texto.isEmpty ? 'No se pudo desvincular el fiador' : texto,
        style: const TextStyle(
          fontSize: 13,
          height: 1.35,
          color: RedesignColors.red,
        ),
      ),
    );
  }
}
