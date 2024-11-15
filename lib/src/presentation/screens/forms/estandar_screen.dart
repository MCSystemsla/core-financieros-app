import 'package:core_financiero_app/src/domain/repository/departamentos/departamentos_repository.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/estandar/estandar_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/departamentos/departamentos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/motivo_prestamo/motivo_prestamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/mejora_de_vivienda_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/estandar/estandar_aditional_data.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/estandar/estandar_descripcion_del_negocio.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/estandar/estandar_entorno_familiar.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/estandar/estandar_impacto_social.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EstandarScreen extends StatelessWidget {
  final String typeProduct;
  const EstandarScreen({super.key, required this.typeProduct});

  @override
  Widget build(BuildContext context) {
    final isRecurrentForm = typeProduct == 'ESTANDAR NUEVO';
    final pageController = PageController();
    final repository = ResponsesRepositoryImpl();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => EstandarCubit(repository),
        ),
        BlocProvider(
          create: (ctx) => ResponseCubit(),
        ),
        BlocProvider(
          create: (ctx) => DepartamentosCubit(DepartamentosRepositoryImpl())
            ..getDepartamentos(),
        ),
        BlocProvider(
          create: (ctx) => MotivoPrestamoCubit(repository)
            ..getMotivoPrestamo(
              numero: int.parse(
                context.read<KivaRouteCubit>().state.solicitudId,
              ),
            ),
        ),
        BlocProvider(
          create: (ctx) => UploadUserFileCubit(repository),
        ),
      ],
      child: PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Estandar ${isRecurrentForm ? 'Recurrente' : 'Nuevo'}'),
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              SaneamientoContent(
                controller: pageController,
              ),
              EstandarAditionalData(
                isRecurrenteForm: isRecurrentForm,
                pageController: pageController,
              ),
              EstandarEntornoFamiliar(
                isRecurrenteForm: isRecurrentForm,
                pageController: pageController,
              ),
              EstandarDescripciondelNegocio(
                isRecurrentForm: isRecurrentForm,
                pageController: pageController,
              ),
              EstandarImpactoSocial(
                isRecurrentForm: isRecurrentForm,
                pageController: pageController,
              ),
              FormResponses(
                controller: pageController,
              ),
              const EstandarSign(),
            ],
          ),
        ),
      ),
    );
  }
}
