import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/cartera_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/banner/custom_banner_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class TutorialsScreen extends StatelessWidget {
  const TutorialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ModuleCard(
            onTap: () {
              launchUrlCustom('https://youtu.be/1fRmhv1R-HQ');
            },
            title: 'Formularios Kiva',
            subtitle: 'Explicacion de los formularios kiva',
            firstColor: AppColors.white,
            secondColor:
                // ignore: deprecated_member_use
                Colors.black,
            icon: const Icon(
              Icons.video_camera_back_outlined,
              color: AppColors.white,
              size: 35,
            ),
          ),
          ModuleCard(
            onTap: () {
              launchUrlCustom('https://youtu.be/mG3l-rW8BPI');
            },
            title: 'Kiva Modo offline',
            subtitle: 'Explicacion detallado modo offline',
            firstColor: AppColors.white,
            secondColor:
                // ignore: deprecated_member_use
                Colors.black,
            icon: const Icon(
              Icons.video_camera_back_outlined,
              color: AppColors.white,
              size: 35,
            ),
          ),
        ],
      ),
    );
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
}
