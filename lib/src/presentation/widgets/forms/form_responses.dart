import 'dart:io';

import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/section_block_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

/// Resumen de las respuestas de un formulario Kiva online, antes de la firma
/// (rediseño 2026). Muestra las fotos del cliente y cada respuesta; tocar una
/// respuesta lleva a la página del formulario donde se contestó.
class FormResponses extends StatelessWidget {
  final PageController controller;
  const FormResponses({
    super.key,
    required this.controller,
  });

  static const _duracion = Duration(milliseconds: 350);

  @override
  Widget build(BuildContext context) {
    // Record: compara por valor, así solo reconstruye si cambia una ruta.
    final (imagen1, imagen2, imagen3) =
        context.select<UploadUserFileCubit, (String, String, String)>(
      (cubit) => (
        cubit.state.imagen1,
        cubit.state.imagen2,
        cubit.state.imagen3,
      ),
    );
    final responses = context.select<ResponseCubit, List<Response>>(
      (cubit) => cubit.state.responses,
    );

    return ColoredBox(
      color: RedesignColors.background,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'input.form_response'.tr(),
                    style: const TextStyle(
                      fontSize: 22,
                      height: 1.2,
                      fontWeight: FontWeight.w700,
                      color: RedesignColors.ink,
                    ),
                  ),
                  const Gap(6),
                  const Text(
                    'Revisa las respuestas antes de firmar. '
                    'Toca una para corregirla.',
                    style: TextStyle(
                      fontSize: 13.5,
                      height: 1.4,
                      color: RedesignColors.inkMuted,
                    ),
                  ),
                ],
              ),
            ),
            SectionBlockWidget(
              label: 'FOTOS DEL CLIENTE',
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _FotoClienteTile(path: imagen1, label: 'Foto 1'),
                    ),
                    const Gap(10),
                    Expanded(
                      child: _FotoClienteTile(path: imagen2, label: 'Foto 2'),
                    ),
                    const Gap(10),
                    Expanded(
                      child: _FotoClienteTile(path: imagen3, label: 'Foto 3'),
                    ),
                  ],
                ),
              ],
            ),
            SectionBlockWidget(
              label: 'RESPUESTAS (${responses.length})',
              children: [
                for (final response in responses)
                  _ResponseWidget(
                    response: response,
                    controller: controller,
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: _AccionesResumen(
                previousTitle: 'button.previous'.tr(),
                nextTitle: 'button.signed'.tr(),
                onPreviousPressed: () => controller.previousPage(
                  duration: _duracion,
                  curve: Curves.easeIn,
                ),
                onNextPressed: () => controller.nextPage(
                  duration: _duracion,
                  curve: Curves.easeIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Miniatura de solo lectura de una foto del cliente. Sin foto, o si el
/// archivo ya no existe, muestra un espacio vacío. Al tocarla abre la foto
/// en pantalla completa ([_FotoClienteViewer]).
class _FotoClienteTile extends StatelessWidget {
  final String path;
  final String label;
  const _FotoClienteTile({required this.path, required this.label});

  void _abrir(BuildContext context, String heroTag) {
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        opaque: false,
        barrierColor: Colors.black,
        transitionDuration: const Duration(milliseconds: 250),
        reverseTransitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (_, __, ___) => _FotoClienteViewer(
          path: path,
          label: label,
          heroTag: heroTag,
        ),
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vacio = path.trim().isEmpty;
    final heroTag = 'foto-cliente-$label-$path';

    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Material(
            color: RedesignColors.tagBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: const BorderSide(color: RedesignColors.border),
            ),
            clipBehavior: Clip.antiAlias,
            child: vacio
                ? const _FotoVacia()
                : InkWell(
                    onTap: () => _abrir(context, heroTag),
                    child: Hero(
                      tag: heroTag,
                      child: Image.file(
                        File(path),
                        fit: BoxFit.cover,
                        cacheWidth: 300,
                        errorBuilder: (_, __, ___) => const _FotoVacia(),
                      ),
                    ),
                  ),
          ),
        ),
        const Gap(6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: RedesignColors.inkMuted,
          ),
        ),
      ],
    );
  }
}

class _FotoClienteViewer extends StatefulWidget {
  final String path;
  final String label;
  final String heroTag;
  const _FotoClienteViewer({
    required this.path,
    required this.label,
    required this.heroTag,
  });

  @override
  State<_FotoClienteViewer> createState() => _FotoClienteViewerState();
}

