import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Navbar extends StatelessWidget {
  final String? imageUrl;
  final String title;
  const Navbar({
    super.key,
    required this.title,
    this.imageUrl = ImageAsset.carteraBg2,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        Container(
          height: size.height * 0.3,
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: Image(
            fit: BoxFit.cover,
            image: AssetImage(
              imageUrl!,
            ),
          ),
        ),
        Container(
          height: size.height * 0.3,
          decoration: const BoxDecoration(
            color: Colors.black38,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          width: double.infinity,
        ),
        Container(
          height: size.height * 0.3,
          width: double.infinity,
          decoration: const BoxDecoration(
            // color: AppColors.getPrimaryColor().withOpacity(0.6),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: SafeArea(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                  ),
                  const Gap(10),
                  Text(
                    'Complete los detalles para registrar una nueva solicitud',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
