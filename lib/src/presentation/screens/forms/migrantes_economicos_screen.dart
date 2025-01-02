import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/migrantes_economicos/migrantes_economicos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/screens.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/migrantes_economicos/migrante_entorno_social.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/migrantes_economicos/migrante_impacto_social.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/migrantes_economicos/migrantes_about_family.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/migrantes_economicos/migrantes_desarrollo_negocio.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/migrantes_economicos/migrantes_signature.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/migrantes_economicos/primer_prestamo_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MigrantesEconomicosScreen extends StatelessWidget {
  final String typeProduct;
  const MigrantesEconomicosScreen({super.key, required this.typeProduct});

  @override
  Widget build(BuildContext context) {
    final isRecurrentForm =
        typeProduct == 'ESTANDAR COLONES RECURRENTE MAYOR A MIL' ||
            typeProduct == 'ESTANDAR COLONES RECURRENTE MENOR A MIL';

    final pageController = PageController();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => ResponseCubit(),
        ),
        BlocProvider(
          create: (ctx) => MigrantesEconomicosCubit(ResponsesRepositoryImpl()),
        ),
        BlocProvider(
          create: (ctx) => UploadUserFileCubit(ResponsesRepositoryImpl()),
        ),
      ],
      child: PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
                '${'forms.migrantes_economicos.title'.tr()} ${isRecurrentForm ? 'Recurrente' : 'Nuevo'}'
                    .tr()),
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              SaneamientoContent(
                controller: pageController,
              ),
              PrimerPrestamoWidget(
                controller: pageController,
              ),
              MigrantesEconomicosEntornoSocial(
                controller: pageController,
              ),
              MigrantesEconomicosAboutFamily(
                controller: pageController,
              ),
              MigrantesEconomicosDesarrolloDeNegocio(
                controller: pageController,
              ),
              ImpactoSocialMigranteEconomico(
                controller: pageController,
              ),
              FormResponses(
                controller: pageController,
              ),
              const MigrantesFormSignature(),
            ],
          ),
        ),
      ),
    );
  }
}
