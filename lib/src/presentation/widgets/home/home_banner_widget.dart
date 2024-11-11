import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/screens/home/home_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/lang/change_lang_widget.dart';
import 'package:flutter/material.dart';

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
          child: const FadeInImage(
            alignment: Alignment.center,
            placeholderFit: BoxFit.contain,
            fit: BoxFit.cover,
            placeholder: AssetImage(
              ImageAsset.loader,
            ),
            image: NetworkImage(
              'https://res.cloudinary.com/dfp17v5ve/image/upload/v1731003510/miCredito/7b7d17c5-a726-4702-877d-027783c7c93c.jpg',
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
              // * Comentado por Ahora Hasta Version 2.0
              // NotificationWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
