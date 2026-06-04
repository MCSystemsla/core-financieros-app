import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/snackbar/custom_snackbar.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/datasource/supervisiones/supervisiones_response.dart';
import 'package:core_financiero_app/src/domain/repository/supervisiones/hn/supervisiones_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/supervisiones/supervision_regional/supervision_regional_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/catalogo_frecuencia_pago_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/catalogo_type/catalogo_type.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/loading/loading_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/tipo_supervisor/tipo_supervisor_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SupervisionesFormRegionalHnScreen extends StatelessWidget {
  final SupervisionData data;
  final String tipoSolicitud;
  const SupervisionesFormRegionalHnScreen({
    super.key,
    required this.data,
    required this.tipoSolicitud,
  });

  @override
  Widget build(BuildContext context) {
    final pagecontroller = PageController();
    return BlocProvider(
      create: (ctx) => SupervisionRegionalCubit(
        SupervisionesRepositoryHnImpl(),
      )..setNumberSolicitudAndTipoSolicitud(
          numberSolicitud: int.tryParse(data.numeroSolicitud) ?? 0,
          tipoSolicitud: tipoSolicitud,
        ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Crear Supervision Regional'),
        ),
        body: SafeArea(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pagecontroller,
            children: [
              SupervisionRegionalPage1(
                pagecontroller: pagecontroller,
                data: data,
              ),
              SupervisionRegionalPage2(
                pagecontroller: pagecontroller,
                data: data,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SupervisionRegionalPage2 extends StatefulWidget {
  final PageController pagecontroller;
  final SupervisionData data;
  const SupervisionRegionalPage2({
    super.key,
    required this.pagecontroller,
    required this.data,
  });

  @override
  State<SupervisionRegionalPage2> createState() =>
      _SupervisionRegionalPage2State();
}

class _SupervisionRegionalPage2State extends State<SupervisionRegionalPage2>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final formKey = GlobalKey<FormState>();
    final cubit = context.read<SupervisionRegionalCubit>();
    return BlocConsumer<SupervisionRegionalCubit, SupervisionRegionalState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == Status.inProgress) {
          context.showLoading(message: 'Supervision en proceso');
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
            title: 'Supervision creada exitosamente',
            onDone: () => context.pop(),
          ).showDialog(context, dialogType: DialogType.success);
        }
      },
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        const Gap(10),
                        SheetSearchDropdown(
                          title: '¿El buró de crédito es?',
                          isRequired: true,
                          onChanged: (v) {
                            cubit.onFieldChanged(
                              () => state.copyWith(
                                buroCreditoBueno:
                                    v?.value == SupervisionItem1.bueno,
                                buroCreditoRegular:
                                    v?.value == SupervisionItem1.regular,
                                buroCreditoMalas:
                                    v?.value == SupervisionItem1.malo,
                              ),
                            );
                          },
                          validator: (value) => ClassValidator.validateRequired(
                              value?.value.toString()),
                          hintText: 'Selecciona una garantía',
                          enabled: true,
                          items: const [
                            Item(name: 'Bueno', value: SupervisionItem1.bueno),
                            Item(
                                name: 'Regular',
                                value: SupervisionItem1.regular),
                            Item(name: 'Malo', value: SupervisionItem1.malo),
                          ],
                        ),
                        const Gap(10),
                        SheetSearchDropdown(
                          title: '¿La referencia de la comunidad es?',
                          isRequired: true,
                          onChanged: (v) {
                            cubit.onFieldChanged(
                              () => state.copyWith(
                                referenciaComunidadBuena:
                                    v?.value == SupervisionItem1.bueno,
                                referenciaComunidadMala:
                                    v?.value == SupervisionItem1.malo,
                                referenciaComunidadRegular:
                                    v?.value == SupervisionItem1.regular,
                              ),
                            );
                          },
                          validator: (value) => ClassValidator.validateRequired(
                              value?.value.toString()),
                          hintText: 'Selecciona una garantía',
                          enabled: true,
                          items: const [
                            Item(name: 'Bueno', value: SupervisionItem1.bueno),
                            Item(
                                name: 'Regular',
                                value: SupervisionItem1.regular),
                            Item(name: 'Malo', value: SupervisionItem1.malo),
                          ],
                        ),
                        const Gap(10),
                        OutlineTextfieldWidget(
                          title: 'Nombre de referencia de comunidad 1',
                          icon: const Icon(Icons.food_bank),
                          inputFormatters: [
                            UpperCaseTextFormatter(),
                          ],
                          onChange: (value) {
                            cubit.onFieldChanged(
                              () => state.copyWith(
                                nombreRefComunidad1: value,
                              ),
                            );
                          },
                        ),
                        const Gap(10),
                        OutlineTextfieldWidget(
                          title: 'Dirección de referencia de comunidad 1',
                          icon: const Icon(Icons.food_bank),
                          inputFormatters: [
                            UpperCaseTextFormatter(),
                          ],
                          onChange: (value) {
                            cubit.onFieldChanged(
                              () => state.copyWith(
                                direccionRefComunidad1: value,
                              ),
                            );
                          },
                        ),
                        const Gap(10),
                        SheetSearchDropdown(
                          title: '¿La segunda referencia de la comunidad es?',
                          isRequired: true,
                          onChanged: (v) {
                            cubit.onFieldChanged(
                              () => state.copyWith(
                                referenciaComunidadBuena2:
                                    v?.value == SupervisionItem1.bueno,
                                referenciaComunidadMala2:
                                    v?.value == SupervisionItem1.malo,
                                referenciaComunidadRegular2:
                                    v?.value == SupervisionItem1.regular,
                              ),
                            );
                          },
                          validator: (value) => ClassValidator.validateRequired(
                              value?.value.toString()),
                          hintText: 'Selecciona una garantía',
                          enabled: true,
                          items: const [
                            Item(name: 'Bueno', value: SupervisionItem1.bueno),
                            Item(
                                name: 'Regular',
                                value: SupervisionItem1.regular),
                            Item(name: 'Malo', value: SupervisionItem1.malo),
                          ],
                        ),
                        const Gap(10),
                        OutlineTextfieldWidget(
                          title: 'Nombre de referencia de comunidad 2',
                          icon: const Icon(Icons.food_bank),
                          inputFormatters: [
                            UpperCaseTextFormatter(),
                          ],
                          onChange: (value) {
                            cubit.onFieldChanged(
                              () => state.copyWith(
                                nombreRefComunidad2: value,
                              ),
                            );
                          },
                        ),
                        const Gap(10),
                        OutlineTextfieldWidget(
                          title: 'Dirección de referencia de comunidad 2',
                          icon: const Icon(Icons.food_bank),
                          inputFormatters: [
                            UpperCaseTextFormatter(),
                          ],
                          onChange: (value) {
                            cubit.onFieldChanged(
                              () => state.copyWith(
                                direccionRefComunidad2: value,
                              ),
                            );
                          },
                        ),
                        SheetSearchDropdown(
                          title: '¿La vivienda es?',
                          isRequired: true,
                          onChanged: (v) {
                            cubit.onFieldChanged(
                              () => state.copyWith(
                                tipoViviendaAlquilada:
                                    v?.value == SupervisionItem2.alquiler,
                                tipoViviendaPropia:
                                    v?.value == SupervisionItem2.propia,
                                tipoViviendaFamiliar:
                                    v?.value == SupervisionItem2.casaDeTrabajo,
                              ),
                            );
                          },
                          validator: (value) => ClassValidator.validateRequired(
                              value?.value.toString()),
                          hintText: 'Selecciona una garantía',
                          enabled: true,
                          items: const [
                            Item(
                                name: 'Alquiler',
                                value: SupervisionItem2.alquiler),
                            Item(
                                name: 'Propia', value: SupervisionItem2.propia),
                            Item(
                              name: 'Casa de trabajo',
                              value: SupervisionItem2.casaDeTrabajo,
                            ),
                          ],
                        ),
                        const Gap(10),
                        SheetSearchDropdown(
                          title: '¿El conocimiento del negocio es?',
                          isRequired: true,
                          onChanged: (v) {
                            cubit.onFieldChanged(
                              () => state.copyWith(
                                conocimientoNegocioAlto:
                                    v?.value == SupervisionItem1.bueno,
                                conocimientoNegocioMedio:
                                    v?.value == SupervisionItem1.regular,
                                conocimientoNegocioBajo:
                                    v?.value == SupervisionItem1.malo,
                              ),
                            );
                          },
                          validator: (value) => ClassValidator.validateRequired(
                              value?.value.toString()),
                          hintText: 'Selecciona una garantía',
                          enabled: true,
                          items: const [
                            Item(name: 'Alto', value: SupervisionItem1.bueno),
                            Item(
                                name: 'Medio', value: SupervisionItem1.regular),
                            Item(name: 'Bajo', value: SupervisionItem1.malo),
                          ],
                        ),
                        const Gap(10),
                        SheetSearchDropdown(
                          title: '¿El nivel de ventas es acorde?',
                          isRequired: true,
                          onChanged: (v) {
                            cubit.onFieldChanged(
                              () => state.copyWith(
                                nivelVentasAcordeSi:
                                    v?.value == SupervisionItem3.si,
                                nivelVentasAcordeNo:
                                    v?.value == SupervisionItem3.no,
                                nivelVentasAcordeNa:
                                    v?.value == SupervisionItem3.na,
                              ),
                            );
                          },
                          validator: (value) => ClassValidator.validateRequired(
                              value?.value.toString()),
                          hintText: 'Selecciona una garantía',
                          enabled: true,
                          items: const [
                            Item(name: 'Si', value: SupervisionItem3.si),
                            Item(name: 'No', value: SupervisionItem3.no),
                            Item(name: 'No aplica', value: SupervisionItem3.na),
                          ],
                        ),
                        SheetSearchDropdown(
                          title:
                              '¿La realidad del cliente coincide con la información brindada?',
                          isRequired: true,
                          onChanged: (v) {
                            cubit.onFieldChanged(
                              () => state.copyWith(
                                realidadClienteSi:
                                    v?.value == SupervisionItem3.si,
                                realidadClienteNo:
                                    v?.value == SupervisionItem3.no,
                                realidadClienteNa:
                                    v?.value == SupervisionItem3.na,
                              ),
                            );
                          },
                          validator: (value) => ClassValidator.validateRequired(
                              value?.value.toString()),
                          hintText: 'Selecciona una garantía',
                          enabled: true,
                          items: const [
                            Item(name: 'Si', value: SupervisionItem3.si),
                            Item(name: 'No', value: SupervisionItem3.no),
                            Item(name: 'No aplica', value: SupervisionItem3.na),
                          ],
                        ),
                        const Gap(10),
                        SheetSearchDropdown(
                          title:
                              '¿La razón cuota es aceptable? ${widget.data.cuota.toCurrencyString()}',
                          isRequired: true,
                          onChanged: (v) {
                            cubit.onFieldChanged(
                              () => state.copyWith(
                                razonCuotaSi: v?.value == SupervisionItem3.si,
                                razonCuotaNo: v?.value == SupervisionItem3.no,
                                razonCuotaNa: v?.value == SupervisionItem3.na,
                              ),
                            );
                          },
                          validator: (value) => ClassValidator.validateRequired(
                              value?.value.toString()),
                          hintText: 'Selecciona una garantía',
                          enabled: true,
                          items: const [
                            Item(name: 'Si', value: SupervisionItem3.si),
                            Item(name: 'No', value: SupervisionItem3.no),
                            Item(name: 'No aplica', value: SupervisionItem3.na),
                          ],
                        ),
                        const Gap(10),
                        SheetSearchDropdown(
                          title:
                              '¿La razón de endeudamiento es aceptable? ${widget.data.razonEndeudamiento.toCurrencyString()}',
                          isRequired: true,
                          onChanged: (v) {
                            cubit.onFieldChanged(
                              () => state.copyWith(
                                razonEndeudamientoSi:
                                    v?.value == SupervisionItem3.si,
                                razonEndeudamientoNo:
                                    v?.value == SupervisionItem3.no,
                                razonEndeudamientoNa:
                                    v?.value == SupervisionItem3.na,
                              ),
                            );
                          },
                          validator: (value) => ClassValidator.validateRequired(
                              value?.value.toString()),
                          hintText: 'Selecciona una garantía',
                          enabled: true,
                          items: const [
                            Item(name: 'Si', value: SupervisionItem3.si),
                            Item(name: 'No', value: SupervisionItem3.no),
                            Item(name: 'No aplica', value: SupervisionItem3.na),
                          ],
                        ),
                        const Gap(10),
                        SheetSearchDropdown(
                          title: '¿La garantía fue revisada?',
                          isRequired: true,
                          onChanged: (v) {
                            cubit.onFieldChanged(
                              () => state.copyWith(
                                garantiaRevisadaSi:
                                    v?.value == SupervisionItem3.si,
                                garantiaRevisadaNo:
                                    v?.value == SupervisionItem3.no,
                                garantiaRevisadaNa:
                                    v?.value == SupervisionItem3.na,
                              ),
                            );
                          },
                          validator: (value) => ClassValidator.validateRequired(
                              value?.value.toString()),
                          hintText: 'Selecciona una garantía',
                          enabled: true,
                          items: const [
                            Item(name: 'Si', value: SupervisionItem3.si),
                            Item(name: 'No', value: SupervisionItem3.no),
                            Item(name: 'No aplica', value: SupervisionItem3.na),
                          ],
                        ),
                        const Gap(10),
                        SheetSearchDropdown(
                          title: '¿El fiador fue revisado?',
                          isRequired: true,
                          onChanged: (v) {
                            cubit.onFieldChanged(
                              () => state.copyWith(
                                fiadorRevisadoSi:
                                    v?.value == SupervisionItem3.si,
                                fiadorRevisadoNo:
                                    v?.value == SupervisionItem3.no,
                                fiadorRevisadoNa:
                                    v?.value == SupervisionItem3.na,
                              ),
                            );
                          },
                          validator: (value) => ClassValidator.validateRequired(
                              value?.value.toString()),
                          hintText: 'Selecciona una garantía',
                          enabled: true,
                          items: const [
                            Item(name: 'Si', value: SupervisionItem3.si),
                            Item(name: 'No', value: SupervisionItem3.no),
                            Item(name: 'No aplica', value: SupervisionItem3.na),
                          ],
                        ),
                        const Gap(10),
                        SearchDropdownWidget(
                          isRequired: true,
                          validator: (value) =>
                              ClassValidator.validateRequired(value?.value),
                          hintText: 'Selecciona producto',
                          codigo: CatalogoType.producto.codigo,
                          onChanged: (item) {
                            if (item == null) return;
                            cubit.onFieldChanged(
                              () => state.copyWith(
                                productoCodigo: item.value,
                              ),
                            );
                          },
                          title: 'Producto Crediticio ${widget.data.producto}',
                        ),
                        CatalogoFrecuenciaPagoDropdown(
                          title:
                              'Frecuencia de pago ${widget.data.frecuenciaPago}',
                          isRequired: true,
                          onChanged: (v) {
                            cubit.onFieldChanged(
                              () => state.copyWith(
                                frecuenciaCodigo: v?.valor,
                              ),
                            );
                          },
                        ),
                        const Gap(10),
                        OutlineTextfieldWidget(
                          title: 'Información socioeconómica',
                          icon: const Icon(Icons.food_bank),
                          inputFormatters: [
                            UpperCaseTextFormatter(),
                          ],
                          onChange: (value) {
                            cubit.onFieldChanged(
                              () => state.copyWith(
                                infoSocioEconomica: value,
                              ),
                            );
                          },
                        ),
                        const Gap(10),
                        OutlineTextfieldWidget(
                          title: 'Información financiera',
                          icon: const Icon(Icons.food_bank),
                          inputFormatters: [
                            UpperCaseTextFormatter(),
                          ],
                          onChange: (value) {
                            cubit.onFieldChanged(
                              () => state.copyWith(
                                infoFinanciera: value,
                              ),
                            );
                          },
                        ),
                        const Gap(10),
                        OutlineTextfieldWidget(
                          title: 'Recomendación final',
                          icon: const Icon(Icons.food_bank),
                          inputFormatters: [
                            UpperCaseTextFormatter(),
                          ],
                          onChange: (value) {
                            cubit.onFieldChanged(
                              () => state.copyWith(
                                recomendacionFinal: value,
                              ),
                            );
                          },
                        ),
                        const Gap(10),
                        OutlineTextfieldWidget(
                          title: 'Tiempo del negocio',
                          textInputType: TextInputType.number,
                          icon: const Icon(Icons.food_bank),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChange: (value) {
                            cubit.onFieldChanged(
                              () => cubit.state.copyWith(
                                tiempoNegocio: value,
                              ),
                            );
                          },
                        ),
                        const Gap(10),
                        OutlineTextfieldWidget(
                          title:
                              'Plazo de la solicitud (meses) ${widget.data.plazoSolicitud}',
                          icon: const Icon(Icons.food_bank),
                          textInputType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChange: (value) {
                            final newValue = int.tryParse(value) ?? 0;
                            cubit.onFieldChanged(
                              () => cubit.state.copyWith(
                                plazo: newValue,
                              ),
                            );
                          },
                        ),
                        const Gap(10),
                        OutlineTextfieldWidget(
                          title:
                              'Monto de la solicitud: ${widget.data.monto.toCurrencyString()}',
                          icon: const Icon(Icons.food_bank),
                          textInputType: TextInputType.number,
                          inputFormatters: [
                            CurrencyInputFormatter(),
                          ],
                          onChange: (value) {
                            final newValue =
                                toNumericString(value, allowPeriod: true);
                            cubit.onFieldChanged(
                              () => cubit.state.copyWith(
                                monto: double.tryParse(newValue) ?? 0,
                              ),
                            );
                          },
                        ),
                        const Gap(25),
                        CustomElevatedButton(
                          onPressed: () {
                            if (!formKey.currentState!.validate()) return;

                            context
                                .read<SupervisionRegionalCubit>()
                                .createSupervisionRegional();
                          },
                          text: 'Enviar',
                          color: Colors.green,
                        ),
                        const Gap(10),
                        CustomElevatedButton(
                          onPressed: () {
                            widget.pagecontroller.previousPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                          text: 'Anterior',
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                  const Gap(20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class SupervisionRegionalPage1 extends StatelessWidget {
  final SupervisionData data;
  final PageController pagecontroller;
  const SupervisionRegionalPage1({
    super.key,
    required this.data,
    required this.pagecontroller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
            Container(
              margin: const EdgeInsets.all(18),
              child: Text(
                'Supervisiones de Regional',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const Gap(10),
            OutlineTextfieldWidget(
              initialValue: data.fecha.selectorFormat(),
              readOnly: true,
              title: 'Fecha',
              icon: const Icon(Icons.food_bank),
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              onChange: (value) {
                // cubit.onFieldChanged(
                //   () => cubit.state.copyWith(),
                // );
              },
            ),
            const Gap(10),
            OutlineTextfieldWidget(
              initialValue: data.nombrePromotor,
              readOnly: true,
              title: 'Oficial de credito',
              icon: const Icon(Icons.food_bank),
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              onChange: (value) {
                // cubit.onFieldChanged(
                //   () => cubit.state.copyWith(),
                // );
              },
            ),
            const Gap(10),
            OutlineTextfieldWidget(
              initialValue: data.nombreCliente,
              readOnly: true,
              title: 'Cliente',
              icon: const Icon(Icons.food_bank),
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              onChange: (value) {
                // cubit.onFieldChanged(
                //   () => cubit.state.copyWith(),
                // );
              },
            ),
            const Gap(10),
            OutlineTextfieldWidget(
              initialValue: data.sectorComercialNombre,
              readOnly: true,
              title: 'Actividad economica',
              icon: const Icon(Icons.food_bank),
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              onChange: (value) {
                // cubit.onFieldChanged(
                //   () => cubit.state.copyWith(),
                // );
              },
            ),
            const Gap(10),
            OutlineTextfieldWidget(
              initialValue: data.destino,
              readOnly: true,
              title: 'Destino del credito',
              icon: const Icon(Icons.food_bank),
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              onChange: (value) {
                // cubit.onFieldChanged(
                //   () => cubit.state.copyWith(),
                // );
              },
            ),
            const Gap(25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  CustomElevatedButton(
                    onPressed: () {
                      pagecontroller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    text: 'Siguiente',
                    color: Colors.green,
                  ),
                  const Gap(10),
                  CustomElevatedButton(
                    onPressed: () {
                      pagecontroller.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    text: 'Anterior',
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
