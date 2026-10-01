import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/snackbar/custom_snackbar.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/services/geolocation/geolocation_service.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/ubicacion_cliente/ubicacion_cliente_hn_local_db.dart';
import 'package:core_financiero_app/src/presentation/bloc/geolocation/geolocation_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/geolocation_permission/geolocation_permission_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/section_block_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class UbicacionClienteOfflineHnScreen extends StatelessWidget {
  final String numeroSolicitud;
  const UbicacionClienteOfflineHnScreen({
    super.key,
    required this.numeroSolicitud,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => GeolocationCubit(
        GeolocationService(),
      )..getCurrentLocation(),
      child: Scaffold(
        backgroundColor: RedesignColors.background,
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenHeaderWidget(
                title: 'Ubicación del cliente',
                subtitle: 'Solicitud #$numeroSolicitud',
                onBack: () => Navigator.of(context).pop(),
              ),
              const Gap(18),
              Expanded(
                child: BlocBuilder<GeolocationCubit, GeolocationState>(
                  builder: (context, state) {
                    return switch (state) {
                      OnGeolocationLoading() => const LoadingWidget(),
                      OnGeolocationPermissionDenied() =>
                        GeolocationPermissionWidget(
                          title: 'Debes permitir el acceso a la ubicación.',
                          onPressed: () {
                            context
                                .read<GeolocationCubit>()
                                .getCurrentLocation();
                          },
                        ),
                      OnGeolocationServiceDisabled() =>
                        GeolocationPermissionWidget(
                          title:
                              'El servicio de ubicación no está habilitado en tu dispositivo.',
                          onPressed: () => openAppSettings(),
                        ),
                      OnGeolocationServiceError() => OnErrorWidget(
                          onPressed: () {
                            context
                                .read<GeolocationCubit>()
                                .getCurrentLocation();
                          },
                          errorMsg: state.errorMsg,
                        ),
                      OnGeolocationSuccess() => UbicacionGpsFormCard(
                          position: state.position,
                          numeroSolicitud: numeroSolicitud,
                        ),
                      _ => const SizedBox.shrink(),
                    };
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UbicacionGpsFormCard extends StatefulWidget {
  final Position? position;
  final String numeroSolicitud;
  const UbicacionGpsFormCard({
    super.key,
    this.position,
    required this.numeroSolicitud,
  });

  @override
  State<UbicacionGpsFormCard> createState() => _UbicacionGpsFormCardState();
}

class _UbicacionGpsFormCardState extends State<UbicacionGpsFormCard> {
  final _formKey = GlobalKey<FormState>();
  final _localDbProvider = global<AnalisisBoxServiceHn>();

  String? tipoUbicacionCodigo;
  String? referenciaAdicional;
  String? tipoUbicacionNombre;

  final _scrollController = ScrollController();

  // Cambia en cada guardado para reconstruir los campos vacíos.
  int _formVersion = 0;

  // Id de la última ubicación guardada, para animar solo su entrada.
  int? _lastAddedId;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToPendientes() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOutCubic,
      );
    });
  }

  void _onSave() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    final ubicacionCliente = UbicacionClienteHnLocalDb(
      latitude: widget.position?.latitude,
      longitude: widget.position?.longitude,
      tipoUbicacionCodigo: tipoUbicacionCodigo,
      numeroSolicitud: widget.numeroSolicitud,
      referenciaAdicional: referenciaAdicional,
      tipoUbicacionNombre: tipoUbicacionNombre,
      createdAt: DateTime.now(),
    );
    final isSaved = _localDbProvider.saveUbicacionCliente(
      ubicacionCliente: ubicacionCliente,
    );
    if (!isSaved) {
      showV2CustomSnackbar(
        context,
        title: 'No se pudo guardar la ubicación',
        message: 'Intenta nuevamente',
        type: SnackbarType.error,
      );
      return;
    }
    showV2CustomSnackbar(
      context,
      title: 'Ubicación guardada exitosamente',
      message: 'Podrás enviar la ubicación cuando estés en modo online',
      type: SnackbarType.success,
    );
    setState(() {
      tipoUbicacionCodigo = null;
      tipoUbicacionNombre = null;
      referenciaAdicional = null;
      _formVersion++;
      _lastAddedId = ubicacionCliente.id;
    });
    _scrollToPendientes();
  }

  // Se llama cuando la animación de salida del item ya terminó.
  void _onDeleted(UbicacionClienteHnLocalDb item) {
    setState(() {
      _localDbProvider.deleteUbicacionClienteById(item.id);
      if (_lastAddedId == item.id) _lastAddedId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ubicacionesGuardadas =
        _localDbProvider.getAllClientesUbicacionesByNumeroSolicitud(
      widget.numeroSolicitud,
    );

    return Column(
      children: [
        Expanded(
          child: Form(
            key: _formKey,
            child: ListView(
              controller: _scrollController,
              padding: EdgeInsets.zero,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 22),
                  child: _OfflineNoticeWidget(),
                ),
                SectionBlockWidget(
                  label: 'UBICACIÓN ACTUAL',
                  children: [
                    _GpsPositionCard(position: widget.position),
                  ],
                ),
                SectionBlockWidget(
                  label: 'DATOS DE LA UBICACIÓN',
                  children: [
                    Container(
                      key: ValueKey(_formVersion),
                      padding: const EdgeInsets.fromLTRB(4, 14, 4, 14),
                      decoration: BoxDecoration(
                        color: RedesignColors.surface,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: RedesignColors.border),
                      ),
                      child: Column(
                        children: [
                          SearchDropdownWidget(
                            codigo: 'UBICACIONGPS',
                            title: 'Tipo de ubicación',
                            validator: (value) =>
                                ClassValidator.validateRequired(value?.value),
                            onChanged: (v) {
                              if (v == null) return;
                              tipoUbicacionCodigo = v.value;
                              tipoUbicacionNombre = v.name;
                            },
                          ),
                          const Gap(12),
                          OutlineTextfieldWidget(
                            title: 'Referencia adicional',
                            validator: (value) =>
                                ClassValidator.validateRequired(value),
                            textInputType: TextInputType.text,
                            textCapitalization: TextCapitalization.characters,
                            icon: const Icon(
                              Icons.edit_location_alt_outlined,
                              color: RedesignColors.teal,
                            ),
                            inputFormatters: [
                              UpperCaseTextFormatter(),
                            ],
                            hintText: 'Ej: Casa color verde frente a pulpería',
                            onChange: (value) {
                              referenciaAdicional = value;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SectionBlockWidget(
                  label: 'PENDIENTES DE ENVÍO · ${ubicacionesGuardadas.length}',
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) => FadeTransition(
                        opacity: animation,
                        child: SizeTransition(
                          sizeFactor: animation,
                          axisAlignment: -1,
                          child: child,
                        ),
                      ),
                      child: ubicacionesGuardadas.isEmpty
                          ? const _EmptyUbicacionesWidget(
                              key: ValueKey('empty'),
                            )
                          : Column(
                              key: const ValueKey('list'),
                              children: [
                                for (final item in ubicacionesGuardadas)
                                  _AnimatedPendienteItem(
                                    key: ValueKey(item.id),
                                    ubicacion: item,
                                    animateIn: item.id == _lastAddedId,
                                    onDeleted: () => _onDeleted(item),
                                  ),
                              ],
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        _SaveButtonBar(onPressed: _onSave),
      ],
    );
  }
}

class _OfflineNoticeWidget extends StatelessWidget {
  const _OfflineNoticeWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: RedesignColors.amberTint,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.cloud_off_rounded,
            size: 20,
            color: RedesignColors.amber,
          ),
          Gap(10),
          Expanded(
            child: Text(
              'Estás registrando sin conexión. La ubicación se guarda en el '
              'dispositivo y podrás enviarla cuando vuelvas a estar en línea.',
              style: TextStyle(
                fontSize: 12.5,
                height: 1.4,
                color: RedesignColors.amber,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GpsPositionCard extends StatelessWidget {
  final Position? position;
  const _GpsPositionCard({required this.position});

  @override
  Widget build(BuildContext context) {
    final accuracy = position?.accuracy;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: RedesignColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: RedesignColors.border),
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: RedesignColors.tealTint,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.my_location_rounded,
              color: RedesignColors.teal,
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${position?.latitude.toStringAsFixed(6)}, '
                  '${position?.longitude.toStringAsFixed(6)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: RedesignColors.ink,
                  ),
                ),
                const Gap(4),
                Row(
                  children: [
                    Container(
                      height: 7,
                      width: 7,
                      decoration: const BoxDecoration(
                        color: RedesignColors.onlineDot,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Gap(6),
                    Text(
                      accuracy == null
                          ? 'Señal GPS obtenida'
                          : 'Precisión ±${accuracy.toStringAsFixed(0)} m',
                      style: const TextStyle(
                        fontSize: 12,
                        color: RedesignColors.inkMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Actualizar ubicación',
            onPressed: () =>
                context.read<GeolocationCubit>().getCurrentLocation(),
            style: IconButton.styleFrom(
              backgroundColor: RedesignColors.tagBackground,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(
              Icons.refresh_rounded,
              size: 20,
              color: RedesignColors.ink,
            ),
          ),
        ],
      ),
    );
  }
}

/// Envuelve el tile con la animación de entrada (al guardar) y de salida
/// (al eliminar). El borrado en la base se hace al terminar la salida.
class _AnimatedPendienteItem extends StatefulWidget {
  final UbicacionClienteHnLocalDb ubicacion;
  final bool animateIn;
  final VoidCallback onDeleted;
  const _AnimatedPendienteItem({
    super.key,
    required this.ubicacion,
    required this.animateIn,
    required this.onDeleted,
  });

  @override
  State<_AnimatedPendienteItem> createState() => _AnimatedPendienteItemState();
}

class _AnimatedPendienteItemState extends State<_AnimatedPendienteItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _size;
  late final Animation<Offset> _slide;
  late final Animation<Color?> _highlight;
  bool _isRemoving = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
      value: widget.animateIn ? 0 : 1,
    );
    _size = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
    _slide = Tween<Offset>(
      begin: const Offset(0.25, 0),
      end: Offset.zero,
    ).animate(_size);
    // El tile nuevo arranca resaltado en verde y se aclara hasta el blanco.
    _highlight = ColorTween(
      begin: RedesignColors.greenTint,
      end: RedesignColors.surface,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1, curve: Curves.easeOut),
      ),
    );
    if (widget.animateIn) _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onDelete() async {
    if (_isRemoving) return;
    setState(() => _isRemoving = true);
    await _controller.reverse();
    if (mounted) widget.onDeleted();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _size,
      axisAlignment: -1,
      child: FadeTransition(
        opacity: _size,
        child: SlideTransition(
          position: _slide,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: AnimatedBuilder(
              animation: _highlight,
              builder: (_, __) => _UbicacionPendienteTile(
                ubicacion: widget.ubicacion,
                backgroundColor: _isRemoving
                    ? RedesignColors.redTint
                    : _highlight.value ?? RedesignColors.surface,
                onDelete: _onDelete,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _UbicacionPendienteTile extends StatelessWidget {
  final UbicacionClienteHnLocalDb ubicacion;
  final VoidCallback onDelete;
  final Color backgroundColor;
  const _UbicacionPendienteTile({
    required this.ubicacion,
    required this.onDelete,
    this.backgroundColor = RedesignColors.surface,
  });

  String _formatHora(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    final createdAt = ubicacion.createdAt;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: RedesignColors.border),
      ),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: RedesignColors.greenTint,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.location_on_rounded,
              size: 20,
              color: RedesignColors.green,
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ubicacion.tipoUbicacionNombre ?? '-',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: RedesignColors.ink,
                  ),
                ),
                const Gap(2),
                Text(
                  ubicacion.referenciaAdicional ?? 'Sin referencia adicional',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: RedesignColors.inkMuted,
                  ),
                ),
                const Gap(4),
                Text(
                  [
                    '${ubicacion.latitude?.toStringAsFixed(5)}, '
                        '${ubicacion.longitude?.toStringAsFixed(5)}',
                    if (createdAt != null) _formatHora(createdAt),
                  ].join(' · '),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: RedesignColors.chevron,
                  ),
                ),
              ],
            ),
          ),
          const Gap(8),
          IconButton(
            onPressed: onDelete,
            tooltip: 'Eliminar',
            style: IconButton.styleFrom(
              backgroundColor: RedesignColors.redTint,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
              ),
            ),
            icon: const Icon(
              Icons.delete_outline_rounded,
              size: 18,
              color: RedesignColors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyUbicacionesWidget extends StatelessWidget {
  const _EmptyUbicacionesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
      decoration: BoxDecoration(
        color: RedesignColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: RedesignColors.border),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.wrong_location_outlined,
            size: 28,
            color: RedesignColors.chevron,
          ),
          Gap(8),
          Text(
            'Aún no has guardado ubicaciones para esta solicitud',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.5,
              color: RedesignColors.inkMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _SaveButtonBar extends StatelessWidget {
  final VoidCallback onPressed;
  const _SaveButtonBar({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: RedesignColors.surface,
        border: Border(top: BorderSide(color: RedesignColors.border)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: RedesignColors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: onPressed,
            icon: const Icon(
              Icons.save_alt_rounded,
              color: Colors.white,
            ),
            label: const Text(
              'Guardar en el dispositivo',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
