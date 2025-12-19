import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LocationCardContainer extends StatelessWidget {
  const LocationCardContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SlideInUp(
        duration: const Duration(milliseconds: 200),
        child: Container(
          height: size.height * 0.4,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 42,
                    height: 5,
                    margin: const EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const UserLocationContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserLocationContent extends StatelessWidget {
  const UserLocationContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(8),
        Text(
          'Ubicación actual',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const Gap(6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.place_rounded,
              size: 18,
              color: AppColors.getPrimaryColor(),
            ),
            const Gap(6),
            Expanded(
              child: Text(
                'Calle 123, Ciudad, País',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade700,
                    ),
              ),
            ),
          ],
        ),
        const Gap(20),
        SearchDropdownWidget(
          codigo: 'UBICACIONGPS',
          title: 'Tipo de ubicación',
          onChanged: (v) {},
        ),
        const Gap(16),
        OutlineTextfieldWidget(
          title: 'Referencia adicional',
          icon: Icon(
            Icons.location_on_outlined,
            color: AppColors.getPrimaryColor(),
          ),
        ),
        const Gap(24),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.check_circle_rounded),
            label: const Text('Guardar ubicación'),
          ),
        ),
      ],
    );
  }
}
