import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/home/home_banner_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/home/home_items_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          HomeBannerWidget(),
          Expanded(
            child: HomeItemsWidget(),
          ),
        ],
      ),
    );
  }
}
