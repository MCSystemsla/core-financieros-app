import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_nueva_menor/solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/user_by_cedula/user_by_cedula_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class NuevaMenorDataClientWidget extends StatefulWidget {
  final PageController controller;
  const NuevaMenorDataClientWidget({super.key, required this.controller});

  @override
  State<NuevaMenorDataClientWidget> createState() =>
      _NuevaMenorDataClientWidgetState();
}

class _NuevaMenorDataClientWidgetState extends State<NuevaMenorDataClientWidget>
    with AutomaticKeepAliveClientMixin {
  String? initialValue;
  String? departamentoEmisor;
  DateTime? _selectedDate;
  @override
  void initState() {
    // _selectedDate = DateTime.now();
    super.initState();
  }

  String? tipoPersonaCredito;
  String? nombre1;
  String? nombre2;
  String? apellido1;
  String? apellido2;
  String? tipoDocumento;
  String? paisEmisor;
  String? paisNacimiento;
  String? fechaVencimientoCedula;
  String? sexo;
  String? escolaridad;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final nombrePublicoController = TextEditingController();
    // final fechaNacimientoController = TextEditingController();
    final telefonoController = TextEditingController();
    final celularController = TextEditingController();
    final emailController = TextEditingController();
    final nacionalidadController = TextEditingController();

    super.build(context);

    return BlocBuilder<UserByCedulaCubit, UserByCedulaState>(
      builder: (context, state) {
        if (state is OnUserByCedulaSuccess) {
          nombre1 = state.userCedulaResponse.primerNombre;
          nombre2 = state.userCedulaResponse.segundoNombre;
          apellido1 = state.userCedulaResponse.primerApellido;
          apellido2 = state.userCedulaResponse.segundoApellido;
          sexo = state.userCedulaResponse.sexo;
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                const Gap(30),
                SearchDropdownWidget(
                  // initialValue: '',
                  codigo: 'TIPOSPERSONACREDITO',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    tipoPersonaCredito = item.value;
                    setState(() {});
                  },
                  title: 'Tipo de Persona',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: nombre1,
                  icon: Icon(
                    Icons.person,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Nombre1',
                  textCapitalization: TextCapitalization.words,
                  onChange: (value) {
                    nombre1 = value;
                    setState(() {});
                  },
                  hintText: 'Ingresa Nombre1',
                  isValid: null,
                  isRequired: true,
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  icon: Icon(
                    Icons.person,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Nombre2',
                  initialValue: nombre2,
                  hintText: 'Ingresa Nombre2',
                  textCapitalization: TextCapitalization.words,
                  isValid: null,
                  isRequired: true,
                  onChange: (value) {
                    nombre2 = value;
                    setState(() {});
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: apellido1,
                  icon: Icon(
                    Icons.badge,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Apellido1',
                  hintText: 'Ingresa Apellido1',
                  textCapitalization: TextCapitalization.words,
                  isValid: null,
                  isRequired: true,
                  onChange: (value) {
                    apellido1 = value;
                    setState(() {});
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: apellido2,
                  icon: Icon(
                    Icons.badge,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Apellido2',
                  hintText: 'Ingresa Apellido2',
                  textCapitalization: TextCapitalization.words,
                  isValid: null,
                  isRequired: true,
                  onChange: (value) {
                    apellido2 = value;
                    setState(() {});
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  icon: Icon(
                    Icons.person_2_rounded,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Nombre Publico',
                  textCapitalization: TextCapitalization.words,
                  hintText: 'Ingresa tu nombre publico',
                  isValid: null,
                  textEditingController: nombrePublicoController,
                  isRequired: true,
                ),
                const Gap(30),
                SearchDropdownWidget(
                  // initialValue: '',
                  codigo: 'TIPODOCUMENTOPERSONA',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    tipoDocumento = item.value;
                    setState(() {});
                  },
                  title: 'Tipo Documento',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  readOnly: true,
                  initialValue: state.userCedulaResponse.cedula,
                  icon: Icon(
                    Icons.credit_card,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Cedula',
                  hintText: 'Ingresa Cedula',
                  isValid: null,
                  isRequired: true,
                ),
                const Gap(30),
                CatalogoValorNacionalidad(
                  hintText: 'Selecciona Pais Emisor',
                  // hintText: state.userCedulaResponse.pais,
                  title: 'Pais Emisor',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    paisEmisor = item.valor;
                    setState(() {});
                  },
                  codigo: 'PAIS',
                  // initialValue: paisEmisor ?? '',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  // onTap: () => selectDate(context),
                  readOnly: true,
                  icon: Icon(
                    Icons.calendar_today,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Fecha Emision Cedula',
                  hintText:
                      state.userCedulaResponse.fechaEmision.selectorFormat(),
                  isValid: null,
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: _selectedDate?.selectorFormat() ??
                      'Ingrese Fecha Vencimiento',
                  // initialValue: _selectedDate.selectorFormat(),
                  icon: Icon(
                    Icons.calendar_today,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Fecha Vencimiento Cedula',
                  isValid: null,
                  isRequired: true,
                  readOnly: true,
                  onTap: () => selectDate(context),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  readOnly: true,
                  icon: Icon(
                    Icons.calendar_month,
                    color: AppColors.getPrimaryColor(),
                  ),

                  title: 'FechaNacimiento',
                  hintText:
                      state.userCedulaResponse.fechaNacimiento.selectorFormat(),
                  isValid: null,
                  // textEditingController: fechaNacimientoController,
                  isRequired: true,
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  icon: Icon(
                    Icons.flag,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Nacionalidad',
                  hintText: 'Ingresa Fecha Nacimiento',
                  isValid: null,
                  textEditingController: nacionalidadController,
                  isRequired: true,
                ),
                const Gap(30),
                CatalogoValorNacionalidad(
                  hintText: 'Selecciona Pais de Nacimiento',
                  title: 'Pais de Nacimiento',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    paisNacimiento = item.valor;
                  },
                  codigo: 'PAIS',
                  // initialValue: paisEmisor ?? '',
                ),
                const Gap(30),
                CatalogoValorDropdownWidget(
                  hintText: sexo ?? 'Ingresar Genero',
                  codigo: 'SEXO',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    sexo = item.valor;
                  },
                  title: 'Sexo',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  icon: Icon(
                    Icons.phone,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Telefono',
                  hintText: 'Ingresa Telefono',
                  isValid: null,
                  textEditingController: telefonoController,
                  isRequired: true,
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  icon: Icon(
                    Icons.phone_android,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Celular',
                  hintText: 'Ingresa Celular',
                  isValid: null,
                  textEditingController: celularController,
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  textEditingController: emailController,
                  icon: Icon(
                    Icons.email,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Email',
                  hintText: 'Ingresa Email',
                  isValid: null,
                ),
                const Gap(30),
                SearchDropdownWidget(
                  // initialValue: '',
                  codigo: 'ESCOLARIDAD',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    escolaridad = item.value;
                    // setState(() {});
                  },
                  title: 'Escolaridad',
                ),
                const Gap(30),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: 'Siguiente',
                    color: AppColors.greenLatern.withOpacity(0.4),
                    onPressed: () {
                      context.read<SolicitudNuevaMenorCubit>().saveAnswers(
                            nombre1: nombre1,
                            nombre2: nombre2,
                            apellido1: apellido1,
                            apellido2: apellido2,
                            tipoPersona: tipoPersonaCredito!,
                            objTipoPersonaId: tipoPersonaCredito,
                            cedula: state.userCedulaResponse.cedula,
                            nombrePublico: nombrePublicoController.text.trim(),
                            objPaisEmisorCedula: paisEmisor,
                            fechaEmisionCedula: state
                                .userCedulaResponse.fechaEmision
                                .toIso8601String(),
                            fechaVencimientoCedula:
                                _selectedDate?.toUtc().toIso8601String(),
                            fechaNacimiento: state
                                .userCedulaResponse.fechaNacimiento
                                .toIso8601String(),
                            nacionalidad: nacionalidadController.text.trim(),
                            objPaisNacimientoId: paisNacimiento,
                            objSexoId: state.userCedulaResponse.sexo,
                            telefono: telefonoController.text.trim(),
                            celular: celularController.text.trim(),
                            email: emailController.text.trim(),
                            objEscolaridadId: escolaridad,
                          );

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
                      Navigator.pop(context);
                    },
                    text: 'Cancelar',
                    textColor: AppColors.red,
                    color: AppColors.red,
                  ),
                ),
                const Gap(20),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
