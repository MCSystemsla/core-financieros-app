import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/analisis_list_data_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/borrador_sin_numero/ofrecer_borrador_sin_numero_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/borrador_sin_numero/sin_numero_notice_widget.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/imagenes_negocio/imagenes_negocio_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/plan_inversion/plan_inversion_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/ubicacion_cliente/ubicacion_cliente_offline_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/analisis_solicitudes_interceptor.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/analisis_solicitudes_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/fiadores/fiadores_ni_pendientes_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/selectable_card/selectable_card_item.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/card_tag_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/module_icon_tile.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

/// Análisis offline de Nicaragua. Lista las solicitudes asignadas que guardó
/// el sync de NI (`SolicitudCatalogoCubit.guardarAnalisisAsignadosNi`).
class AnalisisSolicitudesNiOfflineScreen extends StatefulWidget {
  const AnalisisSolicitudesNiOfflineScreen({super.key});

  @override
  State<AnalisisSolicitudesNiOfflineScreen> createState() =>
      _AnalisisSolicitudesNiOfflineScreenState();
}

class _AnalisisSolicitudesNiOfflineScreenState
    extends State<AnalisisSolicitudesNiOfflineScreen> {
  List<AnalisisListDataHn> data = [];
  List<_SolicitudSinNumeroNi> sinNumero = [];
  @override
  void initState() {
    data = global<AnalisisBoxServiceHn>().analisisListDataHnBox.getAll();
    sinNumero = _getSolicitudesSinNumeroNi(data);
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
                    'Las solicitudes descargadas en el teléfono. Podés registrar el análisis, las imágenes, la ubicación, el plan de inversión y los fiadores sin conexión.',
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

/// Solicitud NI creada offline que todavía no tiene número (SPEC 08). NI no
/// tiene grupales, así que la llave es siempre cédula + tipo base.
class _SolicitudSinNumeroNi {
  final String uuid;
  final String cedula;
  final String tipoSolicitud;
  final double monto;
  final String nombreCompleto;

  const _SolicitudSinNumeroNi({
    required this.uuid,
    required this.cedula,
    required this.tipoSolicitud,
    required this.monto,
    required this.nombreCompleto,
  });

  String get llave => _llaveNi(cedula: cedula, tipoSolicitud: tipoSolicitud);

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
      esGrupal: false,
    );
    return '${borrador.numeroProvisional}';
  }
}

String _llaveNi({required String cedula, required String? tipoSolicitud}) =>
    '${AnalisisBoxServiceHn.normalizarCedula(cedula)}|$tipoSolicitud';

String _unirNombre(List<String?> partes) =>
    partes.where((e) => e != null && e.trim().isNotEmpty).join(' ').trim();

