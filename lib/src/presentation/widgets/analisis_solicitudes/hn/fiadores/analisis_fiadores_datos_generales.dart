import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/catalogo/catalogo_local_db.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_fiadores/analisis_fiadores_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/parametros_type/parametros_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AnalisisFiadoresDatosGenerales extends StatefulWidget {
  final String? cedula;
  final String? primerNombre;
  final String? segundoNombre;
  final String? primerApellido;
  final String? segundoApellido;
  final DateTime? fechaNacimiento;
  final String? sexo;
  final String? pais;
  final String? departamento;
  final String? municipio;
  final String? direccion;
  final DateTime? fechaEmision;
  final DateTime? fechaExpira;
  final String? tipoDocumento;
  final PageController pageController;
  const AnalisisFiadoresDatosGenerales({
    super.key,
    required this.pageController,
    this.cedula,
    this.primerNombre,
    this.segundoNombre,
    this.primerApellido,
    this.segundoApellido,
    this.fechaNacimiento,
    this.sexo,
    this.pais,
    this.departamento,
    this.municipio,
    this.direccion,
    this.fechaEmision,
    this.fechaExpira,
    this.tipoDocumento,
  });

  @override
  State<AnalisisFiadoresDatosGenerales> createState() =>
      _AnalisisFiadoresDatosGeneralesState();
}

