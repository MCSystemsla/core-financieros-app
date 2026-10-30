import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/currency/currency_helper.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/analisis_list_data_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart';
import 'package:core_financiero_app/src/datasource/flavor/flavor.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/analisis_solicitudes_interceptor.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/fiadores/fiadores_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/imagenes_negocio/imagenes_negocio_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/plan_inversion/plan_inversion_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/ubicacion_cliente/ubicacion_cliente_offline_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/analisis_solicitudes_interceptor.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/selectable_card/selectable_card_item.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/card_tag_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/module_icon_tile.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/type_form/type_form_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AnalisisSolicitudesHnOfflineScreen extends StatefulWidget {
  const AnalisisSolicitudesHnOfflineScreen({super.key});

  @override
  State<AnalisisSolicitudesHnOfflineScreen> createState() =>
      _AnalisisSolicitudesHnOfflineScreenState();
}

class _AnalisisSolicitudesHnOfflineScreenState
    extends State<AnalisisSolicitudesHnOfflineScreen> {
  List<AnalisisListDataHn> data = [];
  List<_SolicitudSinNumero> sinNumero = [];
  @override
  void initState() {
    final localDbProvider = global<AnalisisBoxServiceHn>();
    data = localDbProvider.analisisListDataHnBox.getAll();
    if (_isHonduras) sinNumero = _getSolicitudesSinNumero(data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (pop, result) {
        context.push('/');
      },
      child: Scaffold(
        backgroundColor: RedesignColors.background,
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenHeaderWidget(
                title: 'Análisis offline',
                subtitle:
                    'Las solicitudes descargadas en el teléfono. Podés registrar el análisis, las imágenes, plan de inversion, la ubicación y los fiadores sin conexión.',
                onBack: () => context.push('/'),
              ),
              const Gap(20),
              _ListDataWidget(data: data, sinNumero: sinNumero),
            ],
          ),
        ),
      ),
    );
  }
}

/// Costa Rica también abre esta pantalla; el plan de inversión offline es solo
/// de Honduras.
bool get _isHonduras => global<FlavorCubit>().state.flavor == Flavor.honduras;

/// Solicitud creada offline que todavía no tiene número (SPEC 06).
class _SolicitudSinNumero {
  final String uuid;
  final String cedula;
  final String tipoSolicitud;
  final double monto;
  final String nombreCompleto;

  const _SolicitudSinNumero({
    required this.uuid,
    required this.cedula,
    required this.tipoSolicitud,
    required this.monto,
    required this.nombreCompleto,
  });

  String get llave =>
      '${AnalisisBoxServiceHn.normalizarCedula(cedula)}|$tipoSolicitud';

  String get nombreVisible => nombreCompleto.isEmpty ? cedula : nombreCompleto;

  /// Busca o crea el borrador y devuelve su número provisional.
  String crearBorrador() {
    final borrador =
        global<AnalisisBoxServiceHn>().getOrCreateBorradorSinNumero(
      solicitudLocalUuid: uuid,
      userId: LocalStorage().userId,
      cedula: cedula,
      tipoSolicitud: tipoSolicitud,
      monto: monto,
      nombreCompleto: nombreVisible,
    );
    return '${borrador.numeroProvisional}';
  }
}

String _unirNombre(List<String?> partes) {
  final nombre =
      partes.where((e) => e != null && e.trim().isNotEmpty).join(' ').trim();
  return nombre;
}

