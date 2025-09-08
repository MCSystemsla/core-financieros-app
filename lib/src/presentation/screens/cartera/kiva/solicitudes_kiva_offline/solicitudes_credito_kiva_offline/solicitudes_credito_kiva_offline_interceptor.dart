import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/add_kiva_images_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/dates_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/button_actions_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/icon_border.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:signature/signature.dart';

class SolicitudesCreditoKivaOfflineInterceptor extends StatelessWidget {
  final String nombreFormularioKiva;
  const SolicitudesCreditoKivaOfflineInterceptor({
    super.key,
    required this.nombreFormularioKiva,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => UploadUserFileCubit(
        ResponsesRepositoryImpl(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(nombreFormularioKiva),
        ),
        body: switch (nombreFormularioKiva) {
          'ESTANDAR NUEVO' => const SolicitudKivaOfflineEstandar(),
          'ESTANDAR RECURRENTE' => const Text('Estandar Recurrente'),
          _ => const SizedBox(),
        },
      ),
    );
  }
}

class SolicitudKivaOfflineEstandar extends StatefulWidget {
  const SolicitudKivaOfflineEstandar({
    super.key,
  });

  @override
  State<SolicitudKivaOfflineEstandar> createState() =>
      _SolicitudKivaOfflineEstandarState();
}

class _SolicitudKivaOfflineEstandarState
    extends State<SolicitudKivaOfflineEstandar> {
  final formKey = GlobalKey<FormState>();
  String? otrosIngresos;
  final cualesOtrosIngrsos = TextEditingController();
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: [
        AddKivaImagesWidget(
          controller: pageController,
        ),
        _Form1(
          pageController: pageController,
        ),
        _Form2(
          pageController: pageController,
        ),
        _Form3(
          pageController: pageController,
        ),
        _Form4(
          pageController: pageController,
        ),
        _SignatureView(controller: pageController),
      ],
    );
  }
}

class _Form4 extends StatefulWidget {
  final PageController pageController;
  const _Form4({required this.pageController});

  @override
  State<_Form4> createState() => _Form4State();
}

