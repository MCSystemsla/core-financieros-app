import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:core_financiero_app/src/config/helpers/android_version/android_version.dart';
import 'package:core_financiero_app/src/config/services/camera/calidad_foto.dart';
import 'package:core_financiero_app/src/config/services/camera/camera_service.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:permission_handler/permission_handler.dart';

/// Cámara a pantalla completa (rediseño 2026) con dos modos:
///
/// - Visor: guías de encuadre, cuadrícula opcional, toque para enfocar,
///   zoom con pellizco o con los botones 1×/2×, flash y disparador.
/// - Revisión: la foto en grande con una revisión automática de luz y
///   nitidez ([CalidadFoto]) y los botones "Repetir" / "Usar foto".
///
/// Al confirmar llama a [onImageSelected] con la foto y la ruta donde la
/// guardó [CameraService.takeAndsavePhoto], y cierra la pantalla. Se abre con
/// `context.pushTransparentRoute(CameraCaptureScreen(...))`.
class CameraCaptureScreen extends StatefulWidget {
  final void Function(XFile? image, String? path) onImageSelected;
  final String numeroSoicitud;

  /// Título de la barra superior.
  final String titulo;

  /// Indicación opcional sobre el visor (qué encuadrar).
  final String? instruccion;

  const CameraCaptureScreen({
    super.key,
    required this.onImageSelected,
    required this.numeroSoicitud,
    this.titulo = 'Tomar foto',
    this.instruccion,
  });

  @override
  State<CameraCaptureScreen> createState() => _CameraCaptureScreenState();
}

/// Fondo de los paneles oscuros de la cámara.
const _panelOscuro = Color(0xFF15181A);

