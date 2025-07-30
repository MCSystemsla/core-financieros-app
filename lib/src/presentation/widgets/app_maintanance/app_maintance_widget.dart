import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class AppMaintanceWidget extends StatelessWidget {
  final String title;
  final DateTime from;
  final DateTime to;
  const AppMaintanceWidget({
    super.key,
    required this.title,
    required this.from,
    required this.to,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ImageAsset.appMaintanance,
              width: 200,
              height: 250,
            ),
            const Gap(35),
            Text(
              'La aplicación está temporalmente en mantenimiento',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 21,
                  ),
            ),
            const Gap(35),
            Text(
              'Estamos implementando mejoras en la aplicación desde el ${from.formatDateToTimePeriod()} hasta el ${to.formatDateToTimePeriod()}. El servicio se restablecerá pronto',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                  ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
