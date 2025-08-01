// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
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

class AsalariadoOffline3 extends StatefulWidget {
  final PageController controller;
  final AsalariadoResponsesLocalDb? asalariadoResponsesLocalDb;

  const AsalariadoOffline3({
    super.key,
    required this.controller,
    this.asalariadoResponsesLocalDb,
  });

  @override
  State<AsalariadoOffline3> createState() => _AsalariadoOffline3State();
}

class _AsalariadoOffline3State extends State<AsalariadoOffline3>
    with AutomaticKeepAliveClientMixin {
  Item? paisCasa;

  Item? depCasa;

  Item? munCasa;

  Item? condicionCasa;

  String? nombreDuenoCasa;

  String? pagoAlquiler;

  String? anosResidir;

  String? direccionDomicilio;

  String? barrio;

  Item? sector;

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    final solicitud = widget.asalariadoResponsesLocalDb;
    paisCasa = Item(
      name: solicitud?.objPaisCasaIdVer ?? '',
      value: solicitud?.objPaisCasaId,
    );
    depCasa = Item(
      name: solicitud?.objDepartamentoCasaIdVer ?? '',
      value: solicitud?.objDepartamentoCasaId,
    );
    munCasa = Item(
      name: solicitud?.objMunicipioCasaIdVer ?? '',
      value: solicitud?.objMunicipioCasaId,
    );
    condicionCasa = Item(
      name: solicitud?.objCondicionCasaIdVer ?? '',
      value: solicitud?.objCondicionCasaId,
    );
    nombreDuenoCasa = solicitud?.duenoVivienda;
    pagoAlquiler = solicitud?.pagoAlquiler.toString();
    anosResidir = solicitud?.anosResidirCasa.toString();
    direccionDomicilio = solicitud?.direccionCasa;
    barrio = solicitud?.barrioCasa;
    sector = Item(
      name: solicitud?.objSectorIdVer ?? '',
      value: solicitud?.objSectorId,
    );
    context.read<SolicitudAsalariadoCubit>().onFieldChanged(
          () => context.read<SolicitudAsalariadoCubit>().state.copyWith(
                objMunicipioCasaId: paisCasa?.value,
                objMunicipioCasaIdVer: paisCasa?.name,
                objDepartamentoCasaId: depCasa?.value,
                objDepartamentoCasaIdVer: depCasa?.name,
                objPaisCasaId: paisCasa?.value,
                objPaisCasaIdVer: paisCasa?.name,
                objCondicionCasaId: condicionCasa?.value,
                objCondicionCasaIdVer: condicionCasa?.name,
                anosResidirCasa: int.tryParse(anosResidir ?? '0'),
                duenoVivienda: nombreDuenoCasa,
                pagoAlquiler: int.tryParse(pagoAlquiler ?? '0'),
                direccionCasa: direccionDomicilio,
                barrioCasa: barrio,
                objSectorId: sector?.value,
                objSectorIdVer: sector?.name,
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
              children: [
                const Gap(30),
                CatalogoValorNacionalidad(
                  validator: (value) =>
                      ClassValidator.validateRequired(paisCasa?.value),
                  codigo: 'PAIS',
                  title: 'País',
                  onChanged: (item) {
                    paisCasa =
                        Item(name: item?.nombre ?? '', value: item?.valor);

                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objPaisCasaId: paisCasa?.value,
                        objPaisCasaIdVer: paisCasa?.name,
                      ),
                    );
                    setState(() {});
                  },
                  hintText: paisCasa?.name ?? 'input.select_option'.tr(),
                ),
                const Gap(30),
                CatalogoValorNacionalidad(
                  validator: (value) =>
                      ClassValidator.validateRequired(depCasa?.value),
                  codigo: 'DEP',
                  title: 'Departamento',
                  hintText: depCasa?.name ?? 'input.select_option'.tr(),
                  onChanged: (item) {
                    depCasa = Item(
                      name: item?.nombre ?? '',
                      value: item?.valor,
                    );
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objDepartamentoCasaId: depCasa?.value,
                        objDepartamentoCasaIdVer: depCasa?.name,
                      ),
                    );

                    setState(() {});
                  },
                ),
                const Gap(30),
                CatalogoValorNacionalidad(
                  validator: (value) =>
                      ClassValidator.validateRequired(munCasa?.value),
                  codigo: 'MUN',
                  title: 'Municipio',
                  hintText: depCasa?.name ?? 'input.select_option'.tr(),
                  onChanged: (item) {
                    munCasa = Item(
                      name: item?.nombre ?? '',
                      value: item?.valor,
                    );
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objMunicipioCasaId: munCasa?.value,
                        objMunicipioCasaIdVer: munCasa?.name,
                      ),
                    );
                    setState(() {});
                  },
                ),
                const Gap(30),
                SearchDropdownWidget(
                  validator: (value) =>
                      ClassValidator.validateRequired(condicionCasa?.value),
                  hintText: condicionCasa?.name ?? 'input.select_option'.tr(),
                  codigo: 'TIPOVIVIENDA',
                  title: 'Condicion Casa',
                  onChanged: (item) {
                    condicionCasa = Item(
                      name: item?.name ?? '',
                      value: item?.value,
                    );
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objCondicionCasaId: condicionCasa?.value,
                        objCondicionCasaIdVer: condicionCasa?.name,
                      ),
                    );
                    setState(() {});
                  },
                ),
                if (condicionCasa?.value != 'ALQ') ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    initialValue: nombreDuenoCasa,
                    onChange: (value) {
                      nombreDuenoCasa = value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          duenoVivienda: nombreDuenoCasa,
                        ),
                      );
                    },
                    title: 'Nombre dueno de casa',
                    icon: const Icon(Icons.person),
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    initialValue: anosResidir,
                    textInputType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                    ],
                    onChange: (value) {
                      anosResidir = value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          anosResidirCasa: int.tryParse(anosResidir ?? '0'),
                        ),
                      );
                    },
                    title: 'Años de residir',
                    icon: const Icon(Icons.house),
                  ),
                ],
                if (condicionCasa?.value == 'ALQ') ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    initialValue: pagoAlquiler,
                    onChange: (value) {
                      pagoAlquiler = value;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          pagoAlquiler: int.tryParse(pagoAlquiler ?? '0'),
                        ),
                      );
                    },
                    title: 'Pago de alquiler',
                    icon: const Icon(Icons.money),
                  ),
                ],
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: direccionDomicilio,
                  validator: (value) => ClassValidator.validateRequired(value),
                  onChange: (value) {
                    direccionDomicilio = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        direccionCasa: direccionDomicilio,
                      ),
                    );
                  },
                  title: 'Direccion Domicilio',
                  icon: const Icon(Icons.house),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: barrio,
                  validator: (value) => ClassValidator.validateRequired(value),
                  onChange: (value) {
                    barrio = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        barrioCasa: barrio,
                      ),
                    );
                  },
                  title: 'Barrio',
                  icon: const Icon(Icons.house),
                ),
                const Gap(30),
                SearchDropdownWidget(
                  validator: (value) =>
                      ClassValidator.validateRequired(sector?.value),
                  hintText: sector?.name ?? 'input.select_option'.tr(),
                  codigo: 'SECTORECONOMICO',
                  title: 'Sector',
                  onChanged: (item) {
                    sector = item;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objSectorId: sector?.value,
                        objSectorIdVer: sector?.name,
                      ),
                    );

                    setState(() {});
                  },
                ),
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
