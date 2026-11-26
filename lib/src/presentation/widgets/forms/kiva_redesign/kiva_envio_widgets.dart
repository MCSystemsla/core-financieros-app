import 'dart:io';
import 'dart:typed_data';

import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/sending_status_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

/// Envío de un formulario Kiva online desde su página de firma (rediseño
/// 2026, opción A). Lo usan las 14 páginas de firma; cada una solo aporta su
/// cubit y su guardado local.
///
/// Flujo:
/// 1. Si falta la firma, avisa y no sigue.
/// 2. [mostrarKivaConfirmarEnvio]: hoja con el resumen y "Leí y confirmé…".
/// 3. [guardarEnTelefono]: la copia local de siempre (respuestas, firma, fotos).
/// 4. Abre [KivaEnvioScreen], que envía las respuestas, luego la firma y las
///    fotos, y muestra el resultado. Sin conexión solo muestra "Guardado en el
///    teléfono".
///
/// [enviarRespuestas] debe emitir `Status.inProgress` y después `done` o
/// `error` en el cubit [formCubit] (es el `sendAnswers()` de cada cubit).
Future<void> iniciarEnvioKiva<C extends StateStreamableSource<S>, S>({
  required BuildContext context,
  required SignatureController firma,
  required TypeSigner typeSigner,
  required C formCubit,
  required Status Function(S state) estadoDe,
  required String Function(S state) errorDe,
  required VoidCallback enviarRespuestas,
  required Future<void> Function() guardarEnTelefono,
}) async {
  FocusScope.of(context).unfocus();

  if (firma.isEmpty) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Falta la firma. Firma dentro del recuadro.'),
        ),
      );
    return;
  }

  final confirmado = await mostrarKivaConfirmarEnvio(
    context,
    typeSigner: typeSigner,
  );
  if (!confirmado || !context.mounted) return;

  final conectado = context.read<InternetConnectionCubit>().state.isConnected;
  final firmaPng = await firma.toPngBytes();
  if (!context.mounted) return;

  await guardarEnTelefono();
  if (!context.mounted) return;

  final uploadCubit = context.read<UploadUserFileCubit>();
  await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider<C>.value(value: formCubit),
          BlocProvider.value(value: uploadCubit),
        ],
        child: KivaEnvioScreen<C, S>(
          sinConexion: !conectado,
          typeSigner: typeSigner,
          firmaPng: firmaPng,
          estadoDe: estadoDe,
          errorDe: errorDe,
          enviarRespuestas: enviarRespuestas,
        ),
      ),
    ),
  );
}

String _etiquetaFirma(TypeSigner typeSigner) => typeSigner == TypeSigner.asesor
    ? 'Firma del representante'
    : 'Firma del cliente';

int _cantidadFotos(UploadUserFileState state) => [
      state.imagen1,
      state.imagen2,
      state.imagen3,
    ].where((path) => path.trim().isNotEmpty).length;

String _fotosTexto(int cantidad) => cantidad == 1 ? '1 foto' : '$cantidad fotos';

/// Hoja inferior "¿Enviar el formulario a Kiva?" con el resumen de lo que se
/// envía y la casilla obligatoria "Leí y confirmé el formulario con el
/// cliente". Devuelve `true` solo con "Confirmar y enviar".
Future<bool> mostrarKivaConfirmarEnvio(
  BuildContext context, {
  required TypeSigner typeSigner,
}) async {
  final route = context.read<KivaRouteCubit>().state;
  final fotos = _cantidadFotos(context.read<UploadUserFileCubit>().state);

  final resultado = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: RedesignColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => _ConfirmarEnvioSheet(
      cliente: route.nombre,
      formulario: route.nombreFormularioKiva,
      firma: typeSigner == TypeSigner.asesor ? 'Representante' : 'Cliente',
      fotos: fotos,
    ),
  );
  return resultado == true;
}

