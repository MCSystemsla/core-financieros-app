import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/user_by_cedula/user_by_cedula_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
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
  String? paisEmisor;
  String? departamentoEmisor;
  late DateTime _selectedDate;
  @override
  void initState() {
    _selectedDate = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
        locale:
            Locale(context.read<LangCubit>().state.currentLang.languageCode),
      );
      if (picked != null && picked != _selectedDate) {
        _selectedDate = picked;
        setState(() {});
      }
    }

    super.build(context);

    final nombre1Controller = TextEditingController();
    final fechaNacimientoController = TextEditingController();
    final telefonoController = TextEditingController();
    final celularController = TextEditingController();
    return BlocBuilder<UserByCedulaCubit, UserByCedulaState>(
      builder: (context, state) {
        if (state is OnUserByCedulaSuccess) {
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                const Gap(30),
                CatalogoValorDropdownWidget(
                  initialValue: '',
                  codigo: 'TIPOSPERSONACREDITO',
                  onChanged: (item) {},
                  title: 'Tipo de Persona',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: state.userCedulaResponse.primerNombre,
                  icon: Icon(
                    Icons.person,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Nombre1',
                  textCapitalization: TextCapitalization.words,
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
                  initialValue: state.userCedulaResponse.segundoNombre,
                  hintText: 'Ingresa Nombre2',
                  textCapitalization: TextCapitalization.words,
                  isValid: null,
                  isRequired: true,
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: state.userCedulaResponse.primerApellido,
                  icon: Icon(
                    Icons.badge,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Apellido1',
                  hintText: 'Ingresa Apellido1',
                  textCapitalization: TextCapitalization.words,
                  isValid: null,
                  isRequired: true,
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: state.userCedulaResponse.segundoApellido,
                  icon: Icon(
                    Icons.badge,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Apellido2',
                  hintText: 'Ingresa Apellido2',
                  textCapitalization: TextCapitalization.words,
                  isValid: null,
                  isRequired: true,
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
                  textEditingController: nombre1Controller,
                  isRequired: true,
                ),
                const Gap(30),
                CatalogoValorDropdownWidget(
                  initialValue: state.userCedulaResponse.tipoDocumento,
                  codigo: 'TIPODOCUMENTOPERSONA',
                  onChanged: (item) {},
                  title: 'Tipo Documento',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
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
                    if (item == null) return;
                  },
                  codigo: 'PAIS',
                  // initialValue: paisEmisor ?? '',
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  onTap: () => selectDate(context),
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
                  hintText:
                      state.userCedulaResponse.fechaEmision.selectorFormat(),
                  icon: Icon(
                    Icons.calendar_today,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Fecha Vencimiento Cedula',
                  isValid: null,
                  isRequired: true,
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  icon: Icon(
                    Icons.calendar_month,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'FechaNacimiento',
                  hintText: 'Ingresa Fecha Nacimiento',
                  isValid: null,
                  textEditingController: fechaNacimientoController,
                  isRequired: true,
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  icon: Icon(
                    Icons.flag,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Nacionalidad',
                  hintText: 'Ingresa FechaNacimiento',
                  isValid: null,
                  textEditingController: fechaNacimientoController,
                  isRequired: true,
                ),
                const Gap(30),
                CatalogoValorNacionalidad(
                  hintText: 'Selecciona Pais de Nacimiento',
                  title: 'Pais de Nacimiento',
                  onChanged: (item) {
                    if (item == null) return;
                  },
                  codigo: 'PAIS',
                  // initialValue: paisEmisor ?? '',
                ),
                const Gap(30),
                CatalogoValorDropdownWidget(
                  initialValue: '',
                  codigo: 'SEXO',
                  onChanged: (item) {},
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
                  icon: Icon(
                    Icons.email,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Email',
                  hintText: 'Ingresa Email',
                  isValid: null,
                ),
                const Gap(30),
                CatalogoValorDropdownWidget(
                  initialValue: '',
                  codigo: 'ESCOLARIDAD',
                  onChanged: (item) {},
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