class _CameraCaptureScreenState extends State<CameraCaptureScreen>
    with WidgetsBindingObserver {
  CameraController? _controller;
  String? _errorCamara;
  bool _capturando = false;
  bool _flashActivo = false;
  bool _cuadricula = false;
  bool _destello = false;
  bool _mostrarInstruccion = true;
  Timer? _timerInstruccion;

  double _zoomMin = 1;
  double _zoomMax = 1;
  double _zoom = 1;
  double _zoomBase = 1;

  XFile? _foto;
  String? _fotoPath;

  /// Punto de enfoque tocado, en coordenadas del visor, para el indicador.
  Offset? _puntoEnfoque;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _inicializarCamara();
    _programarOcultarInstruccion();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timerInstruccion?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  void _programarOcultarInstruccion() {
    _timerInstruccion?.cancel();
    _timerInstruccion = Timer(const Duration(seconds: 5), () {
      if (mounted) setState(() => _mostrarInstruccion = false);
    });
  }

  /// La cámara se libera al pasar la app a segundo plano y se vuelve a abrir
  /// al regresar. Se usa `paused` y no `inactive`: el diálogo de permisos
  /// pone la app en `inactive` justo antes de disparar.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final controller = _controller;
    if (state == AppLifecycleState.paused) {
      if (controller == null || !controller.value.isInitialized) return;
      _controller = null;
      if (mounted) setState(() {});
      controller.dispose();
    } else if (state == AppLifecycleState.resumed && controller == null) {
      _inicializarCamara();
    }
  }

  Future<void> _inicializarCamara() async {
    setState(() => _errorCamara = null);
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        throw CameraException('NoCamera', 'No se encontró ninguna cámara.');
      }
      final backCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      final controller = CameraController(
        backCamera,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
      await controller.initialize();
      await controller.lockCaptureOrientation(DeviceOrientation.portraitUp);
      await controller
          .setFlashMode(_flashActivo ? FlashMode.always : FlashMode.off);
      await controller.setFocusMode(FocusMode.auto);

      var zoomMin = 1.0;
      var zoomMax = 1.0;
      try {
        zoomMin = await controller.getMinZoomLevel();
        // Más de 8× en un teléfono solo da fotos ruidosas.
        zoomMax = math.min(await controller.getMaxZoomLevel(), 8);
      } catch (_) {
        // Sin zoom en este equipo.
      }

      if (!mounted) {
        await controller.dispose();
        return;
      }
      setState(() {
        _controller = controller;
        _zoomMin = zoomMin;
        _zoomMax = math.max(zoomMin, zoomMax);
        _zoom = zoomMin;
      });
    } on CameraException catch (e) {
      if (!mounted) return;
      setState(() => _errorCamara = _mensajeErrorCamara(e));
    } catch (e) {
      if (!mounted) return;
      setState(() => _errorCamara = 'No se pudo abrir la cámara: $e');
    }
  }

  String _mensajeErrorCamara(CameraException e) => switch (e.code) {
        'CameraAccessDenied' ||
        'CameraAccessDeniedWithoutPrompt' ||
        'CameraAccessRestricted' =>
          'La app no tiene permiso para usar la cámara. Actívalo en los '
              'ajustes del teléfono.',
        _ => 'No se pudo abrir la cámara: ${e.description ?? e.code}',
      };

  Future<bool> _solicitarPermisos() async {
    final androidVersion = await AndroidVersionHelper.getAndroidVersion();
    final pideAlmacenamiento = androidVersion != null && androidVersion >= 30;

    final permisos = await [
      Permission.camera,
      if (pideAlmacenamiento) Permission.manageExternalStorage,
    ].request();

    final camara = permisos[Permission.camera]?.isGranted ?? false;
    final almacenamiento = pideAlmacenamiento
        ? (permisos[Permission.manageExternalStorage]?.isGranted ?? false)
        : true;
    return camara && almacenamiento;
  }

  Future<void> _tomarFoto() async {
    if (_controller == null || _capturando) return;

    setState(() => _capturando = true);
    final tienePermisos = await _solicitarPermisos();
    if (!mounted) return;
    if (!tienePermisos) {
      setState(() => _capturando = false);
      _mostrarSinPermisos();
      return;
    }
    // Se vuelve a leer: pudo reabrirse mientras se pedían permisos.
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) {
      setState(() => _capturando = false);
      return;
    }

    HapticFeedback.mediumImpact();
    setState(() => _destello = true);
    try {
      final (savedPath, photo) = await CameraService.takeAndsavePhoto(
        controller: controller,
        numeroSoicitud: widget.numeroSoicitud,
        orientation: CameraDeviceOrientation.portrait,
      );
      if (!mounted) return;
      setState(() {
        _foto = photo;
        _fotoPath = savedPath;
        _puntoEnfoque = null;
      });
    } on CameraException catch (e) {
      _mostrarError('No se pudo tomar la foto: ${e.description ?? e.code}');
    } on PlatformException catch (e) {
      _mostrarError('No se pudo tomar la foto: ${e.message}');
    } catch (e) {
      _mostrarError('No se pudo tomar la foto: $e');
    } finally {
      if (mounted) {
        setState(() {
          _capturando = false;
          _destello = false;
        });
      }
    }
  }

  void _mostrarError(String mensaje) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(mensaje)));
  }

  void _mostrarSinPermisos() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('La app no tiene permiso para guardar fotos.'),
          action: SnackBarAction(
            label: 'Ajustes',
            onPressed: openAppSettings,
          ),
        ),
      );
  }

  Future<void> _cambiarFlash() async {
    final controller = _controller;
    if (controller == null) return;
    HapticFeedback.selectionClick();
    final activo = !_flashActivo;
    setState(() => _flashActivo = activo);
    try {
      await controller.setFlashMode(activo ? FlashMode.always : FlashMode.off);
    } catch (_) {
      if (mounted) setState(() => _flashActivo = !activo);
      _mostrarError('Este teléfono no permite cambiar el flash.');
    }
  }

  void _cambiarCuadricula() {
    HapticFeedback.selectionClick();
    setState(() => _cuadricula = !_cuadricula);
  }

  Future<void> _enfocar(
      TapUpDetails details, BoxConstraints constraints) async {
    final controller = _controller;
    if (controller == null || !controller.value.focusPointSupported) return;
    final punto = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    HapticFeedback.selectionClick();
    setState(() => _puntoEnfoque = details.localPosition);
    try {
      await controller.setFocusPoint(punto);
      if (controller.value.exposurePointSupported) {
        await controller.setExposurePoint(punto);
      }
    } catch (_) {
      // Algunos equipos reportan soporte y fallan: se ignora.
    }
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (mounted) setState(() => _puntoEnfoque = null);
  }

  Future<void> _aplicarZoom(double zoom) async {
    final controller = _controller;
    if (controller == null) return;
    final valor = zoom.clamp(_zoomMin, _zoomMax);
    if ((valor - _zoom).abs() < 0.01) return;
    setState(() => _zoom = valor);
    try {
      await controller.setZoomLevel(valor);
    } catch (_) {
      // Se ignora: el visor queda con el último zoom aplicado.
    }
  }

  void _repetir() {
    setState(() {
      _foto = null;
      _fotoPath = null;
    });
  }

  void _usarFoto() {
    HapticFeedback.lightImpact();
    widget.onImageSelected(_foto, _fotoPath);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final fotoPath = _fotoPath;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 280),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          child: fotoPath != null
              ? _RevisionFoto(
                  key: ValueKey(fotoPath),
                  path: fotoPath,
                  onRepetir: _repetir,
                  onUsar: _usarFoto,
                )
              : _buildVisor(),
        ),
      ),
    );
  }

  Widget _buildVisor() {
    final controller = _controller;
    final listo = controller != null && controller.value.isInitialized;
    final numero = widget.numeroSoicitud.trim();
    final subtitulo =
        numero.isEmpty || numero == '0' ? null : 'Solicitud N. $numero';

    return Column(
      key: const ValueKey('visor'),
      children: [
        _BarraSuperior(
          titulo: widget.titulo,
          subtitulo: subtitulo,
          onCerrar: () => Navigator.of(context).maybePop(),
          trailing: _BotonRedondo(
            icon:
                _flashActivo ? Icons.flash_on_rounded : Icons.flash_off_rounded,
            tooltip: _flashActivo ? 'Apagar flash' : 'Encender flash',
            activo: _flashActivo,
            colorActivo: RedesignColors.amber,
            onPressed: listo ? _cambiarFlash : null,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Center(
                    child: switch ((controller, _errorCamara)) {
                      (_, final String error) => _ErrorCamara(
                          mensaje: error,
                          onReintentar: _inicializarCamara,
                        ),
                      (final CameraController c, _)
                          when c.value.isInitialized =>
                        _buildPreview(c),
                      _ => const _CargandoCamara(),
                    },
                  ),
                ),
                // Indicación para encuadrar; se oculta sola a los 5 s.
                Positioned(
                  top: 12,
                  left: 24,
                  right: 24,
                  child: IgnorePointer(
                    child: AnimatedOpacity(
                      opacity: _mostrarInstruccion && listo ? 1 : 0,
                      duration: const Duration(milliseconds: 400),
                      child: Center(
                        child: _Pastilla(
                          icon: Icons.center_focus_strong_rounded,
                          texto: widget.instruccion ??
                              'Encuadra dentro de las esquinas y toca para '
                                  'enfocar',
                        ),
                      ),
                    ),
                  ),
                ),
                // Destello blanco al disparar.
                Positioned.fill(
                  child: IgnorePointer(
                    child: AnimatedOpacity(
                      opacity: _destello ? 0.6 : 0,
                      duration: const Duration(milliseconds: 120),
                      child: const DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        _buildControles(listo),
      ],
    );
  }

  Widget _buildPreview(CameraController c) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: CameraPreview(
        c,
        child: LayoutBuilder(
          builder: (context, constraints) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapUp: (d) => _enfocar(d, constraints),
            onScaleStart: (_) => _zoomBase = _zoom,
            onScaleUpdate: (d) {
              if (d.pointerCount < 2) return;
              _aplicarZoom(_zoomBase * d.scale);
            },
            child: Stack(
              children: [
                Positioned.fill(
                  child: IgnorePointer(
                    child: CustomPaint(
                      painter: _GuiasPainter(cuadricula: _cuadricula),
                    ),
                  ),
                ),
                if (_puntoEnfoque != null)
                  Positioned(
                    left: _puntoEnfoque!.dx - 34,
                    top: _puntoEnfoque!.dy - 34,
                    child: const _IndicadorEnfoque(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildControles(bool listo) {
    final presets = <double>[
      _zoomMin,
      if (_zoomMax >= 2 && _zoomMin < 2) 2,
      if (_zoomMax >= 4) 4,
    ];
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 14, 24, 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedOpacity(
              opacity: listo && presets.length > 1 ? 1 : 0,
              duration: const Duration(milliseconds: 250),
              child: _SelectorZoom(
                presets: presets,
                zoom: _zoom,
                onSeleccion: listo
                    ? (z) {
                        HapticFeedback.selectionClick();
                        _aplicarZoom(z);
                      }
                    : null,
              ),
            ),
            const Gap(16),
            Row(
              children: [
                Expanded(
                  child: Align(
                    child: _BotonRedondo(
                      icon: Icons.grid_on_rounded,
                      tooltip: _cuadricula
                          ? 'Ocultar cuadrícula'
                          : 'Mostrar cuadrícula',
                      activo: _cuadricula,
                      size: 50,
                      onPressed: listo ? _cambiarCuadricula : null,
                    ),
                  ),
                ),
                _BotonDisparo(
                  capturando: _capturando,
                  onPressed: listo ? _tomarFoto : null,
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
            const Gap(10),
            Text(
              _capturando
                  ? 'Guardando foto…'
                  : 'Toca el botón para tomar la foto',
              style: const TextStyle(fontSize: 12, color: Colors.white60),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Revisión
// -----------------------------------------------------------------------------

/// Revisión de la foto recién tomada, con la revisión automática de luz y
/// nitidez.
class _RevisionFoto extends StatefulWidget {
  final String path;
  final VoidCallback onRepetir;
  final VoidCallback onUsar;

  const _RevisionFoto({
    super.key,
    required this.path,
    required this.onRepetir,
    required this.onUsar,
  });

  @override
  State<_RevisionFoto> createState() => _RevisionFotoState();
}

class _RevisionFotoState extends State<_RevisionFoto> {
  late final Future<CalidadFoto?> _calidad = CalidadFoto.analizar(widget.path);

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    );

    return Column(
      children: [
        _BarraSuperior(
          titulo: 'Revisa la foto',
          subtitulo: 'Pellizca para acercar',
          onCerrar: widget.onRepetir,
          iconoCerrar: Icons.arrow_back_ios_new_rounded,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.92, end: 1),
              duration: const Duration(milliseconds: 380),
              curve: Curves.easeOutBack,
              builder: (context, scale, child) =>
                  Transform.scale(scale: scale, child: child),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: InteractiveViewer(
                  maxScale: 4,
                  child: Center(
                    child: Image.file(File(widget.path), fit: BoxFit.contain),
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 14),
          decoration: const BoxDecoration(
            color: _panelOscuro,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FutureBuilder<CalidadFoto?>(
                    future: _calidad,
                    builder: (context, snapshot) => AnimatedSize(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOut,
                      child: _ResumenCalidad(
                        cargando:
                            snapshot.connectionState != ConnectionState.done,
                        calidad: snapshot.data,
                      ),
                    ),
                  ),
                  const Gap(16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(54),
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white24),
                            shape: shape,
                          ),
                          onPressed: widget.onRepetir,
                          icon: const Icon(Icons.refresh_rounded, size: 20),
                          label: const Text('Repetir'),
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: FilledButton.icon(
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(54),
                            backgroundColor: RedesignColors.teal,
                            shape: shape,
                          ),
                          onPressed: widget.onUsar,
                          icon: const Icon(Icons.check_rounded, size: 20),
                          label: const Text('Usar foto'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ResumenCalidad extends StatelessWidget {
  final bool cargando;
  final CalidadFoto? calidad;

  const _ResumenCalidad({required this.cargando, required this.calidad});

  @override
  Widget build(BuildContext context) {
    if (cargando) {
      return const Row(
        children: [
          SizedBox.square(
            dimension: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white70,
            ),
          ),
          Gap(12),
          Text(
            'Revisando la foto…',
            style: TextStyle(fontSize: 14, color: Colors.white70),
          ),
        ],
      );
    }

    final c = calidad;
    if (c == null) {
      return const Row(
        children: [
          Icon(Icons.photo_outlined, color: Colors.white70, size: 20),
          Gap(10),
          Expanded(
            child: Text(
              'Revisa que la foto se vea nítida y con buena luz.',
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
          ),
        ],
      );
    }

    final buena = c.esBuena;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color:
                    buena ? RedesignColors.greenTint : RedesignColors.amberTint,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                buena ? Icons.verified_rounded : Icons.tips_and_updates_rounded,
                color: buena ? RedesignColors.green : RedesignColors.amber,
                size: 20,
              ),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    buena ? '¡Se ve muy bien!' : 'Podría salir mejor',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    buena
                        ? 'Buena luz y enfoque.'
                        : 'Te sugerimos repetirla, pero puedes usarla.',
                    style:
                        const TextStyle(fontSize: 12.5, color: Colors.white60),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Gap(12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _ChipCalidad(
              icon: c.oscura
                  ? Icons.brightness_low_rounded
                  : c.muyClara
                      ? Icons.brightness_high_rounded
                      : Icons.wb_sunny_rounded,
              texto: c.oscura
                  ? 'Está oscura'
                  : c.muyClara
                      ? 'Demasiada luz'
                      : 'Buena luz',
              ok: c.buenaLuz,
            ),
            _ChipCalidad(
              icon: c.borrosa
                  ? Icons.blur_on_rounded
                  : Icons.center_focus_strong_rounded,
              texto: c.borrosa ? 'Posible desenfoque' : 'Nítida',
              ok: !c.borrosa,
            ),
          ],
        ),
      ],
    );
  }
}

class _ChipCalidad extends StatelessWidget {
  final IconData icon;
  final String texto;
  final bool ok;

  const _ChipCalidad({
    required this.icon,
    required this.texto,
    required this.ok,
  });

  @override
  Widget build(BuildContext context) {
    final color = ok ? RedesignColors.green : RedesignColors.amber;
    final fondo = ok ? RedesignColors.greenTint : RedesignColors.amberTint;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: fondo,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: color),
          const Gap(6),
          Text(
            texto,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Piezas compartidas
// -----------------------------------------------------------------------------

class _BarraSuperior extends StatelessWidget {
  final String titulo;
  final String? subtitulo;
  final VoidCallback onCerrar;
  final IconData iconoCerrar;
  final Widget? trailing;

  const _BarraSuperior({
    required this.titulo,
    required this.onCerrar,
    this.subtitulo,
    this.iconoCerrar = Icons.close_rounded,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: Row(
          children: [
            _BotonRedondo(
              icon: iconoCerrar,
              tooltip: 'Cerrar',
              onPressed: onCerrar,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    titulo,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.2,
                      color: Colors.white,
                    ),
                  ),
                  if (subtitulo != null) ...[
                    const Gap(2),
                    Text(
                      subtitulo!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            trailing ?? const SizedBox.square(dimension: 44),
          ],
        ),
      ),
    );
  }
}

class _BotonRedondo extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final bool activo;
  final Color colorActivo;
  final double size;

  const _BotonRedondo({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.activo = false,
    this.colorActivo = RedesignColors.ink,
    this.size = 44,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: activo ? Colors.white : Colors.white.withValues(alpha: 0.14),
        ),
        child: Material(
          type: MaterialType.transparency,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onPressed,
            child: SizedBox.square(
              dimension: size,
              child: Icon(
                icon,
                size: size * 0.45,
                color: onPressed == null
                    ? Colors.white30
                    : activo
                        ? colorActivo
                        : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Pastilla extends StatelessWidget {
  final IconData icon;
  final String texto;

  const _Pastilla({required this.icon, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.white),
          const Gap(8),
          Flexible(
            child: Text(
              texto,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12.5,
                height: 1.3,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Botones de zoom (1×, 2×, 4×). El activo muestra el zoom real, también
/// mientras se pellizca (p. ej. "1.6×").
class _SelectorZoom extends StatelessWidget {
  final List<double> presets;
  final double zoom;
  final ValueChanged<double>? onSeleccion;

  const _SelectorZoom({
    required this.presets,
    required this.zoom,
    required this.onSeleccion,
  });

  static String _formato(double z) {
    final texto = z.toStringAsFixed(1);
    return texto.endsWith('.0') ? texto.substring(0, texto.length - 2) : texto;
  }

  @override
  Widget build(BuildContext context) {
    // El activo es el mayor preset que no supera el zoom actual.
    var activo = 0;
    for (var i = 0; i < presets.length; i++) {
      if (zoom + 0.01 >= presets[i]) activo = i;
    }

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < presets.length; i++)
            GestureDetector(
              onTap:
                  onSeleccion == null ? null : () => onSeleccion!(presets[i]),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 2),
                height: 38,
                constraints: const BoxConstraints(minWidth: 38),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(19),
                  color: i == activo ? Colors.white : Colors.transparent,
                ),
                child: Text(
                  '${_formato(i == activo ? zoom : presets[i])}×',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: i == activo ? RedesignColors.ink : Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _BotonDisparo extends StatefulWidget {
  final bool capturando;
  final VoidCallback? onPressed;

  const _BotonDisparo({required this.capturando, required this.onPressed});

  @override
  State<_BotonDisparo> createState() => _BotonDisparoState();
}

class _BotonDisparoState extends State<_BotonDisparo> {
  bool _presionado = false;

  bool get _habilitado => widget.onPressed != null && !widget.capturando;

  void _presionar(bool valor) {
    if (!_habilitado && valor) return;
    setState(() => _presionado = valor);
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: _habilitado,
      label: 'Tomar foto',
      child: GestureDetector(
        onTapDown: (_) => _presionar(true),
        onTapUp: (_) => _presionar(false),
        onTapCancel: () => _presionar(false),
        onTap: _habilitado ? widget.onPressed : null,
        child: AnimatedScale(
          scale: _presionado ? 0.88 : 1,
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOut,
          child: Container(
            height: 82,
            width: 82,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: _habilitado ? Colors.white : Colors.white38,
                width: 4,
              ),
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _habilitado ? Colors.white : Colors.white24,
              ),
              child: widget.capturando
                  ? const Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(
                        strokeWidth: 2.6,
                        color: RedesignColors.teal,
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}

class _IndicadorEnfoque extends StatelessWidget {
  const _IndicadorEnfoque();

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.35, end: 1),
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutBack,
      builder: (context, scale, child) =>
          Transform.scale(scale: scale, child: child),
      child: Container(
        height: 68,
        width: 68,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFFFD54F), width: 2),
        ),
        child: const Center(
          child: Icon(Icons.add_rounded, size: 16, color: Color(0xFFFFD54F)),
        ),
      ),
    );
  }
}

/// Esquinas de encuadre siempre visibles y cuadrícula de tercios opcional.
class _GuiasPainter extends CustomPainter {
  final bool cuadricula;
  const _GuiasPainter({required this.cuadricula});

  @override
  void paint(Canvas canvas, Size size) {
    if (cuadricula) {
      final linea = Paint()
        ..color = Colors.white.withValues(alpha: 0.35)
        ..strokeWidth = 1;
      for (var i = 1; i < 3; i++) {
        final x = size.width * i / 3;
        final y = size.height * i / 3;
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), linea);
        canvas.drawLine(Offset(0, y), Offset(size.width, y), linea);
      }
    }

    final esquina = Paint()
      ..color = Colors.white.withValues(alpha: 0.9)
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    const margen = 22.0;
    const largo = 30.0;
    final r = Rect.fromLTRB(
      margen,
      margen,
      size.width - margen,
      size.height - margen,
    );
    for (final (punto, dx, dy) in [
      (r.topLeft, 1.0, 1.0),
      (r.topRight, -1.0, 1.0),
      (r.bottomLeft, 1.0, -1.0),
      (r.bottomRight, -1.0, -1.0),
    ]) {
      canvas.drawPath(
        Path()
          ..moveTo(punto.dx + dx * largo, punto.dy)
          ..lineTo(punto.dx, punto.dy)
          ..lineTo(punto.dx, punto.dy + dy * largo),
        esquina,
      );
    }
  }

  @override
  bool shouldRepaint(_GuiasPainter oldDelegate) =>
      oldDelegate.cuadricula != cuadricula;
}

class _CargandoCamara extends StatelessWidget {
  const _CargandoCamara();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.photo_camera_rounded, color: Colors.white38, size: 40),
        Gap(16),
        SizedBox(
          width: 120,
          child: LinearProgressIndicator(
            minHeight: 3,
            color: Colors.white,
            backgroundColor: Colors.white12,
          ),
        ),
        Gap(12),
        Text(
          'Abriendo la cámara…',
          style: TextStyle(fontSize: 13, color: Colors.white60),
        ),
      ],
    );
  }
}

class _ErrorCamara extends StatelessWidget {
  final String mensaje;
  final VoidCallback onReintentar;

  const _ErrorCamara({required this.mensaje, required this.onReintentar});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              Icons.no_photography_outlined,
              color: RedesignColors.red,
              size: 30,
            ),
          ),
          const Gap(18),
          const Text(
            'No pudimos abrir la cámara',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const Gap(8),
          Text(
            mensaje,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13.5,
              height: 1.45,
              color: Colors.white70,
            ),
          ),
          const Gap(20),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.white70),
                onPressed: openAppSettings,
                child: const Text('Ajustes'),
              ),
              const Gap(8),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: RedesignColors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: onReintentar,
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
