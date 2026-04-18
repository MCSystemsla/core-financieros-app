import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/grupales/grupo_activo_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

import '../../../../bloc/comite/comite_solicitudes_grupales/comite_solicitudes_grupales_cubit.dart';

class ComiteGrupalHeaderBackground extends StatelessWidget {
  final Widget child;

  const ComiteGrupalHeaderBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        gradient: LinearGradient(
          colors: [
            Color(0xFF2E7D6B),
            Color(0xFF66A182),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }
}

class ComiteGrupalHeaderContent extends StatelessWidget {
  final GrupoActivoData grupoActivoData;

  const ComiteGrupalHeaderContent({
    super.key,
    required this.grupoActivoData,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCollapsed = constraints.biggest.height < 130;

        return FlexibleSpaceBar(
          centerTitle: true,
          titlePadding: EdgeInsets.zero,
          title: _AnimatedCard(
            isCollapsed: isCollapsed,
            grupoActivoData: grupoActivoData,
          ),
        );
      },
    );
  }
}

class _AnimatedCard extends StatelessWidget {
  final bool isCollapsed;
  final GrupoActivoData grupoActivoData;

  const _AnimatedCard({
    required this.isCollapsed,
    required this.grupoActivoData,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.all(10),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: BlocBuilder<ComiteSolicitudesGrupalesCubit,
            ComiteSolicitudesGrupalesState>(
          builder: (context, state) {
            return Card(
              clipBehavior: Clip.antiAlias,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _InfoItem(
                      label: 'Grupo:',
                      value: grupoActivoData.nombreCompleto,
                      isCollapsed: isCollapsed,
                      align: CrossAxisAlignment.start,
                    ),
                    _InfoItem(
                      label: 'Miembros:',
                      value: state.data.length.toString(),
                      isCollapsed: isCollapsed,
                    ),
                    _InfoItem(
                      label: 'Total:',
                      value: 'L. ${state.montoTotalGrupo.toCurrencyString()}',
                      isCollapsed: isCollapsed,
                      align: CrossAxisAlignment.end,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isCollapsed;
  final CrossAxisAlignment align;

  const _InfoItem({
    required this.label,
    required this.value,
    required this.isCollapsed,
    this.align = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: align,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isCollapsed ? 10 : 12,
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isCollapsed ? 12 : 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
