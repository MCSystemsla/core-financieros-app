import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/analisis_list_data_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/analisis_solicitudes_interceptor.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/analisis_solicitudes_interceptor.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
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
    return Scaffold(
      body: PopScope(
        onPopInvokedWithResult: (pop, result) {
          context.push('/');
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Analisis de solicitudes offline'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              const Expanded(
                child: _AnalisisSolicitudesTitle(),
              ),
              _ListDataWidget(
                data: data,
              ),
              const Gap(15),
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
}) {
  final montoInt = double.tryParse(monto) ?? 0;
  final nuevaMenorMil =
      global<SolicitudesHnBoxService>().getParametroByName(nombre: 'MENORMIL');
  final nuevaMenorMilMonto = int.tryParse(nuevaMenorMil!.valor) ?? 0;

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

class _AnalisisSolicitudesTitle extends StatelessWidget {
  const _AnalisisSolicitudesTitle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Analisis de solicitudes crédito',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const Gap(10),
          Text(
            'Evaluación detallada de las solicitudes de crédito para determinar su viabilidad y cumplimiento de criterios financieros.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
          ),
        ],
      ),
    );
  }
}

class _ListDataWidget extends StatefulWidget {
  final List<AnalisisListDataHn> data;
  const _ListDataWidget({
    required this.data,
  });

  @override
  State<_ListDataWidget> createState() => _ListDataWidgetState();
}

class _ListDataWidgetState extends State<_ListDataWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      return const Expanded(
          child: EmptyListWidget(message: 'No hay solicitudes por analizar'));
    }
    return Expanded(
      flex: 4,
      child: ListView.builder(
        itemCount: widget.data.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return AnalisisCreditoOfflineCard(
            monto: widget.data[index].monto!,
            tipoPersonaCodigo: widget.data[index].tipoPersonaCodigo!,
            cedulaCliente: widget.data[index].cedulaCliente!,
            numeroSolicitud: widget.data[index].numero!,
            tipoSolicitud: getTipoSolicitud(
              tipoSolicitud: widget.data[index].tipoSolicitud!,
              monto: widget.data[index].monto!,
            ),
            index: index,
            title:
                'Número Solicitud: ${widget.data[index].numero} ${widget.data[index].tipoSolicitud}',
            subtitle: widget.data[index].nombreCompleto ?? 'N/A',
            description: widget.data[index].monto?.toCurrencyString() ?? 'N/A',
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
  });

  @override
  Widget build(BuildContext context) {
    return SlideInLeft(
      duration: animate ? const Duration(milliseconds: 500) : Duration.zero,
      delay: animate ? Duration(milliseconds: 100 * index) : Duration.zero,
      child: Hero(
        tag: 'analisis-credito-$index',
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: InkWell(
            onTap: enabled
                ? () => {
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
                          ),
                        ),
                      ),
                    }
                : null,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: Colors.indigo.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.account_balance_outlined,
                      size: 24,
                      color: Colors.indigo,
                    ),
                  ),
                  const Gap(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Gap(4),
                        Text(
                          subtitle,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                        ),
                        const Gap(4),
                        Text(
                          'L. $description',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                    size: 28,
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
