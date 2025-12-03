import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/garantias/analisis_garantia_credito_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_garantia/analisis_garantia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CreateGarantiaModalSheet extends StatefulWidget {
  final int numeroSolicitud;
  final String solicitudCodigo;
  final String cedulaCliente;
  const CreateGarantiaModalSheet({
    super.key,
    required this.numeroSolicitud,
    required this.solicitudCodigo,
    required this.cedulaCliente,
  });

  @override
  State<CreateGarantiaModalSheet> createState() =>
      _CreateGarantiaModalSheetState();
}

class _CreateGarantiaModalSheetState extends State<CreateGarantiaModalSheet> {
  final formKey = GlobalKey<FormState>();
  String? tipoGarantia;
  String? tipoPersona;
  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.55,
        maxChildSize: 0.7,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                controller: scrollController,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  children: [
                    const Gap(15),
                    Center(
                      child: Container(
                        width: 40,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const Gap(20),
                    SearchDropdownWidget(
                      codigo: 'TIPOGARANTIA',
                      title: 'Tipo Garantia',
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      onChanged: (v) {
                        tipoGarantia = v?.value;
                      },
                    ),
                    const Gap(20),
                    SearchDropdownWidget(
                      codigo: 'TIPOPERSONA',
                      title: 'Tipo Persona',
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      onChanged: (v) {
                        tipoPersona = v?.value;
                      },
                    ),
                    // const Gap(20),
                    // OutlineTextfieldWidget(
                    //   title: 'Valor comercial total',
                    //   icon: const Icon(Icons.comment_bank_sharp),
                    //   validator: (value) =>
                    //       ClassValidator.validateRequired(value),
                    //   textInputType: TextInputType.number,
                    //   inputFormatters: [
                    //     CurrencyInputFormatter(
                    //       mantissaLength: 0,
                    //     ),
                    //   ],
                    //   onChange: (value) {},
                    // ),
                    const Gap(20),
                    BlocConsumer<AnalisisGarantiaCubit, AnalisisGarantiaState>(
                      listenWhen: (prev, curr) =>
                          prev.statusCreate != curr.statusCreate,
                      listener: (context, state) {
                        if (state.statusCreate == Status.done) {
                          CustomAlertDialog(
                            context: context,
                            title: 'Garantia creada exitosamente',
                            onDone: () => {
                              context
                                  .read<AnalisisGarantiaCubit>()
                                  .getGarantiasByNumero(
                                    numeroSolicitud: widget.numeroSolicitud,
                                  ),
                              context.pop(),
                              context.pop(),
                            },
                          ).showDialog(
                            context,
                            dialogType: DialogType.success,
                          );
                        }
                        if (state.statusCreate == Status.error) {
                          CustomAlertDialog(
                            context: context,
                            title: state.errorMsg,
                            onDone: () => context.pop(),
                          ).showDialog(
                            context,
                            dialogType: DialogType.error,
                          );
                        }
                      },
                      builder: (context, state) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          width: double.infinity,
                          child: CustomElevatedButton(
                            enabled: state.statusCreate != Status.inProgress,
                            text: state.statusCreate == Status.inProgress
                                ? 'Creando...'
                                : 'Crear',
                            // ignore: deprecated_member_use
                            color: AppColors.greenLatern.withOpacity(0.4),
                            onPressed: () {
                              if (!formKey.currentState!.validate()) return;
                              context
                                  .read<AnalisisGarantiaCubit>()
                                  .createAnalisisGarantia(
                                    numeroSolicitud: widget.numeroSolicitud,
                                    solicitudCodigo: widget.solicitudCodigo,
                                    analisisGarantia: AnalisisGarantia(
                                      tipoGarantiaCodigo: tipoGarantia!,
                                      tipoPersonaCodigo: tipoPersona!,
                                      cedulaPropietario: widget.cedulaCliente,
                                    ),
                                  );
                            },
                          ),
                        );
                      },
                    ),
                    const Gap(20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
