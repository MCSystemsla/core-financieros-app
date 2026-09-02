import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/currency/currency_helper.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/analisis_list_data_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/analisis_solicitudes_interceptor.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/imagenes_negocio/imagenes_negocio_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/ubicacion_cliente/ubicacion_cliente_offline_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/analisis_solicitudes_interceptor.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/selectable_card/selectable_card_item.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/card_tag_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/module_icon_tile.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
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
  @override
  void initState() {
    final localDbProvider = global<AnalisisBoxServiceHn>();
    data = localDbProvider.analisisListDataHnBox.getAll();
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
                    'Las solicitudes descargadas en el teléfono. Podés registrar el análisis, las imágenes y la ubicación sin conexión.',
                onBack: () => context.push('/'),
              ),
              const Gap(20),
              _ListDataWidget(data: data),
            ],
          ),
        ),
      ),
    );
  }
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
  const _ListDataWidget({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Expanded(
        child: EmptyListWidget(message: 'No hay solicitudes por analizar'),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: data.length,
        padding: const EdgeInsets.only(bottom: 24),
        itemBuilder: (BuildContext context, int index) {
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
  });

  static const _staggerGroupSize = 8;

  void _openAnalisisSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => _SelectTypeAnalisis(
        index: index,
        title: title,
        subtitle: subtitle,
        description: description,
        numeroSolicitud: numeroSolicitud,
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
                          const Gap(8),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: [
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