class _AnalisisFiadoresDatosGeneralesState
    extends State<AnalisisFiadoresDatosGenerales>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormState>();
  CatalogoLocalDb? edadMinima;
  CatalogoLocalDb? edadMaxima;
  final localDpProvider = global<SolicitudesHnBoxService>();
  DateTime? _selectedDate;
  DateTime? fechaVencimientoCedula;
  DateTime? fechaEmisionCedula;
  DateTime? fechaNacimiento;

  @override
  void initState() {
    super.initState();
    edadMinima = global<SolicitudesHnBoxService>()
        .getParametroByName(nombre: ParametroType.edadMinimaCliente.codigo);
    edadMaxima = global<SolicitudesHnBoxService>()
        .getParametroByName(nombre: ParametroType.edadMaximaCliente.codigo);
    fechaEmisionCedula = widget.fechaEmision;
    fechaVencimientoCedula = widget.fechaExpira;
    fechaNacimiento = widget.fechaNacimiento;
    final cubit = context.read<AnalisisFiadoresCubit>();
    cubit.onFieldChanged(
      () => cubit.state.copyWith(
        fechaEmisionCedula: fechaEmisionCedula?.toUtc().toIso8601String(),
        fechaNacimiento: fechaNacimiento?.toUtc().toIso8601String(),
        fechaVencimientoCedula: _selectedDate?.toUtc().toIso8601String(),
        cedula: widget.cedula,
        nombre1: widget.primerNombre,
        nombre2: widget.segundoNombre,
        apellido1: widget.primerApellido,
        apellido2: widget.segundoApellido,
        sexoCodigo: widget.sexo,
        tipoDocumentoCodigo: widget.tipoDocumento,
        direccion: widget.direccion,
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    // final DateTime minFechaVencimiento = DateTime(
    //   fechaEmisionCedula!.year + 10,
    //   fechaEmisionCedula!.month,
    //   fechaEmisionCedula!.day,
    // );
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      keyboardType: TextInputType.datetime,
      firstDate: DateTime(1930),
      lastDate: DateTime(2101),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != _selectedDate) {
      if (!context.mounted) return;
      if (picked.isBefore(DateTime.now())) {
        CustomAlertDialog(
          onDone: () => context.pop(),
          context: context,
          title: 'La Fecha no puede ser antes a la fecha actual',
        ).showDialog(context, dialogType: DialogType.warning);
        return;
      }

      _selectedDate = picked;
      fechaVencimientoCedula = picked;
      context.read<AnalisisFiadoresCubit>().onFieldChanged(
            () => context.read<AnalisisFiadoresCubit>().state.copyWith(
                  fechaVencimientoCedula:
                      _selectedDate?.toUtc().toIso8601String(),
                ),
          );
      setState(() {});
    }
  }

  Future<void> selectEmisionFecha(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fechaEmisionCedula,
      firstDate: DateTime(1930),
      lastDate: DateTime(2101),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != fechaEmisionCedula) {
      if (!context.mounted) return;
      if (picked.isAfter(DateTime.now())) {
        CustomAlertDialog(
          onDone: () => context.pop(),
          context: context,
          title: 'La Fecha no puede ser después a la fecha actual',
        ).showDialog(context, dialogType: DialogType.warning);
        return;
      }
      fechaEmisionCedula = picked;
      context.read<AnalisisFiadoresCubit>().onFieldChanged(
            () => context.read<AnalisisFiadoresCubit>().state.copyWith(
                  fechaEmisionCedula:
                      fechaEmisionCedula?.toUtc().toIso8601String(),
                ),
          );
      setState(() {});
    }
  }

  Future<void> selectFechaNacimiento(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime eighteenYearsAgo = DateTime(
      now.year - int.parse(edadMinima?.valor ?? '0'),
      now.month,
      now.day,
    );
    final DateTime maxAgeClient = DateTime(
      now.year - int.parse(edadMaxima?.valor ?? '0'),
      now.month,
      now.day,
    );

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fechaNacimiento,
      firstDate: maxAgeClient,
      lastDate: eighteenYearsAgo,
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null) {
      if (!context.mounted) return;
      if (picked.isAfter(DateTime.now())) {
        CustomAlertDialog(
          onDone: () => context.pop(),
          context: context,
          title: 'La Fecha no puede ser después a la fecha actual',
        ).showDialog(context, dialogType: DialogType.warning);
        return;
      }

      fechaNacimiento = picked;
      context.read<AnalisisFiadoresCubit>().onFieldChanged(
            () => context.read<AnalisisFiadoresCubit>().state.copyWith(
                  fechaNacimiento: fechaNacimiento?.toUtc().toIso8601String(),
                ),
          );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<AnalisisFiadoresCubit>();
    return BlocBuilder<AnalisisFiadoresCubit, AnalisisFiadoresState>(
      builder: (context, state) {
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                Container(
                  margin: const EdgeInsets.all(18),
                  child: Text(
                    'Datos Generales',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                OutlineTextfieldWidget(
                  initialValue: widget.cedula,
                  readOnly: true,
                  title: 'Cédula Identidad:',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(() => cubit.state.copyWith(
                          cedula: value,
                        ));
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: widget.primerNombre,
                  title: 'Primer Nombre:',
                  icon: const Icon(Icons.document_scanner),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  validator: (value) => ClassValidator.validateRequired(value),
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        nombre1: value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: widget.segundoNombre,
                  title: 'Segundo Nombre:',
                  icon: const Icon(Icons.document_scanner),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        nombre2: value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: widget.primerApellido,
                  title: 'Primer Apellido:',
                  icon: const Icon(Icons.document_scanner),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  validator: (value) => ClassValidator.validateRequired(value),
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        apellido1: value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  initialValue: widget.segundoApellido,
                  title: 'Segundo Apellido:',
                  icon: const Icon(Icons.document_scanner),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        apellido2: value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                SearchDropdownWidget(
                  codigo: 'TIPODOCUMENTOPERSONA',
                  selectedItem: Item(
                    name: widget.tipoDocumento ?? '',
                    value: widget.tipoDocumento ?? '',
                  ),
                  title: 'Tipo de Documento:',
                  onChanged: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        tipoDocumentoCodigo: value?.value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  hintText: fechaNacimiento?.selectorFormat(),
                  title: 'Fecha de Nacimiento:',
                  icon: const Icon(Icons.document_scanner),
                  readOnly: true,
                  validator: (value) => ClassValidator.validateRequired(
                      fechaNacimiento?.selectorFormat()),
                  onTap: () => selectFechaNacimiento(context),
                  onChange: (value) {},
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  title: 'Personas a su cargo:',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        personasACargo: int.tryParse(value) ?? 0,
                      ),
                    );
                  },
                ),
                const Gap(20),
                CatalogoValorNacionalidad(
                  codigo: 'PAIS',
                  title: 'País de nacimiento:',
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.valor),
                  onChanged: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        paisNacimientoCodigo: value?.valor,
                      ),
                    );
                  },
                  hintText: 'Selecciona una opción',
                ),
                if (widget.tipoDocumento != 'CEDULAIDENTIDAD') ...[
                  const Gap(20),
                  OutlineTextfieldWidget(
                    hintText: fechaEmisionCedula?.selectorFormat(),
                    title: 'Fecha emision cédula:',
                    icon: const Icon(Icons.document_scanner),
                    readOnly: true,
                    validator: (value) => ClassValidator.validateRequired(
                        fechaEmisionCedula?.selectorFormat()),
                    onChange: (value) {},
                    onTap: () => selectEmisionFecha(context),
                  ),
                ],
                const Gap(20),
                OutlineTextfieldWidget(
                  hintText: fechaVencimientoCedula?.selectorFormat(),
                  title: 'Fecha Vencimiento cedula:',
                  icon: const Icon(Icons.document_scanner),
                  validator: (value) => ClassValidator.validateRequired(
                      fechaVencimientoCedula?.selectorFormat()),
                  readOnly: true,
                  onTap: () => selectDate(context),
                ),
                const Gap(20),
                SearchDropdownWidget(
                  selectedItem: Item(
                    name: widget.sexo ?? '',
                    value: widget.sexo ?? '',
                  ),
                  codigo: 'SEXO',
                  title: 'Sexo:',
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  onChanged: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        sexoCodigo: value?.value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                SearchDropdownWidget(
                  codigo: 'ESTADOCIVIL',
                  title: 'Estado civil:',
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  onChanged: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        estadoCivilCodigo: value?.value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                SearchDropdownWidget(
                  codigo: 'RELACIONPERSONAS',
                  title: 'Relación con el cliente:',
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  onChanged: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        relacionClienteCodigo: value?.value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  title: 'RTN:',
                  icon: const Icon(Icons.document_scanner),
                  textInputType: TextInputType.number,
                  validator: (value) => ClassValidator.validateRTN(value),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(14),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        rtn: value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomElevatedButton(
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;
                      widget.pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    text: 'Siguiente',
                    color: Colors.green,
                  ),
                ),
                const Gap(20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomOutLineButton(
                    onPressed: () {
                      context.pop();
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
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