class _ConfirmarEnvioSheet extends StatefulWidget {
  final String cliente;
  final String formulario;
  final String firma;
  final int fotos;
  const _ConfirmarEnvioSheet({
    required this.cliente,
    required this.formulario,
    required this.firma,
    required this.fotos,
  });

  @override
  State<_ConfirmarEnvioSheet> createState() => _ConfirmarEnvioSheetState();
}

class _ConfirmarEnvioSheetState extends State<_ConfirmarEnvioSheet> {
  bool _leido = false;

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    );

    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: RedesignColors.border,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const Gap(16),
            Row(
              children: [
                Container(
                  height: 52,
                  width: 52,
                  decoration: const BoxDecoration(
                    color: RedesignColors.tealTint,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.send_rounded,
                    color: RedesignColors.teal,
                    size: 24,
                  ),
                ),
                const Gap(14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '¿Enviar el formulario a Kiva?',
                        style: TextStyle(
                          fontSize: 19,
                          height: 1.2,
                          fontWeight: FontWeight.w700,
                          color: RedesignColors.ink,
                        ),
                      ),
                      Gap(4),
                      Text(
                        'Después de enviarlo no se puede editar.',
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.4,
                          color: RedesignColors.inkMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              decoration: BoxDecoration(
                color: RedesignColors.tagBackground,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: RedesignColors.border),
              ),
              child: Column(
                children: [
                  if (widget.cliente.trim().isNotEmpty)
                    _ResumenFila(etiqueta: 'Cliente', valor: widget.cliente),
                  if (widget.formulario.trim().isNotEmpty)
                    _ResumenFila(
                      etiqueta: 'Formulario',
                      valor: widget.formulario,
                    ),
                  _ResumenFila(
                    etiqueta: 'Firma',
                    valor: '${widget.firma} ✓',
                    valorColor: RedesignColors.green,
                  ),
                  _ResumenFila(
                    etiqueta: 'Fotos',
                    valor: '${widget.fotos} de 3',
                    valorColor: widget.fotos == 3
                        ? RedesignColors.green
                        : RedesignColors.amber,
                    ultima: true,
                  ),
                ],
              ),
            ),
            const Gap(14),
            Material(
              color: RedesignColors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(color: RedesignColors.border),
              ),
              clipBehavior: Clip.antiAlias,
              child: CheckboxListTile(
                value: _leido,
                onChanged: (value) => setState(() => _leido = value ?? false),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: RedesignColors.teal,
                contentPadding: const EdgeInsets.symmetric(horizontal: 6),
                title: const Text(
                  'Leí y confirmé el formulario con el cliente',
                  style: TextStyle(
                    fontSize: 13.5,
                    height: 1.35,
                    color: RedesignColors.ink,
                  ),
                ),
              ),
            ),
            const Gap(16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      foregroundColor: RedesignColors.ink,
                      side: const BorderSide(color: RedesignColors.border),
                      shape: shape,
                    ),
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Cancelar'),
                  ),
                ),
                const Gap(12),
                Expanded(
                  flex: 14,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: RedesignColors.teal,
                      disabledBackgroundColor: RedesignColors.tagBackground,
                      disabledForegroundColor: RedesignColors.inkSubtle,
                      shape: shape,
                    ),
                    onPressed:
                        _leido ? () => Navigator.of(context).pop(true) : null,
                    child: const Text('Confirmar y enviar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ResumenFila extends StatelessWidget {
  final String etiqueta;
  final String valor;
  final Color valorColor;
  final bool ultima;
  const _ResumenFila({
    required this.etiqueta,
    required this.valor,
    this.valorColor = RedesignColors.ink,
    this.ultima = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: ultima
            ? null
            : const Border(bottom: BorderSide(color: RedesignColors.border)),
      ),
      child: Row(
        children: [
          Text(
            etiqueta,
            style: const TextStyle(
              fontSize: 13,
              color: RedesignColors.inkMuted,
            ),
          ),
          const Gap(12),
          Expanded(
            child: Text(
              valor,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: valorColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum _FaseEnvio {
  respuestas,
  archivos,
  listo,
  errorRespuestas,
  errorArchivos,
  guardado,
}

/// Pantalla de envío Kiva: pasos (copia en el teléfono → respuestas → firma
/// y fotos), anillo de avance, éxito, errores con reintento y "Guardado en el
/// teléfono" sin conexión. Reemplaza los popups de awesome_dialog y
/// `KivaImageSending` en las páginas de firma. Se abre con [iniciarEnvioKiva].
class KivaEnvioScreen<C extends StateStreamableSource<S>, S>
    extends StatefulWidget {
  final bool sinConexion;
  final TypeSigner typeSigner;
  final Uint8List? firmaPng;
  final Status Function(S state) estadoDe;
  final String Function(S state) errorDe;
  final VoidCallback enviarRespuestas;

  const KivaEnvioScreen({
    super.key,
    required this.sinConexion,
    required this.typeSigner,
    required this.firmaPng,
    required this.estadoDe,
    required this.errorDe,
    required this.enviarRespuestas,
  });

  /// Límite de intentos de subida de firma y fotos (igual que antes).
  static const maxIntentosArchivos = 3;

  @override
  State<KivaEnvioScreen<C, S>> createState() => _KivaEnvioScreenState<C, S>();
}

class _KivaEnvioScreenState<C extends StateStreamableSource<S>, S>
    extends State<KivaEnvioScreen<C, S>> {
  late _FaseEnvio _fase =
      widget.sinConexion ? _FaseEnvio.guardado : _FaseEnvio.respuestas;
  String _error = '';
  String? _fotoFirma;

  @override
  void initState() {
    super.initState();
    if (!widget.sinConexion) {
      // Tras el primer frame, para que los listeners ya estén suscritos.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) widget.enviarRespuestas();
      });
    }
  }

  void _reintentarRespuestas() {
    setState(() => _fase = _FaseEnvio.respuestas);
    widget.enviarRespuestas();
  }

  Future<void> _alLlegarRespuestas() async {
    setState(() => _fase = _FaseEnvio.archivos);
    final route = context.read<KivaRouteCubit>().state;
    await context
        .read<SolicitudesPendientesLocalDbCubit>()
        .marcarFormularioEnviado(solicitudId: route.solicitudId);

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/signature.png');
    final firmaPng = widget.firmaPng;
    if (firmaPng != null) await file.writeAsBytes(firmaPng);
    _fotoFirma = file.path;

    if (!mounted) return;
    _subirArchivos();
  }

  void _subirArchivos() {
    final fotoFirma = _fotoFirma;
    if (fotoFirma == null) return;
    final route = context.read<KivaRouteCubit>().state;
    setState(() => _fase = _FaseEnvio.archivos);
    context.read<UploadUserFileCubit>().uploadUserFiles(
          typeSigner: widget.typeSigner,
          cedula: route.cedula,
          numero: route.numero,
          tipoSolicitud: route.tipoSolicitud,
          fotoFirma: fotoFirma,
          solicitudId: int.parse(route.solicitudId),
          formularioKiva: route.nombreFormularioKiva,
        );
  }

  void _irAlInicio() => context.pushReplacement('/');

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<C, S>(
          listenWhen: (previous, current) =>
              widget.estadoDe(previous) != widget.estadoDe(current),
          listener: (context, state) {
            if (_fase != _FaseEnvio.respuestas) return;
            switch (widget.estadoDe(state)) {
              case Status.done:
                _alLlegarRespuestas();
              case Status.error:
                setState(() {
                  _fase = _FaseEnvio.errorRespuestas;
                  _error = widget.errorDe(state);
                });
              default:
                break;
            }
          },
        ),
        BlocListener<UploadUserFileCubit, UploadUserFileState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (_fase != _FaseEnvio.archivos) return;
            switch (state.status) {
              case Status.done:
                context
                    .read<SolicitudesPendientesLocalDbCubit>()
                    .updateIsImagesSendedOnSolicitud(
                      solicitudId: context.read<KivaRouteCubit>().state.solicitudId,
                    );
                setState(() => _fase = _FaseEnvio.listo);
              case Status.error:
                setState(() {
                  _fase = _FaseEnvio.errorArchivos;
                  _error = state.errorMsg;
                });
              default:
                break;
            }
          },
        ),
      ],
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (didPop) return;
          // Solo se vuelve al formulario si las respuestas no llegaron.
          if (_fase == _FaseEnvio.errorRespuestas) Navigator.of(context).pop();
        },
        child: Scaffold(
          backgroundColor: RedesignColors.background,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                  child: Text(
                    _encabezado(context),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                      color: RedesignColors.inkMuted,
                    ),
                  ),
                ),
                Expanded(child: _contenido(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _encabezado(BuildContext context) {
    final formulario =
        context.read<KivaRouteCubit>().state.nombreFormularioKiva.trim();
    return formulario.isEmpty
        ? 'FORMULARIO KIVA'
        : 'KIVA · ${formulario.toUpperCase()}';
  }

  List<SendingStep> _pasos(int fotos) {
    final (int actual, bool fallo) = switch (_fase) {
      _FaseEnvio.respuestas => (1, false),
      _FaseEnvio.errorRespuestas => (1, true),
      _FaseEnvio.archivos => (2, false),
      _FaseEnvio.errorArchivos => (2, true),
      _ => (3, false),
    };
    final etiquetas = [
      'Copia guardada en el teléfono',
      'Respuestas del formulario',
      '${_etiquetaFirma(widget.typeSigner)} y ${_fotosTexto(fotos)}',
    ];
    return [
      for (int i = 0; i < etiquetas.length; i++)
        SendingStep(
          label: etiquetas[i],
          state: i < actual
              ? SendingStepState.done
              : i > actual
                  ? SendingStepState.pending
                  : fallo
                      ? SendingStepState.failed
                      : SendingStepState.active,
        ),
    ];
  }

  Widget _contenido(BuildContext context) {
    final route = context.read<KivaRouteCubit>().state;
    final upload = context.watch<UploadUserFileCubit>().state;
    final fotos = _cantidadFotos(upload);
    final pasos = _pasos(fotos);

    return switch (_fase) {
      _FaseEnvio.respuestas || _FaseEnvio.archivos => SendingStatusView(
          artTint: RedesignColors.tealTint,
          art: _AnilloAvance(
            valor: _fase == _FaseEnvio.respuestas ? 0.48 : 0.82,
            color: RedesignColors.teal,
          ),
          title: 'Enviando a Kiva',
          message: 'No cierres la app. Si se corta la conexión, el '
              'formulario ya quedó guardado en el teléfono.',
          steps: pasos,
          celebrate: false,
        ),
      _FaseEnvio.listo => SendingStatusView(
          artTint: RedesignColors.greenTint,
          art: const SendingStatusLottie(
            asset: ImageAsset.nuevaMenorSuccess,
            repeat: false,
          ),
          title: '¡Formulario enviado!',
          message: route.nombre.trim().isEmpty
              ? 'Kiva recibió las respuestas, la firma y las fotos.'
              : 'Kiva recibió las respuestas, la firma y las fotos de '
                  '${route.nombre.trim()}.',
          steps: pasos,
          label: 'NÚMERO DE SOLICITUD',
          value: route.numero,
          actions: [
            _BotonPrincipal(texto: 'Ir al inicio', onPressed: _irAlInicio),
          ],
        ),
      _FaseEnvio.errorRespuestas => SendingStatusView(
          artTint: RedesignColors.redTint,
          art: const _AnilloAvance(valor: 1 / 3, color: RedesignColors.red),
          title: 'No se pudo enviar el formulario',
          message: 'Quedó guardado en el teléfono. Puedes reintentar ahora '
              'o volver al formulario.',
          steps: pasos,
          errorDetail: _error,
          celebrate: false,
          actions: [
            _BotonPrincipal(
              texto: 'Reintentar envío',
              onPressed: _reintentarRespuestas,
            ),
            _BotonSecundario(
              texto: 'Volver al formulario',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      _FaseEnvio.errorArchivos => _errorArchivos(upload, pasos),
      _FaseEnvio.guardado => SendingStatusView(
          artTint: RedesignColors.amberTint,
          art: const Icon(
            Icons.mobile_friendly_rounded,
            size: 52,
            color: RedesignColors.amber,
          ),
          title: 'Guardado en el teléfono',
          message: 'No hay conexión. Nada se perdió: las respuestas, la '
              'firma y ${_fotosTexto(fotos)} quedaron en el teléfono. '
              'Cuando vuelvas a tener señal, en Kiva aparece como '
              '"Lista para enviar".',
          celebrate: false,
          actions: [
            _BotonPrincipal(texto: 'Entendido', onPressed: _irAlInicio),
          ],
        ),
    };
  }

  Widget _errorArchivos(UploadUserFileState upload, List<SendingStep> pasos) {
    final intento = upload.imageRetryAttempts;
    final puedeReintentar = intento < KivaEnvioScreen.maxIntentosArchivos;
    final detalle = [
      if (_error.trim().isNotEmpty) _error.trim(),
      'Intento $intento de ${KivaEnvioScreen.maxIntentosArchivos}.',
    ].join('\n');

    return SendingStatusView(
      artTint: RedesignColors.redTint,
      art: const _AnilloAvance(valor: 2 / 3, color: RedesignColors.red),
      title: 'Faltan la firma y las fotos',
      message: puedeReintentar
          ? 'Las respuestas sí llegaron a Kiva. Solo falta subir la firma '
              'y las fotos.'
          : 'Las respuestas sí llegaron a Kiva. Llegaste al límite de '
              'intentos: reenvía la firma y las fotos más tarde desde el '
              'historial Kiva.',
      steps: pasos,
      errorDetail: detalle,
      celebrate: false,
      actions: [
        if (puedeReintentar)
          _BotonPrincipal(
            texto: 'Reintentar firma y fotos',
            onPressed: _subirArchivos,
          ),
        if (puedeReintentar)
          _BotonSecundario(texto: 'Reintentar después', onPressed: _irAlInicio)
        else
          _BotonPrincipal(texto: 'Ir al inicio', onPressed: _irAlInicio),
      ],
    );
  }
}

/// Anillo de avance con el porcentaje en el centro, dentro del círculo de
/// estado de [SendingStatusView].
class _AnilloAvance extends StatelessWidget {
  final double valor;
  final Color color;
  const _AnilloAvance({required this.valor, required this.color});

  @override
  Widget build(BuildContext context) {
    final sinAnimacion = MediaQuery.of(context).disableAnimations;

    return TweenAnimationBuilder<double>(
      tween: Tween(end: valor),
      duration: sinAnimacion
          ? Duration.zero
          : const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      builder: (context, value, _) => SizedBox.square(
        dimension: 108,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: value,
              strokeWidth: 8,
              strokeCap: StrokeCap.round,
              color: color,
              backgroundColor: RedesignColors.surface,
            ),
            Center(
              child: Text(
                '${(value * 100).round()}%',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  fontFeatures: const [FontFeature.tabularFigures()],
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BotonPrincipal extends StatelessWidget {
  final String texto;
  final VoidCallback onPressed;
  const _BotonPrincipal({required this.texto, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        backgroundColor: RedesignColors.teal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      onPressed: onPressed,
      child: Text(texto),
    );
  }
}

class _BotonSecundario extends StatelessWidget {
  final String texto;
  final VoidCallback onPressed;
  const _BotonSecundario({required this.texto, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        foregroundColor: RedesignColors.ink,
        side: const BorderSide(color: RedesignColors.border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      onPressed: onPressed,
      child: Text(texto),
    );
  }
}
