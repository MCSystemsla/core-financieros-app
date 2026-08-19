import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/snackbar/custom_snackbar.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/domain/repository/supervisiones/hn/supervisiones_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/analisis_interceptor_by_flavor.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/switch/custom_switch.dart';
import 'package:core_financiero_app/src/utils/extensions/loading/loading_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../bloc/supervisiones/supervision_grupal/supervision_grupal_cubit.dart';

class SupervisionGrupalHnScreen extends StatelessWidget {
  final int cicloGrupoId;
  const SupervisionGrupalHnScreen({super.key, required this.cicloGrupoId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => SupervisionGrupalCubit(
        SupervisionesRepositoryHnImpl(),
      )..setCicloGrupoId(cicloGrupoId),
      child: const _SupervisionGrupalHnForm(),
    );
  }
}

class _SupervisionGrupalHnForm extends StatelessWidget {
  const _SupervisionGrupalHnForm();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final cubit = context.read<SupervisionGrupalCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Supervisión Grupal'),
      ),
      body: SafeArea(
        child: BlocConsumer<SupervisionGrupalCubit, SupervisionGrupalState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == Status.inProgress) {
              context.showLoading(message: 'Creando Supervisión...');
            }
            if (state.status == Status.error) {
              context.hideLoading();
              showV2CustomSnackbar(
                context,
                title: state.errorMsg,
                type: SnackbarType.error,
              );
            }
            if (state.status == Status.done) {
              context.hideLoading();
              CustomAlertDialog(
                context: context,
                title: 'Supervisión creada exitosamente',
                onDone: () {
                  context.pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AnalisisInterceptorByFlavor(),
                    ),
                  );
                },
              ).showDialog(context, dialogType: DialogType.success);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(4),
                      const Text(
                        'Datos de la supervisión grupal',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(4),
                      const Text(
                        'Completa la información del grupo supervisado',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                      const Gap(12),
                      const Divider(height: 1),
                      const Gap(10),
                      OutlineTextfieldWidget(
                        title: 'Lugar de reunión del grupo',
                        icon: const Icon(Icons.place),
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => state.copyWith(lugarReunionGrupo: value),
                          );
                        },
                      ),
                      const Gap(10),
                      OutlineTextfieldWidget(
                        title: 'Teléfono de casa',
                        icon: const Icon(Icons.phone),
                        textInputType: TextInputType.phone,
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => state.copyWith(telefonoCasa: value),
                          );
                        },
                      ),
                      const Gap(10),
                      OutlineTextfieldWidget(
                        title: 'Teléfono celular',
                        icon: const Icon(Icons.phone_android),
                        textInputType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => state.copyWith(telefonoCelular: value),
                          );
                        },
                      ),
                      const Gap(10),
                      OutlineTextfieldWidget(
                        title: 'Referencias de buró de crédito',
                        icon: const Icon(Icons.credit_score),
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => state.copyWith(referenciasBuroCredito: value),
                          );
                        },
                      ),
                      const Gap(10),
                      CustomSwitch(
                        title: 'Análisis de voluntad de pago',
                        subtitle: '¿El grupo muestra voluntad de pago?',
                        value: state.analisisVoluntadPago,
                        onChanged: (value) {
                          cubit.onFieldChanged(
                            () => state.copyWith(analisisVoluntadPago: value),
                          );
                        },
                      ),
                      const Gap(10),
                      CustomSwitch(
                        title: 'Verificación de activos fijos',
                        subtitle: '¿Se verificaron los activos fijos?',
                        value: state.verificacionActivosFijos,
                        onChanged: (value) {
                          cubit.onFieldChanged(
                            () =>
                                state.copyWith(verificacionActivosFijos: value),
                          );
                        },
                      ),
                      const Gap(10),
                      OutlineTextfieldWidget(
                        title: 'Otras observaciones',
                        icon: const Icon(Icons.notes),
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => state.copyWith(otrasObservaciones: value),
                          );
                        },
                      ),
                      const Gap(10),
                      OutlineTextfieldWidget(
                        title: 'Monto de Propuesta',
                        icon: const Icon(Icons.wallet),
                        textInputType: TextInputType.number,
                        inputFormatters: [
                          CurrencyInputFormatter(),
                        ],
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        onChange: (value) {
                          final newValue =
                              toNumericString(value ?? '', allowPeriod: true);
                          cubit.onFieldChanged(
                            () => state.copyWith(
                              monto: double.tryParse(newValue) ?? 0,
                            ),
                          );
                        },
                      ),
                      const Gap(25),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: CustomElevatedButton(
                          onPressed: () {
                            if (!formKey.currentState!.validate()) return;
                            context
                                .read<SupervisionGrupalCubit>()
                                .createSupervisionGrupal();
                          },
                          text: 'Enviar',
                          color: Colors.green,
                        ),
                      ),
                      const Gap(20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
