import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final localDbProvider = global<ObjectBoxService>();

    final nombre1Controller = TextEditingController();
    final nombre2Controller = TextEditingController();
    final apellido1Controller = TextEditingController();
    final apellido2Controller = TextEditingController();
    final cedulaController = TextEditingController();
    final fechaEmisionCedulaController = TextEditingController();
    final fechaVencimientoCedulaController = TextEditingController();
    final fechaNacimientoController = TextEditingController();
    final telefonoController = TextEditingController();
    final celularController = TextEditingController();
    final direccionCasaController = TextEditingController();
    final barrioCasaController = TextEditingController();
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        children: [
          const Gap(30),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.credit_card,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Cedula',
            hintText: 'Ingresa Cedula',
            isValid: null,
            textEditingController: cedulaController,
          ),
          const Gap(30),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.person,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Nombre1',
            textCapitalization: TextCapitalization.words,
            hintText: 'Ingresa Nombre1',
            isValid: null,
            textEditingController: nombre1Controller,
          ),
          const Gap(30),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.person,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Nombre2',
            hintText: 'Ingresa Nombre2',
            textCapitalization: TextCapitalization.words,
            isValid: null,
            textEditingController: nombre2Controller,
          ),
          const Gap(30),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.badge,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Apellido1',
            hintText: 'Ingresa Apellido1',
            textCapitalization: TextCapitalization.words,
            isValid: null,
            textEditingController: apellido1Controller,
          ),
          const Gap(30),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.badge,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Apellido2',
            hintText: 'Ingresa Apellido2',
            textCapitalization: TextCapitalization.words,
            isValid: null,
            textEditingController: apellido2Controller,
          ),
          const Gap(30),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.calendar_today,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'FechaEmisionCedula',
            hintText: 'Ingresa FechaEmisionCedula',
            isValid: null,
            textEditingController: fechaEmisionCedulaController,
          ),
          const Gap(30),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.calendar_today,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'FechaVencimientoCedula',
            hintText: 'Ingresa FechaVencimientoCedula',
            isValid: null,
            textEditingController: fechaVencimientoCedulaController,
          ),
          const Gap(30),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.calendar_month,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'FechaNacimiento',
            hintText: 'Ingresa FechaNacimiento',
            isValid: null,
            textEditingController: fechaNacimientoController,
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
              Icons.home,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'DireccionCasa',
            hintText: 'Ingresa DireccionCasa',
            isValid: null,
            textEditingController: direccionCasaController,
          ),
          const Gap(30),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.map,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'BarrioCasa',
            hintText: 'Ingresa BarrioCasa',
            isValid: null,
            textEditingController: barrioCasaController,
          ),
          const Gap(30),
          CatalogoValorNacionalidad(
            hintText: 'Ingresa objPaisCasaId',
            title: 'objPaisCasaId',
            onChanged: (item) {
              if (item == null) return;
              paisEmisor = item.valor;
              departamentoEmisor = null;
              localDbProvider.getNacionalidadesDep(valor: item.valor);

              setState(() {});
            },
            codigo: 'PAIS',
            // initialValue: paisEmisor ?? '',
          ),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.work,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Profesion',
            hintText: 'Ingresa Profesion',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.business,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Ocupacion',
            hintText: 'Ingresa Ocupacion',
            isValid: null,
          ),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.email,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Email',
            hintText: 'Ingresa Email',
            isValid: null,
          ),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.flag,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Nacionalidad',
            hintText: 'Ingresa Nacionalidad',
            isValid: null,
          ),
          const Gap(20),
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
          const Gap(10),
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

  @override
  bool get wantKeepAlive => true;
}
