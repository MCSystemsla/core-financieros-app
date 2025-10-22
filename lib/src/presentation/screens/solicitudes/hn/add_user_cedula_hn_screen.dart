// ignore_for_file: deprecated_member_use
import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/user_by_document_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/hn/crear_solicitud_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/ni/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AddUserCedulaHnScreen extends StatelessWidget {
  final TypeForm typeForm;
  const AddUserCedulaHnScreen({
    super.key,
    required this.typeForm,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => UserByDocumentCubit(
        SolicitudesCreditoHnRepositoryImpl(),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.lightGray,
        ),
        body: _UserCedulaForm(
          typeForm: typeForm,
        ),
      ),
    );
  }
}

class _UserCedulaForm extends StatefulWidget {
  final TypeForm typeForm;
  const _UserCedulaForm({
    required this.typeForm,
  });

  @override
  State<_UserCedulaForm> createState() => _UserCedulaFormState();
}

class _UserCedulaFormState extends State<_UserCedulaForm> {
  Item? tipoDocumento;
  Item? paisEmisorDocumento;
  final formKey = GlobalKey<FormState>();

  final cedulaController = TextEditingController();
  final nombreController = TextEditingController();

  int determineDocumentoLength({
    String? tipoDocumento,
    String? paisEmisor,
  }) {
    return switch ((tipoDocumento, paisEmisor)) {
      ('CEDULAIDENTIDAD', 'HN') => 13,
      ('CEDULAIDENTIDAD', 'NIC') => 14,
      ('PASAPORTE', 'NIC') => 9,
      ('PASAPORTE', 'HN') => 7,
      ('RTN', 'HN') => 14,
      ('CARNETRESIDENCIA', 'HN') => 8,
      _ => 0
    };
  }

  TextInputType determineInputType({
    String? tipoDocumento,
  }) {
    return switch ((tipoDocumento)) {
      ('CEDULAIDENTIDAD') => TextInputType.number,
      ('PASAPORTE') => TextInputType.text,
      ('RTN') => TextInputType.number,
      ('CARNETRESIDENCIA') => TextInputType.text,
      ('DNI') => TextInputType.number,
      _ => TextInputType.text
    };
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: formKey,
        child: Center(
          child: BlocConsumer<UserByDocumentCubit, UserByDocumentState>(
            listener: (context, state) {
              if (state.status == UserByDocumentStatus.error) {
                CustomAlertDialog(
                  context: context,
                  title: state.errorMsg,
                  onDone: () => context.pop(),
                ).showDialog(context);
              }
              if (state.status == UserByDocumentStatus.done) {
                CustomAlertDialog(
                  context: context,
                  title:
                      '${state.primerNombre} ${state.segundoNombre} listo para crear solicitud!!',
                  onDone: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => BlocProvider.value(
                          value: context.read<UserByDocumentCubit>(),
                          child: CrearSolicitudHnScreen(
                            typeForm: widget.typeForm,
                          ),
                        ),
                      ),
                    );
                  },
                ).showDialog(context, dialogType: DialogType.success);
              }
              if (state.status == UserByDocumentStatus.isNewUser) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => BlocProvider.value(
                      value: context.read<UserByDocumentCubit>(),
                      child: CrearSolicitudHnScreen(
                        typeForm: widget.typeForm,
                      ),
                    ),
                  ),
                );
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      height: 200,
                      ImageAsset.nuevaAddDni,
                    ),
                    const Gap(30),
                    Text(
                      'Ingresar Usuario a solicitar Solicitud de Credito',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const Gap(10),
                    Text(
                      'Ingresa los datos requeridos',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      isRequired: true,
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      textEditingController: nombreController,
                      validator: (value) => ClassValidator.validateRequired(
                        value,
                      ),
                      icon: Icon(
                        Icons.person,
                        color: AppColors.getPrimaryColor(),
                      ),
                      title: 'Nombre de cliente',
                      hintText: 'Ingresa el nombre de cliente',
                    ),
                    const Gap(20),
                    SearchDropdownWidget(
                      isRequired: true,
                      hintText: 'input.select_option'.tr(),
                      codigo: 'TIPODOCUMENTOPERSONA',
                      onChanged: (item) {
                        tipoDocumento = item;
                        log(item?.value);
                        setState(() {});
                      },
                      title: 'Tipo Documento',
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                    ),
                    if (tipoDocumento != null) ...[
                      const Gap(20),
                      OutlineTextfieldWidget(
                        isRequired: true,
                        textInputType: determineInputType(
                          tipoDocumento: tipoDocumento?.value,
                        ),
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        textEditingController: cedulaController,
                        validator: (value) =>
                            ClassValidator.hondurasDocumentValidator(
                          value,
                          tipoDocumento?.value,
                        ),
                        icon: Icon(
                          Icons.credit_card_outlined,
                          color: AppColors.getPrimaryColor(),
                        ),
                        title: 'Documento',
                        hintText: 'Ingresa documento de cliente',
                      ),
                    ],
                    const Gap(20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      child: CustomElevatedButton(
                        enabled:
                            state.status != UserByDocumentStatus.inProgress,
                        text: state.status == UserByDocumentStatus.inProgress
                            ? 'Cargando...'
                            : 'Enviar',
                        color: AppColors.greenLatern.withOpacity(0.4),
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;
                          context.read<UserByDocumentCubit>().getUserByDocument(
                                cedula: cedulaController.text.trim(),
                                nombre: nombreController.text.trim(),
                                tipoDocumentoCodigo: tipoDocumento?.value,
                              );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