class _Form4State extends State<_Form4> {
  final formKey = GlobalKey<FormState>();
  final motivoPrestamo = TextEditingController();
  final planesFuturo = TextEditingController();
  final comoMejoraVida = TextEditingController();
  final otrosDatosCliente = TextEditingController();
  final comoFortalece = TextEditingController();
  final siguientePaso = TextEditingController();
  final personaAutoSuficiente = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MiCreditoProgress(
                steps: 5,
                currentStep: 5,
              ),
              const Gap(20),
              Text(
                'Impacto Social de Kiva ( Uso específico, objetivos, metas del préstamo)'
                    .tr(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Gap(20),
              CommentaryWidget(
                title: '¿Para qué solicitó el préstamo? Explique',
                textEditingController: motivoPrestamo,
              ),
              const Gap(20),
              CommentaryWidget(
                textEditingController: planesFuturo,
                title:
                    '¿Cuáles son sus planes personales para los proximos 5 años?*',
                validator: (value) => ClassValidator.validateRequired(value),
              ),
              const Gap(20),
              CommentaryWidget(
                textEditingController: comoMejoraVida,
                title:
                    '¿Cómo este crédito fortalecerá su negocio y mejorará sus condiciones de vida?*',
                validator: (value) => ClassValidator.validateRequired(value),
              ),
              const Gap(20),
              CommentaryWidget(
                textEditingController: otrosDatosCliente,
                title: 'Otros datos relevantes e interesantes del cliente',
              ),
              const Gap(20),
              CommentaryWidget(
                textEditingController: motivoPrestamo,
                title: '¿En qué piensa invertir este nuevo préstamo? Explique',
              ),
              const Gap(20),
              CommentaryWidget(
                textEditingController: comoFortalece,
                title:
                    '¿Considera usted que este nuevo préstamo continúe fortaleciendo su negocio y generando mayores ganancias que beneficien a su familia? Explique ',
              ),
              const Gap(20),
              CommentaryWidget(
                textEditingController: siguientePaso,
                title: 'A futuro ¿Cuál seria su siguiente paso?*',
                validator: (value) {
                  final trimmedValue = value?.trim();
                  if (trimmedValue == null ||
                      trimmedValue.isEmpty ||
                      trimmedValue == 'input.select_option'.tr()) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
              ),
              const Gap(20),
              CommentaryWidget(
                textEditingController: personaAutoSuficiente,
                title:
                    'Una vez finalizado el pago de este préstamo ¿ Podría ser una persona auto suficiente?',
              ),
              const Gap(20),
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
                  if (formKey.currentState?.validate() ?? false) {
                    widget.pageController.nextPage(
                      duration: const Duration(
                        milliseconds: 350,
                      ),
                      curve: Curves.easeIn,
                    );
                  }
                },
                previousTitle: 'button.previous'.tr(),
                nextTitle: 'button.next'.tr(),
              ),
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignatureView extends StatefulWidget {
  final PageController controller;
  const _SignatureView({required this.controller});

  @override
  State<_SignatureView> createState() => __SignatureViewState();
}

class __SignatureViewState extends State<_SignatureView> {
  TypeSigner typeSigner = TypeSigner.ninguno;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final controller = SignatureController();
    return SingleChildScrollView(
      child: Column(
        children: [
          const MiCreditoProgress(
            steps: 5,
            currentStep: 5,
          ),
          const Gap(5),
          Padding(
            padding: const EdgeInsets.all(8),
            child: JLuxDropdown(
              dropdownColor: AppColors.white,
              title: 'Tiene capacidad el usuario para firma?',
              items: ['input.yes'.tr(), 'input.no'.tr()],
              onChanged: (item) {
                setState(() {
                  typeSigner = item == 'input.yes'.tr()
                      ? TypeSigner.cliente
                      : TypeSigner.asesor;
                });
              },
              toStringItem: (item) => item,
              hintText: 'input.select_option'.tr(),
            ),
          ),
          if (typeSigner != TypeSigner.ninguno)
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' ${typeSigner == TypeSigner.cliente ? 'forms.firmar.title'.tr() : 'Firma de Representante de Micrédito'}',
                    style: const TextStyle(
                      color: AppColors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(10),
                  Text(
                    'forms.firmar.description'.tr(),
                    style: TextStyle(
                      color: AppColors.greyWithOpacityV4,
                    ),
                  ),
                  const Gap(5),
                  Stack(
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.boxGrey,
                            width: .9,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Signature(
                            key: const Key('signature'),
                            controller: controller,
                            height: size.height * .56,
                            width: size.width * .9,
                            backgroundColor: AppColors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: IconBorder.fromIcon(
                          color: AppColors.red,
                          icon: Icons.delete_forever,
                          onTap: () => controller.clear(),
                          size: const Size(44, 44),
                        ),
                      ),
                    ],
                  ),
                  const Gap(30),
                  CustomElevatedButton(
                    icon: const Icon(
                      Icons.edit,
                      color: AppColors.white,
                    ),
                    // enabled: state.status != Status.inProgress,
                    positionIcon: PositionIcon.left,
                    // text: state.status == Status.inProgress
                    // ? 'Cargando...'
                    text: 'button.send'.tr(),
                    color: context.primaryColor(),
                    onPressed: () async {},
                  ),
                  const Gap(10),
                  Expanded(
                    flex: 0,
                    child: CustomElevatedButton(
                      alignment: MainAxisAlignment.center,
                      text: 'Regresar',
                      color: Colors.red,
                      onPressed: () => widget.controller.previousPage(
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeIn,
                      ),
                    ),
                  ),
                  const Gap(10),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _Form3 extends StatefulWidget {
  final PageController pageController;
  const _Form3({required this.pageController});

  @override
  State<_Form3> createState() => __Form3State();
}

class __Form3State extends State<_Form3> {
  final formKey = GlobalKey<FormState>();
  late DateTime _selectedDate;
  String? coincideRespuesta;
  String? apoyanNegocio;
  final publicitarNegocio = TextEditingController();
  final negocioProximosAnios = TextEditingController();

  @override
  void initState() {
    _selectedDate = DateTime.now();
    super.initState();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1930),
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
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MiCreditoProgress(
                steps: 5,
                currentStep: 4,
              ),
              const Gap(20),
              Text(
                'Descripción y desarrollo del negocio.'.tr(),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Gap(20),
              DatesWidget(
                title: '¿Cuenténos cuando inició su negocio?*',
                onSelectedDate: () => selectDate(context),
                selectedDate: _selectedDate,
              ),
              const Gap(20),
              WhiteCard(
                padding: const EdgeInsets.all(5),
                child: JLuxDropdown(
                  isContainIcon: true,
                  validator: (value) {
                    if (value == null) return 'input.input_validator'.tr();

                    return null;
                  },
                  title:
                      '¿Hay alguien que le apoye en su negocio? de ser positivo,?'
                          .tr(),
                  items: ['input.yes'.tr(), 'input.no'.tr()],
                  onChanged: (item) {
                    if (item == null) return;
                    coincideRespuesta = item;
                    setState(() {});
                  },
                  toStringItem: (item) {
                    return item;
                  },
                  hintText: 'input.select_option'.tr(),
                ),
              ),
              const Gap(20),
              if (coincideRespuesta == 'input.yes'.tr())
                WhiteCard(
                  padding: const EdgeInsets.all(5),
                  child: JLuxDropdown(
                    isContainIcon: true,
                    validator: (value) {
                      if (value == null) {
                        return 'input.input_validator'.tr();
                      }
                      return null;
                    },
                    title: 'Favor responder cuántas personas'.tr(),
                    items: const [
                      '1 a 3',
                      '4 a 6',
                      '7 o mas',
                    ],
                    onChanged: (item) {
                      if (item == null) return;
                      apoyanNegocio = item;
                      setState(() {});
                    },
                    toStringItem: (item) {
                      return item;
                    },
                    hintText: 'input.select_option'.tr(),
                  ),
                ),
              const Gap(20),
              CommentaryWidget(
                title:
                    '¿En qué tipo de lugares le gustaría dar a conocer su producto? ¿Por qué?*',
                textEditingController: publicitarNegocio,
              ),
              const Gap(20),
              CommentaryWidget(
                title: '¿Cómo mira su negocio en los proximos años?*',
                textEditingController: negocioProximosAnios,
                validator: (value) => ClassValidator.validateRequired(value),
              ),
              const Gap(20),
              CommentaryWidget(
                validator: (value) {
                  final trimmedValue = value?.trim();
                  if (trimmedValue == null ||
                      trimmedValue.isEmpty ||
                      trimmedValue == 'input.select_option'.tr()) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
                title:
                    'explique en que invirtió y porqué hizo esa nueva inversión.',
              ),
              const Gap(20),
              const CommentaryWidget(
                title:
                    '¿Cómo este crédito ha constribuido a mejorar su calidad de vida y empoderarse de su negocio? Explique.',
              ),
              const Gap(20),
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
                  if (formKey.currentState?.validate() ?? false) {
                    widget.pageController.nextPage(
                      duration: const Duration(
                        milliseconds: 350,
                      ),
                      curve: Curves.easeIn,
                    );
                  }
                },
                previousTitle: 'button.previous'.tr(),
                nextTitle: 'button.next'.tr(),
              ),
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}

class _Form2 extends StatefulWidget {
  final PageController pageController;
  const _Form2({required this.pageController});

  @override
  State<_Form2> createState() => _Form2State();
}

class _Form2State extends State<_Form2> {
  final formKey = GlobalKey<FormState>();
  String? objOrigenCatalogoValorId;
  final personasCargo = TextEditingController();
  final numeroHijos = TextEditingController();
  final edadHijos = TextEditingController();
  String? tipoEstudioHijos;
  String? cantidadHijos;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final solicitudesProvider =
          context.read<SolicitudesPendientesLocalDbCubit>();
      await solicitudesProvider.getDepartamentos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final localDbProvider = global<ObjectBoxService>();
    final items = localDbProvider.departmentsBox.getAll();
    final departmentos =
        items.map((e) => Item(name: e.nombre, value: e.valor)).toList();
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MiCreditoProgress(
                steps: 5,
                currentStep: 3,
              ),
              const Gap(20),
              Text(
                'Descripción del entorno familiar.'.tr(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Gap(10),
              WhiteCard(
                marginTop: 15,
                padding: const EdgeInsets.all(10),
                child: JLuxDropdown(
                  isContainIcon: true,
                  validator: (value) {
                    if (value == null) {
                      return 'input.input_validator'.tr();
                    }
                    return null;
                  },
                  // isLoading: state.status == Status.inProgress,
                  title: 'forms.entorno_familiar.person_origin'.tr(),
                  items: departmentos,
                  onChanged: (item) {
                    if (item == null) return;
                    objOrigenCatalogoValorId = item.value;
                    setState(() {});
                  },
                  toStringItem: (item) => item.name,
                  hintText: 'input.select_department'.tr(),
                ),
              ),
              const Gap(20),
              CommentaryWidget(
                title: 'Cantidad de hijos:',
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2),
                ],
                onChange: (value) {
                  cantidadHijos = value;
                },
              ),
              const Gap(20),
              CommentaryWidget(
                title: '¿Que edades tienen sus hijos?',
                textEditingController: edadHijos,
              ),
              const Gap(20),
              WhiteCard(
                padding: const EdgeInsets.all(5),
                child: JLuxDropdown(
                  isContainIcon: true,
                  validator: (value) {
                    if (value == null) {
                      return 'input.input_validator'.tr();
                    }
                    return null;
                  },
                  title: '¿Qué tipo de estudios reciben sus hijos?'.tr(),
                  items: const [
                    'Ninguno',
                    'Preescolar',
                    'Primaria',
                    'Secundaria',
                    'Técnico',
                    'Universitario'
                  ],
                  onChanged: (item) {
                    if (item == null) return;
                    tipoEstudioHijos = item;
                    setState(() {});
                  },
                  toStringItem: (item) {
                    return item;
                  },
                  hintText: 'input.select_option'.tr(),
                ),
              ),
              const Gap(20),
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
                  if (formKey.currentState?.validate() ?? false) {
                    widget.pageController.nextPage(
                      duration: const Duration(
                        milliseconds: 350,
                      ),
                      curve: Curves.easeIn,
                    );
                  }
                },
                previousTitle: 'button.previous'.tr(),
                nextTitle: 'button.next'.tr(),
              ),
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}

class _Form1 extends StatefulWidget {
  final PageController pageController;
  const _Form1({required this.pageController});

  @override
  State<_Form1> createState() => _Form1State();
}

class _Form1State extends State<_Form1> {
  String? otrosIngresos;
  final cualesOtrosIngrsos = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const MiCreditoProgress(
              steps: 5,
              currentStep: 2,
            ),
            const Gap(20),
            WhiteCard(
              padding: const EdgeInsets.all(5),
              child: JLuxDropdown(
                isContainIcon: true,
                validator: (value) {
                  if (value == null) {
                    return 'input.input_validator'.tr();
                  }

                  return null;
                },
                title: '¿Tiene otros ingresos?¿Cuales?*'.tr(),
                items: ['input.yes'.tr(), 'input.no'.tr()],
                onChanged: (item) {
                  if (item == null) return;
                  otrosIngresos = item;
                  setState(() {});
                },
                toStringItem: (item) {
                  return item;
                },
                hintText: 'input.select_option'.tr(),
              ),
            ),
            if (otrosIngresos == 'input.yes'.tr())
              CommentaryWidget(
                title: 'Cuales?',
                textEditingController: cualesOtrosIngrsos,
                validator: (value) => ClassValidator.validateRequired(value),
              ),
            const Gap(20),
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
                if (formKey.currentState?.validate() ?? false) {
                  widget.pageController.nextPage(
                    duration: const Duration(
                      milliseconds: 350,
                    ),
                    curve: Curves.easeIn,
                  );
                }
              },
              previousTitle: 'button.previous'.tr(),
              nextTitle: 'button.next'.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
