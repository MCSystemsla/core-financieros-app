// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AddItemCustomCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const AddItemCustomCard({
    super.key,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 110,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.getPrimaryColor().withOpacity(0.08),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: AppColors.getPrimaryColor().withOpacity(0.4),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        splashColor: AppColors.getPrimaryColor().withOpacity(0.2),
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.add,
              size: 42,
            ),
            const Gap(8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
