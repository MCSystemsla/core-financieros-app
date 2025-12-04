import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/select_date/select_date_helper.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/garantias/analisis_garantia_credito_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_garantia_detalle/analisis_garantia_detalle_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/switch/custom_switch.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AnalisisGarantiaFormPrendario extends StatefulWidget {
  final int dpfsId;
  final int objAnalisisGarantiaID;
  final String? descripcion;
  final int? articuloGarantiaCodigo;

  const AnalisisGarantiaFormPrendario({
    super.key,
    required this.dpfsId,
    required this.objAnalisisGarantiaID,
    this.articuloGarantiaCodigo,
    this.descripcion,
  });

  @override
  State<AnalisisGarantiaFormPrendario> createState() =>
      _AnalisisGarantiaFormPrendarioState();
}

class _AnalisisGarantiaFormPrendarioState
    extends State<AnalisisGarantiaFormPrendario> {
  int? cantidad;
  double? valorComercial;
  String? marca;
  String? modelo;
  String? color;
  String? serie;
  String? numeroPropiedad;
  String? tomo;
  String? asiento;
  String? nombreDuenoPropiedad;
  String? cedulaDuenoPropiedad;
  String? localizacion;
  String? direccion;
  String? numeroEscritura;
  String? numeroEscrituraPublica;
  DateTime? fechaElaboracionEscritura;
  DateTime? fechaDeIngreso;
  DateTime? fechaInscripcion;
  DateTime? fechaVencimiento;
  String? notarioElaboracionEscritura;
  String? descGeneral;
  String? descDetallada;
  String? numEscritura;
  bool inscrito = false;
  String? medidas;
  String? numAsiento;
  String? codValuadorCnbs;
  String? departamento;
  String? municipio;
  String? aldea;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: FadeIn(
        child: Container(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 20),
                child: Text(
                  'Ingresa los datos requeridos',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const Gap(12),
              OutlineTextfieldWidget(
                title: 'Cantidad',
                icon: Icon(
                  Icons.inventory_2_outlined,
                  color: AppColors.getPrimaryColor(),
                ),
                textInputType: TextInputType.number,
                validator: (value) => ClassValidator.validateRequired(value),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);

                  cantidad = int.tryParse(newValue) ?? 0;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Valor Comercial',
                icon: Icon(
                  Icons.wallet,
                  color: AppColors.getPrimaryColor(),
                ),
                textInputType: TextInputType.number,
                validator: (value) => ClassValidator.validateRequired(value),
                inputFormatters: [
                  CurrencyInputFormatter(mantissaLength: 0),
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  valorComercial = double.tryParse(newValue);
                },
              ),
              const Gap(20),
              CatalogoValorNacionalidad(
                hintText: 'Ingresa Departamento',
                title: 'Departamento',
                validator: (value) =>
                    ClassValidator.validateRequired(value?.valor),
                where: 'HN',
                onChanged: (v) {
                  if (v == null) return;
                  setState(() {
                    departamento = v.valor;
                  });
                },
                codigo: 'DEP',
              ),
              if (departamento != null) ...[
                const Gap(20),
                CatalogoValorNacionalidad(
                  where: departamento,
                  hintText: 'Ingresa Municipio',
                  title: 'Municipio',
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.valor),
                  onChanged: (v) {
                    if (v == null) return;
                    setState(() {
                      municipio = v.valor;
                    });
                  },
                  codigo: 'MUN',
                ),
              ],
              if (municipio != null) ...[
                const Gap(20),
                CatalogoValorNacionalidad(
                  where: municipio,
                  hintText: 'Ingresa Aldea',
                  title: 'Aldea',
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.valor),
                  onChanged: (v) {
                    if (v == null) return;
                    setState(() {
                      aldea = v.valor;
                    });
                  },
                  codigo: 'ALD',
                ),
              ],
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Marca',
                icon: Icon(
                  Icons.branding_watermark,
                  color: AppColors.getPrimaryColor(),
                ),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  marca = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Modelo',
                icon: Icon(
                  Icons.directions_car_outlined,
                  color: AppColors.getPrimaryColor(),
                ),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  modelo = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Color',
                icon: Icon(
                  Icons.color_lens_outlined,
                  color: AppColors.getPrimaryColor(),
                ),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  color = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Serie',
                icon: Icon(
                  Icons.confirmation_number_outlined,
                  color: AppColors.getPrimaryColor(),
                ),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  serie = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Numero Propiedad',
                icon: Icon(
                  Icons.description_outlined,
                  color: AppColors.getPrimaryColor(),
                ),
                textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChange: (value) {
                  numeroPropiedad = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Tomo',
                icon: Icon(
                  Icons.book_outlined,
                  color: AppColors.getPrimaryColor(),
                ),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  tomo = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Asiento',
                icon: Icon(
                  Icons.folder_outlined,
                  color: AppColors.getPrimaryColor(),
                ),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  asiento = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Nombre Dueño Propiedad',
                icon: Icon(
                  Icons.person_outline,
                  color: AppColors.getPrimaryColor(),
                ),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  nombreDuenoPropiedad = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Cedula Dueño Propiedad',
                icon: Icon(
                  Icons.badge_outlined,
                  color: AppColors.getPrimaryColor(),
                ),
                textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChange: (value) {
                  cedulaDuenoPropiedad = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Localizacion',
                icon: Icon(
                  Icons.pin_drop_outlined,
                  color: AppColors.getPrimaryColor(),
                ),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  localizacion = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Direccion',
                icon: Icon(
                  Icons.home_work_outlined,
                  color: AppColors.getPrimaryColor(),
                ),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  direccion = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Numero de Escritura',
                icon: Icon(
                  Icons.article_outlined,
                  color: AppColors.getPrimaryColor(),
                ),
                textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChange: (value) {
                  numeroEscritura = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Numero de Escritura Publica',
                icon: Icon(
                  Icons.description_outlined,
                  color: AppColors.getPrimaryColor(),
                ),
                textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChange: (value) {
                  numeroEscrituraPublica = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Fecha de elaboracion de la escritura',
                hintText: fechaElaboracionEscritura?.selectorFormat(),
                icon: Icon(
                  Icons.calendar_month,
                  color: AppColors.getPrimaryColor(),
                ),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                readOnly: true,
                onTap: () async {
                  final picked = await pickDate(
                    context,
                    lastDate: DateTime.now(),
                    locale: Locale(context
                        .read<LangCubit>()
                        .state
                        .currentLang
                        .languageCode),
                  );

                  if (picked != null) {
                    setState(() => fechaElaboracionEscritura = picked);
                  }
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Notario de la escritura',
                icon: Icon(
                  Icons.edit_document,
                  color: AppColors.getPrimaryColor(),
                ),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  notarioElaboracionEscritura = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Desc. General',
                icon: Icon(
                  Icons.notes_outlined,
                  color: AppColors.getPrimaryColor(),
                ),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  descGeneral = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Desc. Detallada',
                icon: Icon(
                  Icons.menu_book_outlined,
                  color: AppColors.getPrimaryColor(),
                ),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  descDetallada = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                hintText: fechaDeIngreso?.selectorFormat(),
                title: 'Fecha de Ingreso',
                icon: Icon(
                  Icons.event_available,
                  color: AppColors.getPrimaryColor(),
                ),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                readOnly: true,
                onTap: () async {
                  final picked = await pickDate(
                    context,
                    lastDate: DateTime.now(),
                    locale: Locale(context
                        .read<LangCubit>()
                        .state
                        .currentLang
                        .languageCode),
                  );

                  if (picked != null) {
                    setState(() => fechaDeIngreso = picked);
                  }
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                hintText: fechaInscripcion?.selectorFormat(),
                title: 'Fecha de Inscripcion',
                icon: Icon(
                  Icons.fact_check_outlined,
                  color: AppColors.getPrimaryColor(),
                ),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                readOnly: true,
                onTap: () async {
                  final picked = await pickDate(
                    context,
                    lastDate: DateTime.now(),
                    locale: Locale(context
                        .read<LangCubit>()
                        .state
                        .currentLang
                        .languageCode),
                  );

                  if (picked != null) {
                    setState(() => fechaInscripcion = picked);
                  }
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                hintText: fechaVencimiento?.selectorFormat(),
                title: 'Fecha de Vencimiento',
                icon: Icon(
                  Icons.hourglass_bottom,
                  color: AppColors.getPrimaryColor(),
                ),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                readOnly: true,
                onTap: () async {
                  final picked = await pickDate(
                    context,
                    locale: Locale(
                      context.read<LangCubit>().state.currentLang.languageCode,
                    ),
                  );

                  if (picked != null) {
                    setState(() => fechaVencimiento = picked);
                  }
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Num Escritura',
                icon: Icon(
                  Icons.assignment_outlined,
                  color: AppColors.getPrimaryColor(),
                ),
                textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChange: (value) {
                  numEscritura = value;
                },
              ),
              const Gap(20),
              CustomSwitch(
                title: 'Inscrito',
                subtitle: 'La garantia esta escrita?',
                value: inscrito,
                onChanged: (v) {
                  setState(() {
                    inscrito = v;
                  });
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Medidas',
                icon: Icon(
                  Icons.straighten_outlined,
                  color: AppColors.getPrimaryColor(),
                ),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  medidas = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Num Asiento',
                icon: Icon(
                  Icons.folder_copy_outlined,
                  color: AppColors.getPrimaryColor(),
                ),
                textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChange: (value) {
                  numAsiento = value;
                },
              ),
              // const Gap(20),
              // OutlineTextfieldWidget(
              //   title: 'Cod Valuador CNBS',
              //   icon: const Icon(Icons.wallet),
              //   inputFormatters: [
              //     UpperCaseTextFormatter(),
              //   ],
              //   onChange: (value) {
              //     codValuadorCnbs = value;
              //   },
              // ),
              const Gap(20),
              BlocConsumer<AnalisisGarantiaDetalleCubit,
                  AnalisisGarantiaDetalleState>(
                listenWhen: (prev, curr) => prev.status != curr.status,
                listener: (context, state) {
                  if (state.status == Status.done) {
                    CustomAlertDialog(
                      context: context,
                      title: 'Detalle de Garantia creado exitosamente',
                      onDone: () => {
                        context.pop(),
                        formKey.currentState?.reset(),
                      },
                    ).showDialog(
                      context,
                      dialogType: DialogType.success,
                    );
                  }
                  if (state.status == Status.error) {
                    CustomAlertDialog(
                      context: context,
                      title: state.errorMsg,
                      onDone: () => {
                        context.pop(),
                      },
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
                      enabled: state.status != Status.inProgress,
                      text: state.status == Status.inProgress
                          ? 'Creando...'
                          : 'Crear',
                      // ignore: deprecated_member_use
                      color: AppColors.greenLatern.withOpacity(0.4),
                      onPressed: () {
                        if (!formKey.currentState!.validate()) return;
                        context
                            .read<AnalisisGarantiaDetalleCubit>()
                            .createAnalisisDetalle(
                              analisisGarantiaDetalle: AnalisisGarantiaDetalle(
                                objCuentaDPFID: widget.dpfsId,
                                cantidad: cantidad!,
                                articuloGarantiaCodigo:
                                    widget.articuloGarantiaCodigo,
                                valorComercial: valorComercial!,
                                descripcion: widget.descripcion,
                                objAnalisisGarantiaID:
                                    widget.objAnalisisGarantiaID,
                                asiento: asiento,
                                cedulaDuenoPropiedad: cedulaDuenoPropiedad,
                                codValuadorCnbs: codValuadorCnbs,
                                color: color,
                                descDetallada: descDetallada,
                                descGeneral: descGeneral,
                                fechaElaboracionEscritura:
                                    fechaElaboracionEscritura,
                                direccion: direccion,
                                inscrito: inscrito,
                                marca: marca,
                                localizacion: localizacion,
                                medidas: medidas,
                                modelo: modelo,
                                nombreDuenoPropiedad: nombreDuenoPropiedad,
                                numeroEscritura: numeroEscritura,
                                numeroPropiedad: numeroPropiedad,
                                numeroEscrituraPublica: numeroEscrituraPublica,
                                notarioElaboracionEscritura:
                                    notarioElaboracionEscritura,
                                numAsiento: numAsiento,
                                numEscritura: numEscritura,
                                tomo: tomo,
                                serie: serie,
                                fechaIngreso: fechaDeIngreso,
                                fechaVencimiento: fechaVencimiento,
                                fechaInscripcion: fechaInscripcion,
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
  }
}