class _FotoClienteViewerState extends State<_FotoClienteViewer> {
  static const _zoomDobleToque = 2.5;

  final _transform = TransformationController();
  TapDownDetails? _dobleToque;

  @override
  void dispose() {
    _transform.dispose();
    super.dispose();
  }

  /// Doble toque: acerca donde se tocó, o vuelve al tamaño normal.
  void _onDoubleTap() {
    if (_transform.value != Matrix4.identity()) {
      _transform.value = Matrix4.identity();
      return;
    }
    final punto = _dobleToque?.localPosition;
    if (punto == null) return;
    _transform.value = Matrix4.identity()
      ..translateByDouble(
        -punto.dx * (_zoomDobleToque - 1),
        -punto.dy * (_zoomDobleToque - 1),
        0,
        1,
      )
      ..scaleByDouble(_zoomDobleToque, _zoomDobleToque, _zoomDobleToque, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onDoubleTapDown: (details) => _dobleToque = details,
                onDoubleTap: _onDoubleTap,
                child: InteractiveViewer(
                  transformationController: _transform,
                  minScale: 1,
                  maxScale: 5,
                  child: Center(
                    child: Hero(
                      tag: widget.heroTag,
                      child: Image.file(
                        File(widget.path),
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const Text(
                          'No se pudo abrir la foto',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 16, 0),
                child: Row(
                  children: [
                    IconButton(
                      tooltip: 'Cerrar',
                      onPressed: () => Navigator.of(context).maybePop(),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black45,
                      ),
                      icon:
                          const Icon(Icons.close_rounded, color: Colors.white),
                    ),
                    const Gap(8),
                    Text(
                      widget.label,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FotoVacia extends StatelessWidget {
  const _FotoVacia();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.image_not_supported_outlined,
        color: RedesignColors.chevron,
        size: 26,
      ),
    );
  }
}

/// Respuesta de solo lectura. Tocarla lleva a la página del formulario donde
/// se respondió, para corregirla allí.
class _ResponseWidget extends StatelessWidget {
  final PageController controller;
  final Response response;
  const _ResponseWidget({required this.response, required this.controller});

  static String? _normalizar(String value) {
    final texto = value.trim();
    final lower = texto.toLowerCase();
    if (texto.isEmpty || lower == 'null' || lower == 'n/a') return null;
    return switch (lower) {
      'true' => 'Sí',
      'false' => 'No',
      _ => texto,
    };
  }

  void _irAPregunta() {
    if (!controller.hasClients) return;
    controller.animateToPage(
      response.index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final valor = _normalizar(response.response);
    final pregunta =
        response.question.trim().replaceAll(RegExp(r'\s*\*+$'), '');

    return Material(
      color: RedesignColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: RedesignColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: _irAPregunta,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pregunta,
                      style: const TextStyle(
                        fontSize: 12.5,
                        height: 1.35,
                        fontWeight: FontWeight.w500,
                        color: RedesignColors.inkMuted,
                      ),
                    ),
                    const Gap(6),
                    Text(
                      valor ?? 'Sin respuesta',
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.4,
                        fontWeight:
                            valor == null ? FontWeight.w400 : FontWeight.w600,
                        fontStyle:
                            valor == null ? FontStyle.italic : FontStyle.normal,
                        color: valor == null
                            ? RedesignColors.chevron
                            : RedesignColors.ink,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(10),
              Tooltip(
                message: 'Editar respuesta',
                child: Container(
                  height: 34,
                  width: 34,
                  decoration: BoxDecoration(
                    color: RedesignColors.tealTint,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.edit_outlined,
                    size: 18,
                    color: RedesignColors.teal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Botones "Anterior" / "Firmar" al final del resumen.
class _AccionesResumen extends StatelessWidget {
  final String previousTitle;
  final String nextTitle;
  final VoidCallback onPreviousPressed;
  final VoidCallback onNextPressed;
  const _AccionesResumen({
    required this.previousTitle,
    required this.nextTitle,
    required this.onPreviousPressed,
    required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    );

    return SafeArea(
      top: false,
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                foregroundColor: RedesignColors.ink,
                side: const BorderSide(color: RedesignColors.border),
                shape: shape,
              ),
              onPressed: onPreviousPressed,
              child: Text(previousTitle),
            ),
          ),
          const Gap(12),
          Expanded(
            child: FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: RedesignColors.teal,
                shape: shape,
              ),
              onPressed: onNextPressed,
              child: Text(nextTitle),
            ),
          ),
        ],
      ),
    );
  }
}
