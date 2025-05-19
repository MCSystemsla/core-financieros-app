import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/auth_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/home/home_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/lang/change_lang_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBannerWidget extends StatelessWidget {
  const HomeBannerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        Container(
          height: size.height * 0.5,
          width: size.width,
          alignment: Alignment.center,
          child: FadeInImage(
            imageErrorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.wifi_off_outlined,
                size: 90,
              );
            },
            alignment: Alignment.center,
            placeholderFit: BoxFit.contain,
            fit: BoxFit.cover,
            placeholder: const AssetImage(
              ImageAsset.loader,
            ),
            image: const NetworkImage(
              'https://res.cloudinary.com/dfp17v5ve/image/upload/v1731341051/micredito/carrusel/d1053f76-cabb-4e5f-9b1d-f2d80025a794.jpg',
            ),
          ),
        ),
        Container(
          height: size.height * 0.5,
          width: size.width,
          color: Colors.black12,
        ),
        const SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ChangeLangWidget(
                child: HomeScreen(),
              ),
              LogOutWidget(),
            ],
          ),
        ),
      ],
    );
  }
}

class LogOutWidget extends StatelessWidget {
  const LogOutWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<AuthCubit>().logOut(context: context),
      child: Container(
        height: 50,
        width: 50,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.boxGrey,
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsets.all(8),
        child: const Icon(
          Icons.logout,
          color: AppColors.white,
        ),
      ),
    );
  }
}
