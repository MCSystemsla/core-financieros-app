import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class VpnNoFound extends StatefulWidget {
  final String routeIsVpnConnected;
  const VpnNoFound({super.key, required this.routeIsVpnConnected});

  @override
  State<VpnNoFound> createState() => _VpnNoFoundState();
}

class _VpnNoFoundState extends State<VpnNoFound> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (!mounted) return;
      final internetProvider = context.read<InternetConnectionCubit>();
      internetProvider.getInternetStatusConnection();
      if (internetProvider.state.isCorrectNetwork) {
        context.pushReplacement(widget.routeIsVpnConnected);
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(ImageAsset.vpnBg, width: 250),
            const Gap(20),
            Text(
              'No estas en el rango de la VPN',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 17,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: CustomElevatedButton(
                onPressed: () async => await openApp(),
                text: 'Abrir App',
                color: AppColors.getPrimaryColor(),
              ),
            )
          ],
        )),
      ),
    );
  }
}

Future<void> openApp() async {
  final Uri webApp = Uri.parse(
      'https://play.google.com/store/apps/details?id=com.fortinet.forticlient_fa&hl=en');
  const String packageName = 'com.fortinet.forticlient_fa';
  const webAppstore =
      'https://play.google.com/store/apps/details?id=com.fortinet.forticlient_fa&hl=en';
  try {
    await LaunchApp.openApp(
      androidPackageName: packageName,
      appStoreLink: webAppstore,
    );
  } catch (e) {
    await launchUrl(webApp);
  }
}
