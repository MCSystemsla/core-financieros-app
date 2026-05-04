import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/select_date/select_date_helper.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/catalogo_frecuencia_pago/catalogo_frecuencia_pago.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/catalogo_frecuencia_pago_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/fuentes_financiamientos_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/tipos_credito_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/expandable/custom_expandable.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/modern_loading_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/catalogo_type/catalogo_type.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../bloc/comite/comite_solicitudes_grupales/comite_solicitudes_grupales_cubit.dart';
import '../../../bloc/comite/v2_comite_configuration_grupal/v2_comite_configuration_grupal_cubit.dart';

class ComiteGrupalEditSharedData extends StatefulWidget {
  const ComiteGrupalEditSharedData({super.key});

  @override
  State<ComiteGrupalEditSharedData> createState() =>
      _ComiteGrupalEditSharedDataState();
}

class _ComiteGrupalEditSharedDataState extends State<ComiteGrupalEditSharedData>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<V2ComiteConfigurationGrupalCubit>();
    final actasIntegrantesCubit =
        context.read<ComiteSolicitudesGrupalesCubit>();

    return BlocConsumer<V2ComiteConfigurationGrupalCubit,
        V2ComiteConfigurationGrupalState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == Status.done) {
          CustomAlertDialog(
            context: context,
            title: 'Datos de configuración creados exitosamente',
            onDone: () => context.pop(),
          ).showDialog(context, dialogType: DialogType.success);
        }
        if (state.status == Status.error) {
          CustomAlertDialog(
            context: context,
            title: state.errorMsg,
            onDone: () => context.pop(),
          ).showDialog(context, dialogType: DialogType.error);
        }
      },
      builder: (context, state) {
        return switch (state.getConfigurationStatus) {
          Status.inProgress => const ModernLoadingWidget(
              message: 'Cargando configuración compartida...',
            ),
          Status.error => OnErrorWidget(
              errorMsg: state.errorMsg,
              onPressed: () {
                context
                    .read<V2ComiteConfigurationGrupalCubit>()
                    .getConfigurationGrupal(
                      cicloGrupoId:
                          actasIntegrantesCubit.state.data.first.cicloGrupoId,
                    );
              },
            ),
          Status.done => Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomExpandable(
                fechaPrimerPago: DateTime.tryParse(state.fechaPrimerPago),
                tipoCredito: state.tipoCreditoNombre,
                plazo: state.plazo.toString(),
                title: 'Editar Datos de acta compartida',
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 20),
                        child: Text(
                          'Datos del crédito',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      const Gap(12),
                      SearchDropdownWidget(
                        selectedItem: Item(
                          name: state.productoNombre,
                          value: state.productoCodigo,
                        ),
                        validator: (value) => ClassValidator.validateRequired(
                          value?.value.toString(),
                        ),
                        codigo: 'PRODUCTO',
                        onChanged: (item) {
                          if (item == null) return;
                          cubit.onFieldChanged(
                            () => state.copyWith(
                              productoCodigo: item.value,
                            ),
                          );
                        },
                        title: 'Producto',
                      ),
                      const Divider(),
                      OutlineTextfieldWidget(
                        initialValue:
                            state.plazo.toString().toNullIfEmptyOrZero(),
                        title: 'Plazo en meses',
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        icon: Icon(
                          Icons.schedule_outlined,
                          color: AppColors.getPrimaryColor(),
                        ),
                        textInputType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChange: (value) {
                          final newValue = toNumericString(value);

                          cubit.onFieldChanged(
                            () => state.copyWith(
                              plazo: int.tryParse(newValue) ?? 0,
                            ),
                          );
                        },
                      ),
                      const Gap(20),
                      OutlineTextfieldWidget(
                        initialValue: state.periodoGracia
                            .toString()
                            .toNullIfEmptyOrZero(),
                        title: 'Periodo de gracia',
                        textInputType: TextInputType.number,
                        icon: Icon(
                          Icons.schedule_outlined,
                          color: AppColors.getPrimaryColor(),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChange: (value) {
                          final newValue = toNumericString(value);

                          cubit.onFieldChanged(
                            () => state.copyWith(
                              periodoGracia: int.tryParse(newValue) ?? 0,
                            ),
                          );
                        },
                      ),
                      const Gap(20),
                      FuentesFinanciamientosDropdown(
                        isRequired: true,
                        selectedItem: Item(
                          name: state.fuenteFinanciamientoNombre,
                          value: state.fuenteFinanciamientoCodigo,
                        ),
                        onChanged: (item) {
                          if (item == null) return;
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(
                              fuenteFinanciamientoCodigo: item.value,
                            ),
                          );
                        },
                        validator: (value) =>
                            ClassValidator.validateRequired(value?.value),
                      ),
                      const Gap(20),
                      OutlineTextfieldWidget(
                        hintText: DateTime.tryParse(state.fechaPrimerPago)
                            ?.selectorFormat(),
                        title: 'Fecha de primer pago',
                        validator: (value) => ClassValidator.validateRequired(
                            state.fechaPrimerPago),
                        onTap: () async {
                          final date = await pickDate(context);
                          if (date == null) return;
                          cubit.onFieldChanged(
                            () => state.copyWith(
                              fechaPrimerPago: date.toUtc().toIso8601String(),
                            ),
                          );
                        },
                        readOnly: true,
                        icon: Icon(
                          Icons.calendar_today_outlined,
                          color: AppColors.getPrimaryColor(),
                        ),
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        onChange: (value) {},
                      ),
                      const Gap(20),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 20),
                        child: Text(
                          'Parametros',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      const Gap(12),
                      SearchDropdownWidget(
                        selectedItem: Item(
                          name: state.monedaNombre,
                          value: state.monedaCodigo,
                        ),
                        isRequired: true,
                        codigo: 'MONEDA',
                        enabled: true,
                        title: 'Moneda de desembolso',
                        validator: (value) =>
                            ClassValidator.validateRequired(value?.value),
                        onChanged: (item) {
                          if (item == null) return;
                          cubit.onFieldChanged(
                            () => state.copyWith(
                              monedaCodigo: item.value,
                            ),
                          );
                        },
                      ),
                      const Gap(12),
                      SearchDropdownWidget(
                        selectedItem: Item(
                          name: state.tipoDesembolsoNombre,
                          value: state.tipoDesembolsoCodigo,
                        ),
                        isRequired: true,
                        codigo: CatalogoType.tipoDesembolsos.codigo,
                        validator: (value) =>
                            ClassValidator.validateRequired(value?.value),
                        enabled: true,
                        title: 'Tipo Desembolso',
                        onChanged: (item) {
                          if (item == null) return;
                          cubit.onFieldChanged(
                            () => state.copyWith(
                              tipoDesembolsoCodigo: item.value,
                            ),
                          );
                        },
                      ),
                      const Gap(12),
                      CatalogoFrecuenciaPagoDropdown(
                        selectedItem: CatalogoFrecuenciaItem(
                          valor: state.formaDePagoCodigo,
                          nombre: state.formaDePagoNombre,
                          meses: '',
                        ),
                        isRequired: true,
                        title: 'Forma de pago',
                        validator: (value) =>
                            ClassValidator.validateRequired(value?.valor),
                        onChanged: (value) {
                          if (value == null) return;
                          cubit.onFieldChanged(
                            () => state.copyWith(
                              formaDePagoCodigo: value.valor,
                            ),
                          );
                        },
                      ),
                      const Gap(12),
                      CatalogoFrecuenciaPagoDropdown(
                        selectedItem: CatalogoFrecuenciaItem(
                          valor: state.periodicidadPrincipalCodigo,
                          nombre: state.periodicidadPrincipalNombre,
                          meses: '',
                        ),
                        isRequired: true,
                        title: 'Periodicidad principal',
                        validator: (value) =>
                            ClassValidator.validateRequired(value?.valor),
                        onChanged: (value) {
                          if (value == null) return;
                          cubit.onFieldChanged(
                            () => state.copyWith(
                              periodicidadPrincipalCodigo: value.valor,
                            ),
                          );
                        },
                      ),
                      const Gap(12),
                      CatalogoFrecuenciaPagoDropdown(
                        selectedItem: CatalogoFrecuenciaItem(
                          valor: state.periodicidadInteresCodigo,
                          nombre: state.periodicidadInteresNombre,
                          meses: '',
                        ),
                        isRequired: true,
                        onChanged: (item) {
                          if (item == null) return;
                          cubit.onFieldChanged(
                            () => state.copyWith(
                              periodicidadInteresCodigo: item.valor,
                            ),
                          );
                        },
                        title: 'Periodicidad interes',
                        validator: (value) =>
                            ClassValidator.validateRequired(value?.valor),
                      ),
                      const Gap(12),
                      TiposCreditoDropdown(
                        selectedItem: Item(
                          name: state.tipoCreditoNombre,
                          value: state.tipoCreditoNombre,
                        ),
                        // selectedItem: tipoCredito,
                        isRequired: true,
                        validator: (value) => ClassValidator.validateRequired(
                            value?.value.toString()),
                        onChanged: (item) {
                          if (item == null) return;
                          cubit.onFieldChanged(
                            () => state.copyWith(
                              tipoCreditoNombre: item.name,
                            ),
                          );
                        },
                      ),
                      const Gap(12),
                      SearchDropdownWidget(
                        selectedItem: Item(
                          name: state.tipoProgramaNombre,
                          value: state.tipoProgramaCodigo,
                        ),
                        isRequired: true,
                        // selectedItem: programa,
                        codigo: CatalogoType.programa.codigo,
                        validator: (value) =>
                            ClassValidator.validateRequired(value?.value),
                        title: 'Programa',
                        onChanged: (item) {
                          if (item == null) return;
                          cubit.onFieldChanged(
                            () => state.copyWith(
                              tipoProgramaCodigo: item.value,
                            ),
                          );
                        },
                      ),
                      const Gap(12),
                      OutlineTextfieldWidget(
                        initialValue: state.observacion,
                        title: 'Observaciones',
                        // validator: (value) => ClassValidator.validateRequired(value),
                        icon: Icon(
                          Icons.comment,
                          color: AppColors.getPrimaryColor(),
                        ),
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => state.copyWith(
                              observacion: value,
                            ),
                          );
                        },
                      ),
                      const Gap(10),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: CustomElevatedButton(
                          color: Colors.indigo,
                          text: state.status == Status.inProgress
                              ? 'Enviando...'
                              : 'Guardar configuración',
                          icon: const Icon(
                            Icons.send_and_archive_sharp,
                            color: Colors.white,
                          ),
                          enabled: state.status != Status.inProgress,
                          onPressed: () {
                            if (!formKey.currentState!.validate()) return;

                            cubit.crearConfigurationGrupal(
                              cicloGrupoId: actasIntegrantesCubit
                                  .state.data.first.cicloGrupoId,
                            );
                          },
                        ),
                      ),
                      const Gap(20),
                    ],
                  ),
                ),
              ),
            ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
