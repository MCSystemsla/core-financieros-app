import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_articulo/analisis_articulo_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CreateArticuloModalSheet extends StatefulWidget {
  final int numeroSolicitud;
  const CreateArticuloModalSheet({
    super.key,
    required this.numeroSolicitud,
  });

  @override
  State<CreateArticuloModalSheet> createState() =>
      _CreateArticuloModalSheetState();
}

class _CreateArticuloModalSheetState extends State<CreateArticuloModalSheet> {
  final formKey = GlobalKey<FormState>();
  String? tipo;
  String? descripcion;
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    const SizedBox(height: 25),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Text(
                        'Nuevo Artículo',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const Gap(5),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Ingrese la información del artículo',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    const Gap(10),
                    OutlineTextfieldWidget(
                      title: 'Tipo',
                      icon: Icon(
                        Icons.category,
                        color: AppColors.getPrimaryColor(),
                      ),
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      onChange: (value) {
                        tipo = value;
                      },
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      title: 'Descripcion',
                      icon: Icon(
                        Icons.description,
                        color: AppColors.getPrimaryColor(),
                      ),
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      onChange: (value) {
                        descripcion = value;
                      },
                    ),
                    const Gap(20),
                    BlocConsumer<AnalisisArticuloCubit, AnalisisArticuloState>(
                      listenWhen: (prev, curr) =>
                          prev.statusCreate != curr.statusCreate,
                      listener: (context, state) {
                        if (state.statusCreate == Status.done) {
                          CustomAlertDialog(
                            context: context,
                            title: 'Articulo creado exitosamente',
                            onDone: () => {
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
                                  .read<AnalisisArticuloCubit>()
                                  .createAnalisisGarantiasArticulos(
                                    descripcion: descripcion!,
                                    tipo: tipo!,
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
