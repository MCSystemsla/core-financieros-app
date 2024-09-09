import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/upload_image_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';

class SaneamientoScreen extends StatefulWidget {
  const SaneamientoScreen({super.key});

  @override
  State<SaneamientoScreen> createState() => _SaneamientoScreenState();
}

class _SaneamientoScreenState extends State<SaneamientoScreen> {
  late DateTime _selectedDate;
  @override
  void initState() {
    _selectedDate = DateTime.now();
    super.initState();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saneamiento'),
      ),
      body: PageView(
        children: const [
          _SaneamientoContent(),
          _SaneamientoContent(),
          Text('sadsa')
        ],
      ),
    );
  }
}

class _SaneamientoContent extends StatelessWidget {
  const _SaneamientoContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const MiCreditoProgress(
              steps: 5,
              currentStep: 1,
            ),
            const Gap(15),
            const UploadImageWidget(
              title: '1- Foto Cliente',
            ),
            const Gap(15),
            const UploadImageWidget(
              title: '2- Foto Cliente',
            ),
            const Gap(15),
            const UploadImageWidget(
              title: '3- Foto Cliente',
            ),
            const Gap(15),
            _ButtonActionsWidget(
              onPreviousPressed: () {},
              onNextPressed: () {},
              previousTitle: 'Anterior',
              nextTitle: 'Siguiente',
            ),
          ],
        ),
      ),
    );
  }
}

class _ButtonActionsWidget extends StatelessWidget {
  final void Function()? onPreviousPressed;
  final void Function()? onNextPressed;
  final String previousTitle;
  final String nextTitle;
  const _ButtonActionsWidget({
    required this.onPreviousPressed,
    required this.onNextPressed,
    required this.previousTitle,
    required this.nextTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: CustomElevatedButton(
              alignment: MainAxisAlignment.center,
              text: previousTitle,
              color: Colors.red,
              onPressed: () => onPreviousPressed!(),
            ),
          ),
          const Gap(20),
          Expanded(
            child: CustomElevatedButton(
              alignment: MainAxisAlignment.center,
              text: nextTitle,
              color: AppColors.getPrimaryColor(),
              onPressed: () => onNextPressed!(),
            ),
          )
        ],
      ),
    );
  }
}
