import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/estado_credito/estado_credito.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/search_bar/search_bar.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/card_tag_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/module_icon_tile.dart';
import 'package:core_financiero_app/src/utils/extensions/filter_estados_credito/filter_estado_credito.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../bloc/solicitudes/hn/cubit/solicitudes_by_estado_hn/solicitudes_by_estado_hn_cubit.dart';

class AnalisisFilterContentWidget extends StatefulWidget {
  final EstadoCredito estadoCredito;
  final bool isAsignadaToAsesorCredito;
  final FilterEstadosCredito filterEstadosCredito;

  const AnalisisFilterContentWidget({
    super.key,
    required this.estadoCredito,
    this.isAsignadaToAsesorCredito = true,
    this.filterEstadosCredito = FilterEstadosCredito.all,
  });

  @override
  State<AnalisisFilterContentWidget> createState() =>
      _AnalisisFilterContentWidgetState();
}

class _AnalisisFilterContentWidgetState
    extends State<AnalisisFilterContentWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolicitudesByEstadoHnCubit, SolicitudesByEstadoHnState>(
      builder: (context, state) {
        return switch (state.status) {
          Status.done => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: SearchBarCustom(
                      onItemSelected: (s) {},
                      onPressed: () {},
                      onTap: () => showFilterGetByCedualAndNumeroSolicitud(
                        context,
                        context.read<SolicitudesByEstadoHnCubit>(),
                        estadoCredito: widget.estadoCredito,
                        isAsignadaToAsesorCredito:
                            widget.isAsignadaToAsesorCredito,
                        filterEstadosCredito: widget.filterEstadosCredito,
                      ),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: FilterView(
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}

void showFilterGetByCedualAndNumeroSolicitud(
  BuildContext context,
  SolicitudesByEstadoHnCubit cubit, {
  required EstadoCredito estadoCredito,
  required bool isAsignadaToAsesorCredito,
  required FilterEstadosCredito filterEstadosCredito,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: RedesignColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) => _FilterModal(
      cubit: cubit,
      estadoCredito: estadoCredito,
      isAsignadaToAsesorCredito: isAsignadaToAsesorCredito,
      filterEstadosCredito: filterEstadosCredito,
    ),
  );
}

class _FilterModal extends StatefulWidget {
  final SolicitudesByEstadoHnCubit cubit;
  final EstadoCredito estadoCredito;
  final bool isAsignadaToAsesorCredito;
  final FilterEstadosCredito filterEstadosCredito;

  const _FilterModal({
    required this.cubit,
    required this.estadoCredito,
    required this.isAsignadaToAsesorCredito,
    required this.filterEstadosCredito,
  });

  @override
  State<_FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<_FilterModal> {
  final formKey = GlobalKey<FormState>();

  void _limpiar() {
    widget.cubit.cleanState();
    widget.cubit.getSolicitudesByEstado(
      estadoCredito: widget.estadoCredito,
      isAsignadaToAsesorCredito: widget.isAsignadaToAsesorCredito,
      filterEstadosCredito: widget.filterEstadosCredito,
    );
    Navigator.pop(context);
  }

  void _aplicar(SolicitudesByEstadoHnState state) {
    if (!formKey.currentState!.validate()) return;

    widget.cubit.onFieldChanged(() => state.copyWith(
          numeroSolicitud:
              state.isNumeroSolicitudFilter ? state.numeroSolicitud : null,
          cedulaCliente:
              state.isCedulaSolicitudFilter ? state.cedulaCliente : null,
          nombreCompleto:
              state.isNombreCompletoFilter ? state.nombreCompleto : '',
        ));

    widget.cubit.getSolicitudesByEstado(
      estadoCredito: widget.estadoCredito,
      isAsignadaToAsesorCredito: widget.isAsignadaToAsesorCredito,
      filterEstadosCredito: widget.filterEstadosCredito,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final alto = MediaQuery.sizeOf(context).height * 0.9;

    return BlocProvider.value(
      value: widget.cubit,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: alto),
        child: Padding(
          padding: EdgeInsets.only(bottom: bottomInset),
          child: SafeArea(
            top: false,
            child: BlocBuilder<SolicitudesByEstadoHnCubit,
                SolicitudesByEstadoHnState>(
              builder: (context, state) {
                final activos = [
                  state.isNumeroSolicitudFilter,
                  state.isCedulaSolicitudFilter,
                  state.isNombreCompletoFilter,
                ].where((activo) => activo).length;

                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        const Gap(18),
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Buscar solicitudes',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.4,
                                  color: RedesignColors.ink,
                                ),
                              ),
                            ),
                            if (activos > 0)
                              CardTagWidget(
                                label: activos == 1
                                    ? '1 filtro activo'
                                    : '$activos filtros activos',
                                color: RedesignColors.teal,
                                background: RedesignColors.tealTint,
                              ),
                          ],
                        ),
                        const Gap(4),
                        const Text(
                          'Activa uno o más filtros y combínalos para encontrar '
                          'la solicitud.',
                          style: TextStyle(
                            fontSize: 13,
                            color: RedesignColors.inkMuted,
                          ),
                        ),
                        const Gap(18),
                        _FiltroCard(
                          icon: Icons.tag_rounded,
                          color: RedesignColors.indigo,
                          background: RedesignColors.indigoTint,
                          titulo: 'Número de solicitud',
                          subtitulo: 'Busca una solicitud exacta',
                          activo: state.isNumeroSolicitudFilter,
                          onActivoChanged: (val) => widget.cubit.onFieldChanged(
                              () =>
                                  state.copyWith(isNumeroSolicitudFilter: val)),
                          campo: _FiltroTextField(
                            initialValue: state.numeroSolicitud,
                            hintText: 'Ej: 2321',
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (val) => widget.cubit.onFieldChanged(
                                () => state.copyWith(numeroSolicitud: val)),
                          ),
                        ),
                        const Gap(10),
                        _FiltroCard(
                          icon: Icons.badge_outlined,
                          color: RedesignColors.teal,
                          background: RedesignColors.tealTint,
                          titulo: 'Cédula del cliente',
                          subtitulo: 'Número de identidad completo',
                          activo: state.isCedulaSolicitudFilter,
                          onActivoChanged: (val) => widget.cubit.onFieldChanged(
                              () =>
                                  state.copyWith(isCedulaSolicitudFilter: val)),
                          campo: _FiltroTextField(
                            initialValue: state.cedulaCliente,
                            hintText: 'Ej: 0809199901218T',
                            inputFormatters: [UpperCaseTextFormatter()],
                            onChanged: (val) => widget.cubit.onFieldChanged(
                                () => state.copyWith(cedulaCliente: val)),
                          ),
                        ),
                        const Gap(10),
                        _FiltroCard(
                          icon: Icons.person_outline_rounded,
                          color: RedesignColors.purple,
                          background: RedesignColors.purpleTint,
                          titulo: 'Nombre del cliente',
                          subtitulo: 'Nombre o apellido',
                          activo: state.isNombreCompletoFilter,
                          onActivoChanged: (val) => widget.cubit.onFieldChanged(
                              () =>
                                  state.copyWith(isNombreCompletoFilter: val)),
                          campo: _FiltroTextField(
                            initialValue: state.nombreCompleto,
                            hintText: 'Ej: BRYAN GODOY',
                            keyboardType: TextInputType.name,
                            inputFormatters: [UpperCaseTextFormatter()],
                            onChanged: (val) => widget.cubit.onFieldChanged(
                                () => state.copyWith(nombreCompleto: val)),
                          ),
                        ),
                        const Gap(22),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: RedesignColors.red,
                                  side: const BorderSide(
                                    color: RedesignColors.border,
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                onPressed: _limpiar,
                                icon: const Icon(
                                  Icons.filter_alt_off_outlined,
                                  size: 18,
                                ),
                                label: const Text('Limpiar'),
                              ),
                            ),
                            const Gap(10),
                            Expanded(
                              flex: 2,
                              child: FilledButton.icon(
                                style: FilledButton.styleFrom(
                                  backgroundColor: RedesignColors.teal,
                                  disabledBackgroundColor:
                                      RedesignColors.tagBackground,
                                  disabledForegroundColor:
                                      RedesignColors.chevron,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                onPressed:
                                    activos > 0 ? () => _aplicar(state) : null,
                                icon:
                                    const Icon(Icons.search_rounded, size: 18),
                                label: const Text('Aplicar filtros'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

/// Tarjeta de un filtro: ícono, título, switch y, cuando está activo, el
/// campo de texto debajo.
class _FiltroCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color background;
  final String titulo;
  final String subtitulo;
  final bool activo;
  final ValueChanged<bool> onActivoChanged;
  final Widget campo;

  const _FiltroCard({
    required this.icon,
    required this.color,
    required this.background,
    required this.titulo,
    required this.subtitulo,
    required this.activo,
    required this.onActivoChanged,
    required this.campo,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: RedesignColors.surface,
        border: Border.all(
          color: activo ? color.withValues(alpha: 0.45) : RedesignColors.border,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            InkWell(
              onTap: () => onActivoChanged(!activo),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 8, 12),
                child: Row(
                  children: [
                    ModuleIconTile(
                      icon: icon,
                      color: color,
                      background: background,
                      size: 38,
                    ),
                    const Gap(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            titulo,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: RedesignColors.ink,
                            ),
                          ),
                          const Gap(2),
                          Text(
                            subtitulo,
                            style: const TextStyle(
                              fontSize: 12,
                              color: RedesignColors.inkMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch.adaptive(
                      value: activo,
                      activeTrackColor: RedesignColors.teal,
                      onChanged: onActivoChanged,
                    ),
                  ],
                ),
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              alignment: Alignment.topCenter,
              child: activo
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                      child: campo,
                    )
                  : const SizedBox(width: double.infinity),
            ),
          ],
        ),
      ),
    );
  }
}

class _FiltroTextField extends StatelessWidget {
  final String initialValue;
  final String hintText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final ValueChanged<String> onChanged;

  const _FiltroTextField({
    required this.initialValue,
    required this.hintText,
    required this.inputFormatters,
    required this.onChanged,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder borde(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: color, width: width),
        );

    return TextFormField(
      initialValue: initialValue,
      autofocus: initialValue.isEmpty,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      textInputAction: TextInputAction.done,
      onChanged: onChanged,
      validator: (value) => ClassValidator.validateRequired(value),
      style: const TextStyle(fontSize: 15, color: RedesignColors.ink),
      cursorColor: RedesignColors.teal,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: RedesignColors.background,
        hintText: hintText,
        hintStyle: const TextStyle(color: RedesignColors.chevron),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: borde(RedesignColors.border),
        enabledBorder: borde(RedesignColors.border),
        focusedBorder: borde(RedesignColors.teal, 1.5),
        errorBorder: borde(RedesignColors.red),
        focusedErrorBorder: borde(RedesignColors.red, 1.5),
        errorStyle: const TextStyle(color: RedesignColors.red),
      ),
    );
  }
}