/// Solicitudes NI locales terminadas (nueva, asalariado, represtamo) y
/// borradores sin número cuya solicitud local ya se borró. Se ocultan las que
/// ya tienen su AUT en [aut] con la misma cédula y tipo.
List<_SolicitudSinNumeroNi> _getSolicitudesSinNumeroNi(
  List<AnalisisListDataHn> aut,
) {
  final solicitudesDb = global<ObjectBoxService>();
  final llavesAut = aut
      .map((e) => _llaveNi(
            cedula: e.cedulaCliente ?? '',
            tipoSolicitud: e.tipoSolicitud,
          ))
      .toSet();

  final locales = <_SolicitudSinNumeroNi>[
    ...solicitudesDb.getSolicitudesResponse().where((e) => e.isDone).map(
          (e) => _SolicitudSinNumeroNi(
            uuid: e.uuid ?? '',
            cedula: e.cedula ?? '',
            tipoSolicitud: 'NUEVAMENOR',
            monto: (e.monto ?? 0).toDouble(),
            nombreCompleto:
                _unirNombre([e.nombre1, e.nombre2, e.apellido1, e.apellido2]),
          ),
        ),
    ...solicitudesDb
        .getSolicitudesAsalariadoResponse()
        .where((e) => e.isDone)
        .map(
          (e) => _SolicitudSinNumeroNi(
            uuid: e.uuid ?? '',
            cedula: e.cedula ?? '',
            tipoSolicitud: 'ASALARIADO',
            monto: e.monto ?? 0,
            nombreCompleto:
                _unirNombre([e.nombre1, e.nombre2, e.apellido1, e.apellido2]),
          ),
        ),
    ...solicitudesDb
        .getSolicitudesReprestamoResponse()
        .where((e) => e.isDone)
        .map(
          (e) => _SolicitudSinNumeroNi(
            uuid: e.uuid ?? '',
            cedula: e.cedula ?? '',
            tipoSolicitud: 'REPRESTAMO',
            monto: (e.monto ?? 0).toDouble(),
            nombreCompleto: _unirNombre([e.nombreCompletoCliente]),
          ),
        ),
  ];

  final porLlave = <String, _SolicitudSinNumeroNi>{};
  for (final solicitud in locales) {
    if (solicitud.cedula.isEmpty) continue;
    porLlave.putIfAbsent(solicitud.llave, () => solicitud);
  }

  final borradores = global<AnalisisBoxServiceHn>()
      .getBorradoresSinNumero(userId: LocalStorage().userId);
  for (final borrador in borradores) {
    // NI no tiene grupales; un borrador grupal solo puede venir de HN.
    if (borrador.esGrupal) continue;
    final huerfano = _SolicitudSinNumeroNi(
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

class _ListDataWidget extends StatelessWidget {
  final List<AnalisisListDataHn> data;
  final List<_SolicitudSinNumeroNi> sinNumero;
  const _ListDataWidget({required this.data, this.sinNumero = const []});

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
            return _AnalisisCreditoOfflineNiCard(
              index: index,
              numeroSolicitud: '',
              nombreCompleto: solicitud.nombreVisible,
              monto: solicitud.monto.toString(),
              cedulaCliente: solicitud.cedula,
              tipoSolicitud: solicitud.tipoSolicitud,
              crearBorrador: solicitud.crearBorrador,
            );
          }
          final analisis = data[index];
          return _AnalisisCreditoOfflineNiCard(
            index: index,
            numeroSolicitud: analisis.numero ?? '',
            nombreCompleto: analisis.nombreCompleto ?? 'N/A',
            monto: analisis.monto ?? '0',
            cedulaCliente: analisis.cedulaCliente ?? '',
            tipoSolicitud: analisis.tipoSolicitud ?? '',
          );
        },
      ),
    );
  }
}

class _AnalisisCreditoOfflineNiCard extends StatelessWidget {
  final int index;
  final String numeroSolicitud;
  final String nombreCompleto;
  final String monto;
  final String cedulaCliente;
  final String tipoSolicitud;

  /// Solo para solicitudes sin número: busca o crea el borrador y devuelve el
  /// número provisional con el que se abre el sheet (SPEC 08).
  final String Function()? crearBorrador;
  const _AnalisisCreditoOfflineNiCard({
    required this.index,
    required this.numeroSolicitud,
    required this.nombreCompleto,
    required this.monto,
    required this.cedulaCliente,
    required this.tipoSolicitud,
    this.crearBorrador,
  });

  static const _staggerGroupSize = 8;

  bool get _sinNumero => crearBorrador != null;

