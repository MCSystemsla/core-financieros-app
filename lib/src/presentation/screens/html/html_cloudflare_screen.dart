import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class HtmlCloudflareScreen extends StatefulWidget {
  const HtmlCloudflareScreen({super.key});

  @override
  State<HtmlCloudflareScreen> createState() => _HtmlCloudflareScreenState();
}

class _HtmlCloudflareScreenState extends State<HtmlCloudflareScreen> {
  final Uri url = Uri.parse('https://prod.agritude.org');

  Future<void> openUrl() async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
    )) {
      throw 'No se pudo lanzar $url';
    }
  }

  @override
  void initState() {
    super.initState();
    openUrl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Redirigiendo a pagina de autenticacion...')),
        body: Column(
          children: [
            const Text('Redirigiendo a pagina de autenticacion...'),
            CustomElevatedButton(
                text: 'Ir a inicio',
                color: Colors.blue,
                onPressed: () {
                  context.pushReplacement('/login');
                }),
          ],
        ));
  }
}
