import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/catalogo/catalogo_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/ni/analisis_fiadores/analisis_fiadores_ni_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/fiadores/fiador_ni_form_layout.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

/// Paso 1: columna izquierda superior y bloque de sexo/estado civil/relación
/// de la pestaña "Datos personales" del sistema de escritorio de NI.
class AnalisisFiadoresNiDatosPersonales extends StatefulWidget {
  final PageController pageController;
  const AnalisisFiadoresNiDatosPersonales({
    super.key,
    required this.pageController,
  });

  @override
  State<AnalisisFiadoresNiDatosPersonales> createState() =>
      _AnalisisFiadoresNiDatosPersonalesState();
}

class _AnalisisFiadoresNiDatosPersonalesState
    extends State<AnalisisFiadoresNiDatosPersonales>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormState>();
  final localDbProvider = global<ObjectBoxService>();
  CatalogoLocalDb? edadMinima;
  CatalogoLocalDb? edadMaxima;

  @override
  void initState() {
    super.initState();
    edadMinima = localDbProvider.getParametroByName(nombre: 'EDADMINIMACLIENTE');
    edadMaxima = localDbProvider.getParametroByName(nombre: 'EDADMAXIMACLIENTE');
  }

  /// Muestra el nombre del tipo de documento por defecto en vez del código.
  Item? _tipoDocumentoItem(String codigo) {
    if (codigo.isEmpty) return null;
    final catalogo = localDbProvider
        .findParentescosByNombre(type: 'TIPODOCUMENTOPERSONA')
        .where((e) => e.valor == codigo)
        .firstOrNull;
    return Item(name: catalogo?.nombre ?? codigo, value: codigo);
  }

  String? _edad(DateTime? fechaNacimiento) {
    if (fechaNacimiento == null) return null;
    final now = DateTime.now();
    var edad = now.year - fechaNacimiento.year;
    final cumpleAunNoLlega = now.month < fechaNacimiento.month ||
        (now.month == fechaNacimiento.month && now.day < fechaNacimiento.day);
    if (cumpleAunNoLlega) edad--;
    return '$edad años';
  }

  Future<void> selectFechaNacimiento(BuildContext context) async {
    final cubit = context.read<AnalisisFiadoresNiCubit>();
    final DateTime now = DateTime.now();
    final DateTime minAgeDate = DateTime(
      now.year - int.parse(edadMinima?.valor ?? '0'),
      now.month,
      now.day,
    );
    final DateTime maxAgeDate = DateTime(
      now.year - int.parse(edadMaxima?.valor ?? '0'),
      now.month,
      now.day,
    );

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: cubit.state.fechaNacimiento,
      firstDate: maxAgeDate,
      lastDate: minAgeDate,
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked == null) return;
    if (!context.mounted) return;
    if (picked.isAfter(DateTime.now())) {
      CustomAlertDialog(
        onDone: () => context.pop(),
        context: context,
        title: 'La Fecha no puede ser después a la fecha actual',
      ).showDialog(context, dialogType: DialogType.warning);
      return;
    }
    cubit.onFieldChanged(
      () => cubit.state.copyWith(fechaNacimiento: picked),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<AnalisisFiadoresNiCubit>();
    final flavor = global<FlavorCubit>().state.flavor;
    return BlocBuilder<AnalisisFiadoresNiCubit, AnalisisFiadoresNiState>(
      builder: (context, state) {
        final esCedula = state.tipoDocumentoCodigo == 'CEDULAIDENTIDAD';
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(16),
                FiadorNiSectionCard(
                  label: 'NOMBRES',
                  children: [
                    OutlineTextfieldWidget(
                      initialValue: state.nombre1,
                      title: 'Primer Nombre:',
                      icon: const Icon(Icons.person_outline),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(nombre1: value),
                        );
                      },
                    ),
                    OutlineTextfieldWidget(
                      initialValue: state.nombre2,
                      title: 'Segundo Nombre:',
                      icon: const Icon(Icons.person_outline),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(nombre2: value),
                        );
                      },
                    ),
                    OutlineTextfieldWidget(
                      initialValue: state.apellido1,
                      title: 'Primer Apellido:',
                      icon: const Icon(Icons.person_outline),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(apellido1: value),
                        );
                      },
                    ),
                    OutlineTextfieldWidget(
                      initialValue: state.apellido2,
                      title: 'Segundo Apellido:',
                      icon: const Icon(Icons.person_outline),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(apellido2: value),
                        );
                      },
                    ),
                  ],
                ),
                FiadorNiSectionCard(
                  label: 'NACIMIENTO Y DOCUMENTO',
                  children: [
                    OutlineTextfieldWidget(
                      hintText: state.fechaNacimiento?.selectorFormat(),
                      title: 'Fecha de Nacimiento:',
                      icon: const Icon(Icons.cake_outlined),
                      readOnly: true,
                      validator: (_) => ClassValidator.validateRequired(
                        state.fechaNacimiento?.selectorFormat(),
                      ),
                      onTap: () => selectFechaNacimiento(context),
                      onChange: (_) {},
                    ),
                    // Solo informativa: se calcula de la fecha y no se envía.
                    OutlineTextfieldWidget(
                      readOnly: true,
                      title: 'Edad:',
                      icon: const Icon(Icons.hourglass_empty_outlined),
                      hintText: _edad(state.fechaNacimiento),
                    ),
                    SearchDropdownWidget(
                      codigo: 'TIPODOCUMENTOPERSONA',
                      title: 'Tipo de Documento:',
                      selectedItem:
                          _tipoDocumentoItem(state.tipoDocumentoCodigo),
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      onChanged: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            tipoDocumentoCodigo: value?.value,
                          ),
                        );
                      },
                    ),
                    OutlineTextfieldWidget(
                      initialValue: state.cedula,
                      title: 'Cédula Identidad:',
                      icon: const Icon(Icons.badge_outlined),
                      maxLength: 16,
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      validator: (value) => esCedula
                          ? ClassValidator.validateCedulaByFlavor(value, flavor)
                          : ClassValidator.validateRequired(value),
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(cedula: value),
                        );
                      },
                    ),
                  ],
                ),
                FiadorNiSectionCard(
                  label: 'DATOS PERSONALES',
                  children: [
                    SearchDropdownWidget(
                      codigo: 'SEXO',
                      title: 'Sexo:',
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      onChanged: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(sexoCodigo: value?.value),
                        );
                      },
                    ),
                    SearchDropdownWidget(
                      codigo: 'ESTADOCIVIL',
                      title: 'Estado civil:',
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      onChanged: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            estadoCivilCodigo: value?.value,
                          ),
                        );
                      },
                    ),
                    SearchDropdownWidget(
                      codigo: 'RELACIONPERSONAS',
                      title: 'Relación con el cliente:',
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      onChanged: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            relacionClienteCodigo: value?.value,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                FiadorNiStepButtons(
                  secondaryText: 'Cancelar',
                  secondaryIsDestructive: true,
                  onSecondary: () => Navigator.pop(context),
                  onPrimary: () {
                    if (!formKey.currentState!.validate()) return;
                    widget.pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
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
