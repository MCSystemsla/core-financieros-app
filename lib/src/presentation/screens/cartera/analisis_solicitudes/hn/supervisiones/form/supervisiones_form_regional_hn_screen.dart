import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/datasource/supervisiones/supervisiones_response.dart';
import 'package:core_financiero_app/src/domain/repository/supervisiones/hn/supervisiones_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/supervisiones/supervision_regional/supervision_regional_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/catalogo_frecuencia_pago_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/form_step_header_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/sending_supervision_view.dart';
import 'package:core_financiero_app/src/utils/extensions/catalogo_type/catalogo_type.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/tipo_supervisor/tipo_supervisor_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';

class SupervisionesFormRegionalHnScreen extends StatefulWidget {
  final SupervisionData data;
  final String tipoSolicitud;
  const SupervisionesFormRegionalHnScreen({
    super.key,
    required this.data,
    required this.tipoSolicitud,
  });

  @override
  State<SupervisionesFormRegionalHnScreen> createState() =>
      _SupervisionesFormRegionalHnScreenState();
}

class _SupervisionesFormRegionalHnScreenState
    extends State<SupervisionesFormRegionalHnScreen> {
  final pagecontroller = PageController();

  @override
  void dispose() {
    pagecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    return BlocProvider(
      create: (ctx) => SupervisionRegionalCubit(
        SupervisionesRepositoryHnImpl(),
      )..setNumberSolicitudAndTipoSolicitud(
          numberSolicitud: int.tryParse(data.numeroSolicitud) ?? 0,
          tipoSolicitud: widget.tipoSolicitud,
        ),
      child: Scaffold(
        backgroundColor: RedesignColors.background,
        body: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  FormStepHeaderWidget(
                    title: 'Supervisión regional',
                    subtitle:
                        'Solicitud #${data.numeroSolicitud} · ${data.nombreCliente}',
                    tag: 'Supervisión',
                    controller: pagecontroller,
                    onBack: () => Navigator.pop(context),
                    // Same order as the PageView children below.
                    steps: const [
                      'Datos del cliente',
                      'Evaluación',
                    ],
                  ),
                  Expanded(
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
                ],
              ),
            ),
            BlocBuilder<SupervisionRegionalCubit, SupervisionRegionalState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              builder: (context, state) => SendingSupervisionView(
                status: state.status,
                errorMsg: state.errorMsg,
                numeroSolicitud: data.numeroSolicitud,
                tipo: 'regional',
                onRetry: () => context
                    .read<SupervisionRegionalCubit>()
                    .createSupervisionRegional(),
                onReview: () {
                  final cubit = context.read<SupervisionRegionalCubit>();
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(status: Status.notStarted),
                  );
                },
                onClose: () => Navigator.pop(context),
              ),
            ),
          ],
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
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<SupervisionRegionalCubit>();
    // El progreso/resultado del envío lo muestra SendingSupervisionView.
    return BlocBuilder<SupervisionRegionalCubit, SupervisionRegionalState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: RedesignColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: RedesignColors.border),
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
                          color: RedesignColors.green,
                        ),
                        const Gap(10),
                        CustomOutLineButton(
                          onPressed: () {
                            widget.pagecontroller.previousPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                          text: 'Anterior',
                          color: RedesignColors.border,
                          textColor: RedesignColors.ink,
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
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: RedesignColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: RedesignColors.border),
      ),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
            Container(
              margin: const EdgeInsets.fromLTRB(18, 0, 18, 8),
              child: const Text(
                'Datos del cliente',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: RedesignColors.ink,
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
                    color: RedesignColors.green,
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
