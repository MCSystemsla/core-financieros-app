import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/dates_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/upload_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CommentaryWidget.withCounter(
                title: 'Nombre completo del cliente:',
              ),
              const Gap(12),
              const CommentaryWidget.withCounter(
                title: 'Identificador del cliente:',
              ),
              const Gap(12),
              const CommentaryWidget(
                title: 'TItulo del commentary Form',
              ),
              const Gap(12),
              DatesWidget(
                selectedDate: _selectedDate,
                onSelectedDate: () => selectDate(context),
                title: 'Ingresa Fecha requerida:',
              ),
              const Gap(15),
              const UploadImageWidget(
                title: 'Ingresa Foto de Cliente',
              ),
              const Gap(15),
            ],
          ),
        ),
      ),
    );
  }
}