/// Solicitudes locales terminadas (nueva, asalariado, represtamo) y borradores
/// sin número cuya solicitud local ya se borró. Se ocultan las que ya tienen
/// una AUT con la misma cédula y tipo en [aut].
List<_SolicitudSinNumero> _getSolicitudesSinNumero(
  List<AnalisisListDataHn> aut,
) {
  final solicitudesDb = global<SolicitudesHnBoxService>();
  final llavesAut = aut
      .map((e) =>
          '${AnalisisBoxServiceHn.normalizarCedula(e.cedulaCliente ?? '')}|${e.tipoSolicitud}')
      .toSet();

  final locales = <_SolicitudSinNumero>[
    ...solicitudesDb.getSolicitudesNueva().where((e) => e.isDone).map(
          (e) => _SolicitudSinNumero(
            uuid: e.uuid ?? '',
            cedula: e.cedula ?? '',
            tipoSolicitud: 'NUEVAMENOR',
            monto: (e.monto ?? 0).toDouble(),
            nombreCompleto:
                _unirNombre([e.nombre1, e.nombre2, e.apellido1, e.apellido2]),
          ),
        ),
    ...solicitudesDb.getSolicitudesAsalariado().where((e) => e.isDone).map(
          (e) => _SolicitudSinNumero(
            uuid: e.uuid ?? '',
            cedula: e.cedula ?? '',
            tipoSolicitud: 'ASALARIADO',
            monto: (e.monto ?? 0).toDouble(),
            nombreCompleto:
                _unirNombre([e.nombre1, e.nombre2, e.apellido1, e.apellido2]),
          ),
        ),
    ...solicitudesDb.getSolicitudesReprestamo().where((e) => e.isDone).map(
          (e) => _SolicitudSinNumero(
            uuid: e.uuid ?? '',
            cedula: e.cedula ?? '',
            tipoSolicitud: 'REPRESTAMO',
            monto: e.monto ?? 0,
            nombreCompleto:
                _unirNombre([e.nombreCompletoCliente ?? e.nombreCompleto]),
          ),
        ),
  ];

  final porLlave = <String, _SolicitudSinNumero>{};
  for (final solicitud in locales) {
    if (solicitud.cedula.isEmpty) continue;
    porLlave.putIfAbsent(solicitud.llave, () => solicitud);
  }

  final borradores = global<AnalisisBoxServiceHn>()
      .getBorradoresSinNumero(userId: LocalStorage().userId);
  for (final borrador in borradores) {
    final huerfano = _SolicitudSinNumero(
      uuid: borrador.solicitudLocalUuid,
      cedula: borrador.cedula,
      tipoSolicitud: borrador.tipoSolicitud,
      monto: borrador.monto,
      nombreCompleto: borrador.nombreCompleto,
    );
    porLlave.putIfAbsent(huerfano.llave, () => huerfano);
  }

  return porLlave.values.where((e) => !llavesAut.contains(e.llave)).toList();
}

AnalisisSolicitudesInterceptorType getTipoSolicitud({
  required String tipoSolicitud,
  required String monto,
  required bool esGrupal,
}) {
  final montoInt = double.tryParse(monto) ?? 0;
  final nuevaMenorMil =
      global<SolicitudesHnBoxService>().getParametroByName(nombre: 'MENORMIL');
  final nuevaMenorMilMonto = int.tryParse(nuevaMenorMil!.valor) ?? 0;
  if (esGrupal) {
    return AnalisisSolicitudesInterceptorType.grupal;
  }
  switch (tipoSolicitud) {
    case 'NUEVAMENOR':
      return montoInt >= nuevaMenorMilMonto
          ? AnalisisSolicitudesInterceptorType.nuevaMayorAMil
          : AnalisisSolicitudesInterceptorType.nueva;

    case 'REPRESTAMO':
      return montoInt >= nuevaMenorMilMonto
          ? AnalisisSolicitudesInterceptorType.represtamoMayorAMil
          : AnalisisSolicitudesInterceptorType.represtamo;

    case 'ASALARIADO':
      return AnalisisSolicitudesInterceptorType.asalariado;

    default:
      return AnalisisSolicitudesInterceptorType.nueva;
  }
}

