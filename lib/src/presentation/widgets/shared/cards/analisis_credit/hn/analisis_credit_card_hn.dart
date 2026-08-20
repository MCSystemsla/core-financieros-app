// ignore_for_file: deprecated_member_use

import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/cerrar_analisis/cerrar_analisis_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/analisis_solicitudes_interceptor.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/modal_sheet/select_type_analisis_modal_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AnalisisCreditCardHn extends StatelessWidget {
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
  final bool esGrupal;
  final int? cicloGrupoId;
  const AnalisisCreditCardHn({
    super.key,
    required this.index,
    this.animate = true,
    this.enabled = true,
    required this.title,
    required this.subtitle,
    required this.description,
    this.tipoSolicitud,
    required this.numeroSolicitud,
    this.cedulaCliente = '',
    this.tipoPersonaCodigo = '',
    this.monto = '0',
    this.tipoSolicitudString = '',
    this.esGrupal = false,
    this.cicloGrupoId,
  });

  @override
  Widget build(BuildContext context) {
    return FadeIn(
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
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (ctx) => BlocProvider.value(
                          value: context.read<CerrarAnalisisCubit>(),
                          child: SelectTypeAnalisisModalSheetWidget(
                            index: index,
                            animate: false,
                            enabled: true,
                            numeroSolicitud: numeroSolicitud,
                            tipoSolicitud: tipoSolicitud,
                            title: title,
                            subtitle: subtitle,
                            description: description,
                            cedulaCliente: cedulaCliente,
                            tipoPersonaCodigo: tipoPersonaCodigo,
                            monto: monto,
                            tipoSolicitudString: tipoSolicitudString,
                            esGrupal: esGrupal,
                            cicloGrupoId: cicloGrupoId,
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
                      color: Colors.indigo.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: esGrupal
                        ? const Icon(
                            Icons.group_sharp,
                            size: 24,
                            color: Colors.indigo,
                          )
                        : const Icon(
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
