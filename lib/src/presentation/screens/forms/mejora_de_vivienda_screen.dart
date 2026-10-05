import 'dart:developer';
import 'package:core_financiero_app/src/domain/repository/departamentos/departamentos_repository.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/departamentos/departamentos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/mejora_vivienda/mejora_vivienda_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/motivo_prestamo/motivo_prestamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_,mejora_vivienda.dart/recurrente_mejora_vivienda_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/add_kiva_images_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/form_responses.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/impacto_social_kiva_objetivo.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/mejora_vivienda/mejora_vivienda_credito_descrip.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/mejora_vivienda/mejora_vivienda_entorno_social.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/mejora_vivienda/signatures/recurrente_vivienda_signature_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/mejora_vivienda/signatures/vivienda_signature_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MejoraDeViviendaScreen extends StatefulWidget {
  final String typeProducto;
  const MejoraDeViviendaScreen({super.key, required this.typeProducto});

  @override
  State<MejoraDeViviendaScreen> createState() => _MejoraDeViviendaScreenState();
}

class _MejoraDeViviendaScreenState extends State<MejoraDeViviendaScreen> {
  bool? isRecurrentForm;
  @override
  void initState() {
    super.initState();
    isRecurrentForm = widget.typeProducto == 'ScrKivaMejoraViviendaRecurrente';
    log(isRecurrentForm.toString());
  }

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => UploadUserFileCubit(ResponsesRepositoryImpl()),
        ),
        BlocProvider(
          create: (ctx) => MejoraViviendaCubit(ResponsesRepositoryImpl()),
        ),
        BlocProvider(
          create: (ctx) => ResponseCubit(),
        ),
        BlocProvider(
          create: (ctx) => DepartamentosCubit(DepartamentosRepositoryImpl())
            ..getDepartamentos(),
        ),
        BlocProvider(
            create: (ctx) =>
                RecurrenteMejoraViviendaCubit(ResponsesRepositoryImpl())),
        BlocProvider(
          create: (ctx) => MotivoPrestamoCubit(ResponsesRepositoryImpl())
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
                '${'forms.mejora_de_vivienda.title'.tr()} ${isRecurrentForm! ? 'Recurrente' : 'Nuevo'}'),
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              AddKivaImagesWidget(
                controller: pageController,
              ),
              MejoraViviendaEntornoSocial(
                pageController: pageController,
                isRecurrentForm: isRecurrentForm ?? false,
              ),
              if (isRecurrentForm ?? false)
                MejoraViviendaCreditoDescrip(
                  isRecurrentForm: isRecurrentForm ?? false,
                  pageController: pageController,
                ),
              ImpactoSocialKivaObjetiveWidget(
                isRecurrentForm: isRecurrentForm ?? false,
                controller: pageController,
              ),
              FormResponses(
                controller: pageController,
              ),
              (isRecurrentForm ?? false)
                  ? RecurrenteViviendaSignatureWidget(
                      controller: pageController,
                    )
                  : ViviendaSignatureWidget(
                      controller: pageController,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
