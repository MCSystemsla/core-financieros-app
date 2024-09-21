import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/creditos/credito_datos_de_conyuge_y_seguro_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/creditos/credito_datos_de_negocio_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/creditos/credito_datos_personales_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/creditos/credito_general_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/dates_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CreditoScreen extends StatelessWidget {
  const CreditoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitud de Credito'),
      ),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          CreditoGeneralesWidget(
            pageController: pageController,
          ),
          CreditoDatosPersonalesWidget(
            controller: pageController,
          ),
          CreditoDatosDeConyugeYSeguroWidget(
            pageController: pageController,
          ),
          CreditoDatosDeNegocioWidget(
            pageController: pageController,
          ),
          CreditoDatosDeCreditoWidget(
            pageController: pageController,
          )
        ],
      ),
    );
  }
}

class CreditoDatosDeCreditoWidget extends StatefulWidget {
  final PageController pageController;
  const CreditoDatosDeCreditoWidget({
    super.key,
    required this.pageController,
  });

  @override
  State<CreditoDatosDeCreditoWidget> createState() =>
      _CreditoDatosDeCreditoWidgetState();
}

class _CreditoDatosDeCreditoWidgetState
    extends State<CreditoDatosDeCreditoWidget> {
  late DateTime _selectedDate;
  String? isHaveEmpleadoWorking;
  @override
  void initState() {
    _selectedDate = DateTime.now();
    super.initState();
  }

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
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MiCreditoProgress(
              steps: 6,
              currentStep: 5,
            ),
            const Gap(20),
            Text(
              'Datos del CFredito'.tr(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(10),
            DatesWidget(
              title: 'Fecha de Solicitud',
              onSelectedDate: () async => await selectDate(context),
              selectedDate: _selectedDate,
            ),
            const Gap(10),
            WhiteCard(
              marginTop: 15,
              padding: const EdgeInsets.all(10),
              child: JLuxDropdown(
                isContainIcon: true,
                title: 'Moneda'.tr(),
                items: const ['Dolar', 'Lempira'],
                onChanged: (item) {
                  if (item == null) return;
                  setState(() {});
                },
                toStringItem: (item) => item,
                hintText: 'Selecciona una opcion'.tr(),
              ),
            ),
            const Gap(10),
            const CommentaryWidget(title: 'Monto Solicitado'),
            const Gap(10),
            const CommentaryWidget(title: 'Plazo en Meses'),
            const Gap(10),
            DatesWidget(
              title: 'Fecha primer pago',
              onSelectedDate: () async => await selectDate(context),
              selectedDate: _selectedDate,
            ),
            const Gap(10),
            const CommentaryWidget(title: 'Producto'),
            const Gap(10),
            const CommentaryWidget(title: 'Frecuencia'),
            const Gap(10),
            const CommentaryWidget(title: 'Monto Primer Cuota'),
            const Gap(10),
            const CommentaryWidget(title: 'Observacion'),
            const Gap(10),
            const CommentaryWidget(title: 'Proposito'),
            const Gap(10),
            const CommentaryWidget(title: 'Oficial de Credito'),
            const Gap(10),
            const CommentaryWidget(title: 'Ubicacion'),
            const Gap(10),
            WhiteCard(
              marginTop: 15,
              padding: const EdgeInsets.all(10),
              child: JLuxDropdown(
                isContainIcon: true,
                title: 'Es familiar de un Empleado?'.tr(),
                items: const ['Si', 'No'],
                onChanged: (item) {
                  if (item == null) return;
                  isHaveEmpleadoWorking = item;
                  setState(() {});
                },
                toStringItem: (item) => item,
                hintText: 'Selecciona una opcion'.tr(),
              ),
            ),
            if (isHaveEmpleadoWorking == 'Si') const HaveEmpleadoWidget(),
            ButtonActionsWidget(
              onPreviousPressed: () {
                widget.pageController.previousPage(
                  duration: const Duration(
                    milliseconds: 350,
                  ),
                  curve: Curves.easeIn,
                );
              },
              onNextPressed: () {
                widget.pageController.nextPage(
                  duration: const Duration(
                    milliseconds: 350,
                  ),
                  curve: Curves.easeIn,
                );
              },
              previousTitle: 'button.previous'.tr(),
              nextTitle: 'button.next'.tr(),
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}

class HaveEmpleadoWidget extends StatelessWidget {
  const HaveEmpleadoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Gap(10),
        CommentaryWidget(title: 'Nombre del Empleado'),
        Gap(10),
        CommentaryWidget(title: 'Cedula'),
      ],
    );
  }
}
