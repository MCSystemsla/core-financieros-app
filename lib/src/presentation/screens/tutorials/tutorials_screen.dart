import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/domain/repository/auth/auth_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/tutorial/tutorial_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/cartera_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/banner/custom_banner_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class TutorialsScreen extends StatelessWidget {
  const TutorialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => TutorialCubit(
        AuthRepositoryImpl(),
      )..getTutorials(),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomBannerWidget(
              icon: Icon(
                Icons.video_collection_rounded,
                color: AppColors.white,
              ),
              title: 'Tutoriales',
              image: ImageAsset.carteraBg,
            ),
            const Gap(20),
            Container(
              margin: const EdgeInsets.all(18),
              child: Text(
                'Visualización de los tutoriales',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 19,
                    ),
              ),
            ),
            const TutorialListWidget(),
          ],
        ),
      ),
    );
  }
}

class TutorialListWidget extends StatelessWidget {
  const TutorialListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TutorialCubit, TutorialState>(
      builder: (context, state) {
        return switch (state) {
          OnTutorialStateLoading() => const LoadingWidget(),
          OnTutorialStateError() => Text(state.errorMsg),
          OnTutorialStateSuccess() => ListView.builder(
              shrinkWrap: true,
              itemCount: state.tutorialResponse.tutoriales.length,
              itemBuilder: (BuildContext context, int index) {
                return ModuleCard(
                  onTap: () {
                    launchUrlCustom(
                        state.tutorialResponse.tutoriales[index].url);
                  },
                  title: state.tutorialResponse.tutoriales[index].title,
                  subtitle:
                      state.tutorialResponse.tutoriales[index].description,
                  firstColor: AppColors.white,
                  secondColor: Colors.black,
                  icon: const Icon(
                    Icons.video_camera_back_outlined,
                    color: AppColors.white,
                    size: 35,
                  ),
                );
              },
            ),
          _ => const SizedBox(),
        };
      },
    );
  }
}

Future<bool> launchUrlCustom(String urlString) async {
  try {
    final Uri uri = Uri.parse(urlString);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'No se pudo abrir: $urlString';
    }
    return true;
  } catch (e) {
    return false;
  }
}
