// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/domain/repository/supervisiones/hn/supervisiones_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/supervisiones/get_supervisiones/get_supervisiones_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/supervisiones/supervisiones_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/tipo_supervisor/tipo_supervisor_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

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
        appBar: AppBar(
          title: const Text('Crear Supervision'),
        ),
        body: _UserCedulaForm(
          tipoSupervisor: tipoSupervisor,
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
  Item? tipoDocumento;
  String? typeVal;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetSupervisionesCubit, GetSupervisionesState>(
      listener: (context, state) {
        if (state.status == Status.done) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => BlocProvider.value(
                value: context.read<GetSupervisionesCubit>(),
                child: SupervisionesHnScreen(
                  numeroSolicitud: typeVal ?? '',
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
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Center(
              child: SingleChildScrollView(
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
                      'Buscar Solicitud de crédito por Numero solicitud o cedula cliente',
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
                    SheetSearchDropdown(
                      hintText: 'input.select_option'.tr(),
                      title: 'Buscar por:',
                      isRequired: true,
                      onChanged: (v) {
                        setState(() {
                          tipoDocumento = v;
                        });
                      },
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      enabled: true,
                      items: const [
                        Item(name: 'Numero de Solicitud', value: 'NUMERO'),
                        Item(name: 'Cedula cliente', value: 'CEDULA'),
                      ],
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      onChange: (value) {
                        typeVal = value;
                      },
                      isRequired: true,
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      icon: Icon(
                        Icons.credit_card_outlined,
                        color: AppColors.getPrimaryColor(),
                      ),
                      title: 'Ingresa credenciales de solicitud',
                      hintText: 'Ingresa credenciales de solicitud',
                    ),
                    const Gap(20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      child: CustomElevatedButton(
                        enabled: state.status != Status.inProgress,
                        text: state.status == Status.inProgress
                            ? 'Cargando...'
                            : 'Buscar',
                        color: AppColors.greenLatern.withOpacity(0.4),
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;
                          switch (tipoDocumento?.value) {
                            case 'NUMERO':
                              context
                                  .read<GetSupervisionesCubit>()
                                  .getSupervisionesByNumeroOrCedula(
                                    numeroSolicitud: int.tryParse(typeVal!),
                                  );
                              break;

                            case 'CEDULA':
                              context
                                  .read<GetSupervisionesCubit>()
                                  .getSupervisionesByNumeroOrCedula(
                                    cedulaIdentidad: typeVal,
                                  );
                              break;

                            default:
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
