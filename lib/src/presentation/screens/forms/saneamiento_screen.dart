import 'package:core_financiero_app/src/domain/repository/departamentos/departamentos_repository.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/agua_y_saneamiento/agua_y_saneamiento_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/motivo_prestamo/motivo_prestamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/departamentos/departamentos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_agua_y_saniamiento/recurrente_agua_y_saneamiento_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/add_kiva_images_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/form_responses.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/saneamiento/descripcion_y_desarrollo_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/saneamiento/entorno_social_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/saneamiento/saneamiento_impacto_social.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/saneamiento/signatures/recurrente_saneamiento_signature_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/saneamiento/signatures/saneamiento_signature_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';

class SaneamientoScreen extends StatefulWidget {
  final String typeProduct;

  const SaneamientoScreen({super.key, required this.typeProduct});

  @override
  State<SaneamientoScreen> createState() => _SaneamientoScreenState();
}

class _SaneamientoScreenState extends State<SaneamientoScreen> {
  final PageController _pageController = PageController();

  late DateTime _selectedDate;
  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
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
    final repository = ResponsesRepositoryImpl();
    final isRecurrentForm =
        widget.typeProduct == 'ScrKivaAguaSaneamientoRecurrente';
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => ResponseCubit(),
        ),
        BlocProvider(
          create: (ctx) => DepartamentosCubit(
            DepartamentosRepositoryImpl(),
          )..getDepartamentos(),
        ),
        BlocProvider(
          create: (ctx) => AguaYSaneamientoCubit(repository),
        ),
        BlocProvider(
          create: (ctx) => RecurrenteAguaYSaneamientoCubit(repository),
        ),
        BlocProvider(
          create: (ctx) => UploadUserFileCubit(repository),
        ),
        BlocProvider(
          create: (ctx) => MotivoPrestamoCubit(repository)
            ..getMotivoPrestamo(
              numero: int.parse(
                context.read<KivaRouteCubit>().state.solicitudId,
              ),
            ),
        ),
      ],
      child: PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
                '${'forms.saneamiento.appbar'.tr()} ${isRecurrentForm ? 'Recurrente' : 'Nuevo'}'),
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              AddKivaImagesWidget(
                controller: _pageController,
              ),
              EntornoSocialWidget(
                controller: _pageController,
                isRecurrentForm: isRecurrentForm,
              ),
              DescripcionYDesarrolloWidget(
                controller: _pageController,
                isRecurrentForm: isRecurrentForm,
              ),
              ImpactoSocialKivaWidget(
                controller: _pageController,
                isRecurrentForm: isRecurrentForm,
              ),
              FormResponses(
                controller: _pageController,
              ),
              isRecurrentForm
                  ? RecurrenteSaneamientoSignatureWidget(
                      controller: _pageController,
                    )
                  : SaneamientoSignatureWidget(
                      controller: _pageController,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
