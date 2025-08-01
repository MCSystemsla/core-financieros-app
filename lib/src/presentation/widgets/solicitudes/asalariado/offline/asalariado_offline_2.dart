// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/formatter/dash_formater.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/asalariado_responses_local_db.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_asalariado/solicitud_asalariado_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AsalariadoOffline2 extends StatefulWidget {
  final PageController controller;
  final AsalariadoResponsesLocalDb? asalariadoResponsesLocalDb;
  const AsalariadoOffline2({
    super.key,
    required this.controller,
    this.asalariadoResponsesLocalDb,
  });

  @override
  State<AsalariadoOffline2> createState() => _AsalariadoOffline2State();
}

class _AsalariadoOffline2State extends State<AsalariadoOffline2>
    with AutomaticKeepAliveClientMixin {
  String? beneficiarioSeguro;

  Item? parentesco;

  String? cedula;

  String? telefono;

  String? esPeps;

  String? nombreEntidad;

  String? paisPeps;

  String? periodoPeps;

  String? cargoOficialPeps;

  String? familiarPeps;

  String? nombreFamiliarPeps;

  String? parentescoFamiliarPeps;

  String? cargoFamiliarPeps;

  String? nombreEntidadPeps;

  String? periodoFamiliarPeps;

  String? paisPepsFamiliar;

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    final solicitud = widget.asalariadoResponsesLocalDb;
    beneficiarioSeguro = solicitud?.beneficiarioSeguro;
    parentesco = Item(
      name: solicitud?.objParentescoBeneficiarioSeguroIdVer ?? '',
      value: solicitud?.objParentescoBeneficiarioSeguroId,
    );
    cedula = solicitud?.cedulaBeneficiarioSeguro;
    telefono = solicitud?.telefonoBeneficiario;
    esPeps = (solicitud?.espeps ?? false) ? 'input.yes'.tr() : 'input.no'.tr();
    nombreEntidad = solicitud?.nombreDeEntidadPeps;
    paisPeps = solicitud?.paisPeps;
    periodoPeps = solicitud?.periodoPeps;
    cargoOficialPeps = solicitud?.cargoOficialPeps;
    familiarPeps = (solicitud?.tieneFamiliarPeps ?? false)
        ? 'input.yes'.tr()
        : 'input.no'.tr();

    nombreFamiliarPeps = solicitud?.nombreFamiliarPeps2;
    parentescoFamiliarPeps = solicitud?.parentescoFamiliarPeps2;
    cargoFamiliarPeps = solicitud?.cargoFamiliarPeps2;
    nombreEntidadPeps = solicitud?.nombreEntidadPeps2;
    periodoFamiliarPeps = solicitud?.periodoPeps;
    paisPepsFamiliar = solicitud?.paisPeps2;
    context.read<SolicitudAsalariadoCubit>().onFieldChanged(
          () => context.read<SolicitudAsalariadoCubit>().state.copyWith(
                beneficiarioSeguro: beneficiarioSeguro,
                objParentescoBeneficiarioSeguroId: parentesco?.value,
                objParentescoBeneficiarioSeguroIdVer: parentesco?.name,
                cedulaBeneficiarioSeguro: cedula,
                telefonoBeneficiario: telefono,
                espeps: esPeps == 'input.yes'.tr(),
                nombreDeEntidadPeps: nombreEntidadPeps,
                paisPeps: paisPeps,
                periodoPeps: periodoPeps,
                cargoOficialPeps: cargoOficialPeps,
                tieneFamiliarPeps: familiarPeps == 'input.yes'.tr(),
                nombreFamiliarPeps2: nombreFamiliarPeps,
                parentescoFamiliarPeps2: parentescoFamiliarPeps,
                cargoFamiliarPeps2: cargoFamiliarPeps,
                nombreEntidadPeps2: nombreEntidadPeps,
                periodoPeps2: periodoFamiliarPeps,
                paisPeps2: paisPepsFamiliar,
              ),
        );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<SolicitudAsalariadoCubit, SolicitudAsalariadoState>(
      builder: (context, state) {
        final cubit = context.read<SolicitudAsalariadoCubit>();
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    'Beneficiarios del Seguro',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: beneficiarioSeguro,
                  onChange: (value) {
                    beneficiarioSeguro = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        beneficiarioSeguro: beneficiarioSeguro,
                      ),
                    );
                  },
                  title: 'Nombre y Apellido',
                  icon: const Icon(Icons.person),
                ),
                const Gap(30),
                SearchDropdownWidget(
                  onChanged: (item) {
                    parentesco = item;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objParentescoBeneficiarioSeguroId: parentesco?.value,
                        objParentescoBeneficiarioSeguroIdVer: parentesco?.name,
                      ),
                    );
                    setState(() {});
                  },
                  codigo: 'PARENTESCO',
                  title: 'Parentesco',
                  hintText: parentesco?.name ?? 'input.select_option'.tr(),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: cedula,
                  onChange: (value) {
                    cedula = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        cedulaBeneficiarioSeguro: cedula,
                      ),
                    );
                  },
                  title: 'Cedula',
                  icon: const Icon(Icons.badge),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: telefono,
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    DashFormatter(),
                    LengthLimitingTextInputFormatter(9),
                  ],
                  onChange: (value) {
                    telefono = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        telefonoBeneficiario: value,
                      ),
                    );
                  },
                  isRequired: false,
                  hintText: 'Ingresa Telefono',
                  maxLength: 15,
                  title: 'Telefono',
                  icon: const Icon(Icons.badge),
                ),
                const Gap(30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    'Informacion Adicional',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const Gap(30),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: JLuxDropdown(
                    initialValue: esPeps,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    dropdownColor: Colors.white,
                    isContainIcon: true,
                    title:
                        '¿Has desempeñado un cargo público y/o figura pública de alto nivel en los últimos 10 años?',
                    items: ['input.yes'.tr(), 'input.no'.tr()],
                    onChanged: (item) {
                      esPeps = item;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          espeps: esPeps == 'input.yes'.tr(),
                        ),
                      );
                      setState(() {});
                    },
                    // validator: (value) {},
                    toStringItem: (item) => item,
                    hintText: 'input.select_option'.tr(),
                  ),
                ),
                if (esPeps == 'input.yes'.tr()) ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    initialValue: nombreEntidad,
                    onChange: (value) {
                      nombreEntidad = value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          nombreDeEntidadPeps: nombreEntidad,
                        ),
                      );
                    },
                    title: 'Nombre de la Entidad',
                    icon: const Icon(Icons.account_balance),
                  ),
                  const Gap(30),
                  CatalogoValorNacionalidad(
                    hintText: paisPeps ?? 'input.select_option'.tr(),
                    title: 'Pais',
                    onChanged: (item) {
                      if (item == null) return;
                      paisPeps = item.valor;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          paisPeps: item.valor,
                        ),
                      );

                      setState(() {});
                    },
                    codigo: 'PAIS',
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    initialValue: periodoPeps,
                    onChange: (value) {
                      periodoPeps = value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          periodoPeps: periodoPeps,
                        ),
                      );
                    },
                    title: 'Periodo',
                    icon: const Icon(Icons.date_range),
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    initialValue: cargoOficialPeps,
                    onChange: (value) {
                      cargoOficialPeps = value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          cargoOficialPeps: cargoOficialPeps,
                        ),
                      );
                    },
                    title: 'Cargo Oficial',
                    icon: const Icon(Icons.work),
                  ),
                  const Gap(30),
                ],
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: JLuxDropdown(
                    initialValue: familiarPeps,
                    dropdownColor: Colors.white,
                    isContainIcon: true,
                    title:
                        '¿Eres familia de una persona que ha desempeñado un cargo público o figura pública de alto nivel?',
                    items: ['input.yes'.tr(), 'input.no'.tr()],
                    onChanged: (item) {
                      familiarPeps = item;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          tieneFamiliarPeps: familiarPeps == 'input.yes'.tr(),
                        ),
                      );
                      setState(() {});
                    },
                    toStringItem: (item) => item,
                    hintText: 'input.select_option'.tr(),
                  ),
                ),
                if (familiarPeps == 'input.yes'.tr()) ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    initialValue: nombreFamiliarPeps,
                    onChange: (value) {
                      nombreFamiliarPeps = value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          nombreFamiliarPeps2: nombreFamiliarPeps,
                        ),
                      );
                    },
                    title: 'Nombre del Familiar',
                    icon: const Icon(Icons.person),
                  ),
                  const Gap(30),
                  SearchDropdownWidget(
                    validator: (value) =>
                        ClassValidator.validateRequired(parentescoFamiliarPeps),
                    hintText:
                        parentescoFamiliarPeps ?? 'input.select_option'.tr(),
                    onChanged: (item) {
                      parentescoFamiliarPeps = item?.value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          parentescoFamiliarPeps2: parentescoFamiliarPeps,
                        ),
                      );
                      setState(() {});
                    },
                    codigo: 'PARENTESCO',
                    title: 'Parentesco',
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    initialValue: cargoFamiliarPeps,
                    onChange: (value) {
                      cargoFamiliarPeps = value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          cargoFamiliarPeps2: cargoFamiliarPeps,
                        ),
                      );
                    },
                    title: 'Cargo del Familiar',
                    icon: const Icon(Icons.work),
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    initialValue: nombreEntidadPeps,
                    onChange: (value) {
                      nombreEntidadPeps = value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          nombreEntidadPeps2: nombreEntidadPeps,
                        ),
                      );
                    },
                    title: 'Nombre de la Entidad',
                    icon: const Icon(Icons.account_balance),
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    initialValue: periodoFamiliarPeps,
                    onChange: (value) {
                      periodoFamiliarPeps = value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          periodoPeps2: periodoFamiliarPeps,
                        ),
                      );
                    },
                    title: 'Periodo',
                    icon: const Icon(Icons.date_range),
                  ),
                  const Gap(30),
                  CatalogoValorNacionalidad(
                    hintText: paisPepsFamiliar ?? 'input.select_option'.tr(),
                    codigo: 'PAIS',
                    title: 'País',
                    onChanged: (item) {
                      paisPepsFamiliar = item?.valor;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          paisPeps2: paisPepsFamiliar,
                        ),
                      );
                    },
                  ),
                ],
                const Gap(20),
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
                const Gap(10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomOutLineButton(
                    onPressed: () {
                      widget.controller.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    text: 'Atras',
                    textColor: AppColors.red,
                    color: AppColors.red,
                  ),
                ),
                const Gap(20),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