class _ListDataWidget extends StatelessWidget {
  final List<AnalisisListDataHn> data;
  final List<_SolicitudSinNumero> sinNumero;
  const _ListDataWidget({
    required this.data,
    this.sinNumero = const [],
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty && sinNumero.isEmpty) {
      return const Expanded(
        child: EmptyListWidget(message: 'No hay solicitudes por analizar'),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: data.length + sinNumero.length,
        padding: const EdgeInsets.only(bottom: 24),
        itemBuilder: (BuildContext context, int index) {
          if (index >= data.length) {
            final solicitud = sinNumero[index - data.length];
            final monto = solicitud.monto.toString();
            return AnalisisCreditoOfflineCard(
              monto: monto,
              cedulaCliente: solicitud.cedula,
              numeroSolicitud: '',
              crearBorrador: solicitud.crearBorrador,
              tipoSolicitud: getTipoSolicitud(
                tipoSolicitud: solicitud.tipoSolicitud,
                monto: monto,
                esGrupal: false,
              ),
              tipoSolicitudString: solicitud.tipoSolicitud,
              index: index,
              title: 'Sin número ${solicitud.tipoSolicitud}',
              subtitle: solicitud.nombreVisible,
              description: monto.toCurrencyString(),
            );
          }
          final analisis = data[index];
          return AnalisisCreditoOfflineCard(
            monto: analisis.monto!,
            tipoPersonaCodigo: analisis.tipoPersonaCodigo!,
            cedulaCliente: analisis.cedulaCliente!,
            numeroSolicitud: analisis.numero!,
            tipoSolicitud: getTipoSolicitud(
              tipoSolicitud: analisis.tipoSolicitud!,
              monto: analisis.monto!,
              esGrupal: analisis.esSolicitudGrupal,
            ),
            tipoSolicitudString: analisis.tipoSolicitud ?? '',
            index: index,
            title:
                'Número Solicitud: ${analisis.numero} ${analisis.tipoSolicitud}',
            subtitle: analisis.nombreCompleto ?? 'N/A',
            description: analisis.monto?.toCurrencyString() ?? 'N/A',
          );
        },
      ),
    );
  }
}

class AnalisisCreditoOfflineCard extends StatelessWidget {
  final int index;
  final bool animate;
  final bool enabled;
  final String title;
  final String subtitle;
  final String description;
  final String numeroSolicitud;
  final AnalisisSolicitudesInterceptorType? tipoSolicitud;
  final String cedulaCliente;
  final String tipoPersonaCodigo;
  final String monto;
  final String tipoSolicitudString;

  /// Solo para solicitudes sin número: busca o crea el borrador y devuelve el
  /// número provisional con el que se abre el sheet.
  final String Function()? crearBorrador;
  const AnalisisCreditoOfflineCard({
    super.key,
    required this.index,
    this.animate = true,
    this.enabled = true,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.numeroSolicitud,
    this.tipoSolicitud,
    this.cedulaCliente = '',
    this.tipoPersonaCodigo = '',
    this.monto = '0',
    this.tipoSolicitudString = '',
    this.crearBorrador,
  });

  static const _staggerGroupSize = 8;

  bool get _sinNumero => crearBorrador != null;

