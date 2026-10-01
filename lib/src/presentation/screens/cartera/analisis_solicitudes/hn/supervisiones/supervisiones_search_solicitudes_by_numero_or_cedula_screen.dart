import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/domain/repository/supervisiones/hn/supervisiones_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/supervisiones/get_supervisiones/get_supervisiones_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/supervisiones/supervisiones_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/tipo_supervisor/tipo_supervisor_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

enum _BuscarPor { numero, cedula }

class SupervisionesSearchSolicitudesByNumeroOrCedulaScreen
    extends StatelessWidget {
  final TipoSupervisorEnum tipoSupervisor;
  const SupervisionesSearchSolicitudesByNumeroOrCedulaScreen({
    super.key,
    required this.tipoSupervisor,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => GetSupervisionesCubit(
        SupervisionesRepositoryHnImpl(),
      ),
      child: Scaffold(
        backgroundColor: RedesignColors.background,
        body: SafeArea(
          bottom: false,
          child: _UserCedulaForm(
            tipoSupervisor: tipoSupervisor,
          ),
        ),
      ),
    );
  }
}

class _UserCedulaForm extends StatefulWidget {
  final TipoSupervisorEnum tipoSupervisor;
  const _UserCedulaForm({
    required this.tipoSupervisor,
  });
  @override
  State<_UserCedulaForm> createState() => _UserCedulaFormState();
}

class _UserCedulaFormState extends State<_UserCedulaForm> {
  final formKey = GlobalKey<FormState>();
  final _valorController = TextEditingController();
  _BuscarPor _buscarPor = _BuscarPor.numero;

  @override
  void dispose() {
    _valorController.dispose();
    super.dispose();
  }

  String get _tipoSupervisorLabel => switch (widget.tipoSupervisor) {
        TipoSupervisorEnum.coordinador => 'coordinador',
        TipoSupervisorEnum.regional => 'regional',
        TipoSupervisorEnum.credito => 'crédito',
        TipoSupervisorEnum.riesgo => 'riesgo',
      };

  void _onBuscarPorChanged(_BuscarPor value) {
    if (value == _buscarPor) return;
    setState(() => _buscarPor = value);
    _valorController.clear();
  }

  void _onSubmit() {
    FocusScope.of(context).unfocus();
    if (!formKey.currentState!.validate()) return;
    final valor = _valorController.text.trim();
    final cubit = context.read<GetSupervisionesCubit>();
    switch (_buscarPor) {
      case _BuscarPor.numero:
        cubit.getSupervisionesByNumeroOrCedula(
          numeroSolicitud: int.tryParse(valor),
        );
      case _BuscarPor.cedula:
        cubit.getSupervisionesByNumeroOrCedula(cedulaIdentidad: valor);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isNumero = _buscarPor == _BuscarPor.numero;

    return BlocConsumer<GetSupervisionesCubit, GetSupervisionesState>(
      listener: (context, state) {
        if (state.status == Status.done) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => BlocProvider.value(
                value: context.read<GetSupervisionesCubit>(),
                child: SupervisionesHnScreen(
                  numeroSolicitud: _valorController.text.trim(),
                  tipoSupervisor: widget.tipoSupervisor,
                ),
              ),
            ),
          );
        }
        if (state.status == Status.error) {
          CustomAlertDialog(
            context: context,
            title: state.errorMsg,
            onDone: () => context.pop(),
          ).showDialog(
            context,
            dialogType: DialogType.warning,
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.status == Status.inProgress;
        return Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.only(bottom: 28),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              ScreenHeaderWidget(
                title: 'Buscar solicitud',
                subtitle:
                    'Supervisión de $_tipoSupervisorLabel. Busca la solicitud de crédito por número de solicitud o cédula del cliente.',
                onBack: () => Navigator.pop(context),
              ),
              const Gap(24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Buscar por',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: RedesignColors.inkMuted,
                  ),
                ),
              ),
              const Gap(8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _BuscarPorToggle(
                  value: _buscarPor,
                  onChanged: isLoading ? null : _onBuscarPorChanged,
                ),
              ),
              const Gap(14),
              OutlineTextfieldWidget(
                key: ValueKey(_buscarPor),
                isRequired: true,
                textEditingController: _valorController,
                textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) => ClassValidator.validateRequired(value),
                icon: Icon(
                  isNumero ? Icons.tag_rounded : Icons.badge_outlined,
                  color: RedesignColors.inkMuted,
                ),
                title: isNumero ? 'Número de solicitud' : 'Cédula del cliente',
                hintText: isNumero
                    ? 'Ingresa el número de solicitud'
                    : 'Ingresa la cédula del cliente',
              ),
              const Gap(24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _onSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: RedesignColors.ink,
                      foregroundColor: RedesignColors.surface,
                      disabledBackgroundColor: RedesignColors.ink,
                      disabledForegroundColor: RedesignColors.surface,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.4,
                              color: RedesignColors.surface,
                            ),
                          )
                        : const Text(
                            'Buscar',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Selector de dos opciones (número de solicitud / cédula) en lugar del
/// dropdown anterior: siempre hay una opción activa, así que no requiere
/// validación.
class _BuscarPorToggle extends StatelessWidget {
  final _BuscarPor value;
  final ValueChanged<_BuscarPor>? onChanged;
  const _BuscarPorToggle({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: RedesignColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: RedesignColors.border),
      ),
      child: Row(
        children: [
          _ToggleOption(
            label: 'N. de solicitud',
            icon: Icons.tag_rounded,
            selected: value == _BuscarPor.numero,
            onTap:
                onChanged == null ? null : () => onChanged!(_BuscarPor.numero),
          ),
          const Gap(4),
          _ToggleOption(
            label: 'Cédula',
            icon: Icons.badge_outlined,
            selected: value == _BuscarPor.cedula,
            onTap:
                onChanged == null ? null : () => onChanged!(_BuscarPor.cedula),
          ),
        ],
      ),
    );
  }
}

class _ToggleOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback? onTap;
  const _ToggleOption({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? RedesignColors.surface : RedesignColors.inkMuted;
    return Expanded(
      child: Material(
        color: selected ? RedesignColors.ink : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap == null
              ? null
              : () {
                  HapticFeedback.selectionClick();
                  onTap!();
                },
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            height: 42,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 17, color: color),
                const Gap(6),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
