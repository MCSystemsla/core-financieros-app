import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class KivaFormScreen extends StatelessWidget {
  const KivaFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitudes en Tramite'),
      ),
      body: ListView.separated(
        itemCount: 20,
        separatorBuilder: (BuildContext context, int index) {
          return const Gap(10);
        },
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: const Text('17112 - Edgardo Avila Ruiz'),
            onTap: () {},
            subtitle: Text(DateTime.now().formatDate()),
            trailing: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '17,500 USD',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
                Gap(5),
                Text('Estado'),
              ],
            ),
            leading: const CircleAvatar(
              child: Icon(Icons.wallet),
            ),
          );
        },
      ),
    );
  }
}