  void _openAnalisisSheet(BuildContext context) {
    final numero = crearBorrador?.call() ?? numeroSolicitud;
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => _SelectTypeAnalisis(
        index: index,
        title: title,
        subtitle: subtitle,
        description: description,
        numeroSolicitud: numero,
        cedulaCliente: cedulaCliente,
        tipoPersonaCodigo: tipoPersonaCodigo,
        monto: monto,
        tipoSolicitud: tipoSolicitud,
        tipoSolicitudString: tipoSolicitudString,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      from: 16,
      duration: animate ? const Duration(milliseconds: 320) : Duration.zero,
      delay: animate
          ? Duration(milliseconds: 40 * (index % _staggerGroupSize))
          : Duration.zero,
      child: Hero(
        tag: 'analisis-credito-$index',
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Material(
            color: RedesignColors.surface,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              onTap: enabled ? () => _openAnalisisSheet(context) : null,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: RedesignColors.border),
                ),
                child: Row(
                  children: [
                    const ModuleIconTile(
                      icon: Icons.account_balance_outlined,
                      color: RedesignColors.indigo,
                      background: RedesignColors.indigoTint,
                    ),
                    const Gap(13),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            subtitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.15,
                              color: RedesignColors.ink,
                            ),
                          ),
                          if (!_sinNumero) ...[
                            const Gap(3),
                            Text(
                              'Solicitud N. $numeroSolicitud',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                height: 1.35,
                                color: RedesignColors.inkMuted,
                              ),
                            ),
                          ],
                          const Gap(8),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: [
                              if (_sinNumero)
                                const CardTagWidget(
                                  label: 'Sin número',
                                  color: RedesignColors.indigo,
                                  background: RedesignColors.indigoTint,
                                ),
                              CardTagWidget(
                                label:
                                    '${CurrencyHelper.currencyPrefix()} $description',
                                color: RedesignColors.green,
                                background: RedesignColors.greenTint,
                              ),
                              if (tipoSolicitudString.isNotEmpty)
                                CardTagWidget(
                                  label: tipoSolicitudString,
                                  color: RedesignColors.teal,
                                  background: RedesignColors.tealTint,
                                ),
                              const CardTagWidget(
                                label: 'En el teléfono',
                                color: RedesignColors.amber,
                                background: RedesignColors.amberTint,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (enabled) ...[
                      const Gap(10),
                      const Icon(
                        Icons.chevron_right_rounded,
                        size: 20,
                        color: RedesignColors.chevron,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectTypeAnalisis extends StatelessWidget {
  final int index;
  final String title;
  final String subtitle;
  final String description;
  final String numeroSolicitud;
  final AnalisisSolicitudesInterceptorType? tipoSolicitud;
  final String cedulaCliente;
  final String tipoPersonaCodigo;
  final String monto;
  final String tipoSolicitudString;
  const _SelectTypeAnalisis({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.numeroSolicitud,
    this.tipoSolicitud,
    this.cedulaCliente = '',
    this.tipoPersonaCodigo = '',
    this.monto = '0',
    this.tipoSolicitudString = '',
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.45,
      maxChildSize: 0.75,
      expand: false,
      builder: (_, controller) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: const BoxDecoration(
            color: Color(0xfff9fafb),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(28),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x1F000000),
                blurRadius: 25,
                offset: Offset(0, -3),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: 42,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const Gap(18),
              Expanded(
                child: ListView(
                  controller: controller,
                  children: [
                    SelectableCardItem(
                      icon: Icons.dashboard_customize_rounded,
                      color: const Color(0xff1554F6),
                      title: 'Registrar Analisis',
                      subtitle: 'Crear analisis de crédito',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AnalisisSolicitudesInterceptorHN(
                              index: index,
                              type: tipoSolicitud!,
                              title: title,
                              subtitle: subtitle,
                              description: description,
                              numeroSolicitud: numeroSolicitud,
                              tipoSolicitudString: tipoSolicitudString,
                            ),
                          ),
                        );
                      },
                    ),
                    if (_isHonduras)
                      SelectableCardItem(
                        icon: Icons.business_center_outlined,
                        color: const Color(0xffF6153F),
                        title: 'Registrar Plan de inversión',
                        subtitle: 'Crear plan de inversion',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => PlanInversionScreen(
                                numeroSolicitud: int.parse(numeroSolicitud),
                              ),
                            ),
                          );
                        },
                      ),
                    // Como en el sheet online: las solicitudes grupales no
                    // llevan fiadores.
                    if (_isHonduras &&
                        tipoSolicitud != null &&
                        tipoSolicitud !=
                            AnalisisSolicitudesInterceptorType.grupal)
                      SelectableCardItem(
                        icon: Icons.swap_horiz_rounded,
                        color: const Color(0xff0D9488),
                        title: 'Registrar Fiadores',
                        subtitle: 'Crear Terceros',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => FiadoresHnScreen(
                                numeroSolicitud: int.parse(numeroSolicitud),
                                tipoSolicitud: tipoSolicitud!
                                    .toTypeForInterceptorString(),
                              ),
                            ),
                          );
                        },
                      ),
                    SelectableCardItem(
                      icon: Icons.photo_library_outlined,
                      color: const Color(0xff455A64),
                      title: 'Registrar Imágenes del negocio',
                      subtitle: 'Ingresa fotografías del negocio',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => ImagenesNegocioHnScreen(
                              numeroSolicitud: numeroSolicitud,
                              cedulaCliente: cedulaCliente,
                              isOfflineMode: true,
                            ),
                          ),
                        );
                      },
                    ),
                    SelectableCardItem(
                      icon: Icons.location_on_rounded,
                      color: Colors.pink,
                      title: 'Registrar Ubicacion',
                      subtitle: 'Ingresa ubicacion del cliente',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => UbicacionClienteOfflineHnScreen(
                              numeroSolicitud: numeroSolicitud,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ).fadeIn();
      },
    );
  }
}