  Future<void> _openSheet(BuildContext context) async {
    // Filas del sync: datos capturados offline sin número para este cliente.
    if (!_sinNumero) {
      await ofrecerBorradorSinNumeroHn(
        context,
        cedula: cedulaCliente,
        tipoSolicitud: tipoSolicitud,
        monto: monto,
        numeroSolicitud: numeroSolicitud,
        esGrupal: false,
      );
      if (!context.mounted) return;
    }
    final numero = crearBorrador?.call() ?? numeroSolicitud;
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => _SelectTypeAnalisisOfflineNi(
        index: index,
        numeroSolicitud: numero,
        nombreCompleto: nombreCompleto,
        monto: monto,
        cedulaCliente: cedulaCliente,
        tipoSolicitud: tipoSolicitud,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      from: 16,
      duration: const Duration(milliseconds: 320),
      delay: Duration(milliseconds: 40 * (index % _staggerGroupSize)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Material(
          color: RedesignColors.surface,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            onTap: () => _openSheet(context),
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
                          nombreCompleto,
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
                              label: monto.toCurrencyString(),
                              color: RedesignColors.green,
                              background: RedesignColors.greenTint,
                            ),
                            if (tipoSolicitud.isNotEmpty)
                              CardTagWidget(
                                label: tipoSolicitud,
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
                  const Gap(10),
                  const Icon(
                    Icons.chevron_right_rounded,
                    size: 20,
                    color: RedesignColors.chevron,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Sheet offline de NI: las mismas opciones que el sheet offline de HN
/// (análisis, imágenes y ubicación, con las pantallas compartidas) más
/// fiadores, que se guardan en el teléfono y se envían después desde
/// `FiadoresNiPendientesScreen`.
class _SelectTypeAnalisisOfflineNi extends StatelessWidget {
  final int index;
  final String numeroSolicitud;
  final String nombreCompleto;
  final String monto;
  final String cedulaCliente;
  final String tipoSolicitud;
  const _SelectTypeAnalisisOfflineNi({
    required this.index,
    required this.numeroSolicitud,
    required this.nombreCompleto,
    required this.monto,
    required this.cedulaCliente,
    required this.tipoSolicitud,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      decoration: const BoxDecoration(
        color: Color(0xfff9fafb),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            SelectableCardItem(
              icon: Icons.dashboard_customize_rounded,
              color: const Color(0xff1554F6),
              title: 'Registrar Analisis',
              subtitle: 'Crear analisis de crédito',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // Tipo de formulario con el getTipoSolicitud de NI
                    // (umbral 1000), no el de HN, que lee MENORMIL.
                    builder: (_) => AnalisisSolicitudesInterceptor(
                      index: index,
                      type: getTipoSolicitud(
                        tipoSolicitud: tipoSolicitud,
                        monto: monto,
                      ),
                      title: 'Número Solicitud: '
                          '${numeroSolicitudLabel(int.tryParse(numeroSolicitud) ?? 0, prefijo: '')} '
                          '$tipoSolicitud',
                      subtitle: nombreCompleto,
                      description: monto.toCurrencyString(),
                      numeroSolicitud: numeroSolicitud,
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
                    builder: (_) => ImagenesNegocioHnScreen(
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
                    builder: (_) => UbicacionClienteOfflineHnScreen(
                      numeroSolicitud: numeroSolicitud,
                    ),
                  ),
                );
              },
            ),
            // Borrador en el teléfono; se envía a mano con conexión.
            SelectableCardItem(
              icon: Icons.business_center_outlined,
              color: const Color(0xffF6153F),
              title: 'Registrar Plan de inversión',
              subtitle: 'Crear plan de inversion',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PlanInversionScreen(
                      numeroSolicitud: int.parse(numeroSolicitud),
                    ),
                  ),
                );
              },
            ),
            SelectableCardItem(
              icon: Icons.swap_horiz_rounded,
              color: const Color(0xff0D9488),
              title: 'Registrar Fiadores',
              subtitle: 'Se guardan en el teléfono hasta que tengas conexión',
              onTap: () {
                // Cerrar el sheet antes: la pantalla de envío cuenta las
                // rutas para volver a los pendientes.
                context.pop();
                FiadoresNiPendientesScreen.open(
                  context,
                  numeroSolicitud: int.parse(numeroSolicitud),
                );
              },
            ),
          ],
        ),
      ),
    ).fadeIn();
  }
}
