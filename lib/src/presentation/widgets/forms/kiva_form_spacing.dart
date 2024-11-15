import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class KivaFormSpacing extends StatelessWidget {
  const KivaFormSpacing({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 19),
      child: Column(
        children: [
          Divider(),
          Gap(17),
        ],
      ),
    );
  }
}
