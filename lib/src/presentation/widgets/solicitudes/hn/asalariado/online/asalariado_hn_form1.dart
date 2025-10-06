// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_asalariado_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AsalariadoHnForm1 extends StatefulWidget {
  final PageController controller;
  const AsalariadoHnForm1({
    super.key,
    required this.controller,
  });

  @override
  State<AsalariadoHnForm1> createState() => _AsalariadoHnForm1State();
}

class _AsalariadoHnForm1State extends State<AsalariadoHnForm1> {
  final formKey = GlobalKey<FormState>();
  bool tieneVinculosUsa = false;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SolicitudAsalariadoHnCubit>();
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const MiCreditoProgress(
              currentStep: 1,
              steps: 7,
            ),
            const Gap(30),
            Column(
              children: [
                OutlineTextfieldWidget(
                  hintText: 'Primer Nombre',
                  icon: Icon(Icons.person, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  title: 'Nombre1',
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        nombre1: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Segundo Nombre',
                  icon: Icon(Icons.person_outline,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  title: 'Nombre2',
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        nombre2: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Primer Apellido',
                  icon: Icon(Icons.badge, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  title: 'Apellido 1',
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        apellido1: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Segundo Apellido',
                  icon: Icon(Icons.badge_outlined,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  title: 'Apellido2',
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        apellido2: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Cédula',
                  icon: Icon(Icons.credit_card,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  title: 'Cedula',
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        cedula: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Fecha de Emisión de Cédula',
                  icon: Icon(Icons.date_range,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.datetime,
                  textCapitalization: TextCapitalization.none,
                  title: 'FechaEmisionCedula',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Fecha de Vencimiento de Cédula',
                  icon: Icon(Icons.event, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.datetime,
                  textCapitalization: TextCapitalization.none,
                  title: 'FechaVencimientoCedula',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'País Emisor de Cédula',
                  icon: Icon(Icons.public, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'ObjPaisEmisorCedula',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Fecha de Nacimiento',
                  icon: Icon(Icons.cake, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.datetime,
                  textCapitalization: TextCapitalization.none,
                  title: 'FechaNacimiento',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Teléfono',
                  icon: Icon(Icons.phone, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.phone,
                  textCapitalization: TextCapitalization.none,
                  title: 'Telefono',
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        telefono: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Celular',
                  icon: Icon(Icons.smartphone,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.phone,
                  textCapitalization: TextCapitalization.none,
                  title: 'Celular',
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        celular: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Nacionalidad',
                  icon: Icon(Icons.flag, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'Nacionalidad',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Correo Electrónico',
                  icon: Icon(Icons.email, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  title: 'Email',
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        email: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Sexo',
                  icon: Icon(Icons.wc, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'objSexoID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Nombre Público',
                  icon: Icon(Icons.account_circle,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'NombrePublico',
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        nombrePublico: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Cantidad de Hijos',
                  icon: Icon(Icons.family_restroom,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  title: 'CantidadHijos',
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        cantidadHijos: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'País de Nacimiento',
                  icon: Icon(Icons.public_outlined,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'objPaisNacimientoID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Tipo de Documento',
                  icon: Icon(Icons.description,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'objTipoDocumentoID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Tipo de Persona',
                  icon: Icon(Icons.person_pin,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'objTipoPersonaID',
                ),
                const Gap(30),
                SheetSearchDropdown(
                  title: 'Tiene vinculos con USA?',
                  isRequired: true,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      tieneVinculosUsa = item.value == 'input.yes'.tr();
                    });
                    // cubit.onFieldChanged(
                    //   () => cubit.state.copyWith(
                    //     tieneVinculosUsa: item.value == 'input.yes'.tr(),
                    //   ),
                    // );
                  },
                  hintText: 'input.select_option'.tr(),
                  enabled: true,
                  items: [
                    Item(name: 'input.yes'.tr(), value: 'input.yes'.tr()),
                    Item(name: 'input.no'.tr(), value: 'input.no'.tr()),
                  ],
                ),
                if (tieneVinculosUsa) ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    hintText: 'Código USA',
                    icon:
                        Icon(Icons.qr_code, color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.characters,
                    title: 'Codigo USA',
                    onChange: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          codigoUsa: value,
                        ),
                      );
                    },
                  ),
                ],
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'RTN',
                  icon: Icon(Icons.confirmation_number,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  title: 'Rtn',
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        rtn: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Tipo de Cliente',
                  icon: Icon(Icons.groups, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'ObjTipoClienteID',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ubicación',
                  icon: Icon(Icons.location_on,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  title: 'Ubicacion',
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        ubicacion: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Tipo Persona CNBS',
                  icon: Icon(Icons.account_box,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'ObjTipoPersonaCNBSID',
                ),
              ],
            ),
            const Gap(30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: CustomElevatedButton(
                text: 'Siguiente',
                color: AppColors.greenLatern.withOpacity(0.4),
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;

                  widget.controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
              ),
            ),
            const Gap(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomOutLineButton(
                onPressed: () {
                  context.pushReplacement('/solicitudes');
                },
                text: 'Cancelar',
                textColor: AppColors.red,
                color: AppColors.red,
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
