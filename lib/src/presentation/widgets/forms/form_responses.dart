import 'package:camera/camera.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/upload_image_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/button_actions_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class FormResponses extends StatefulWidget {
  final PageController controller;
  const FormResponses({
    super.key,
    required this.controller,
  });

  @override
  State<FormResponses> createState() => _FormResponsesState();
}

class _FormResponsesState extends State<FormResponses> {
  @override
  Widget build(BuildContext context) {
    final imageCliente = context.watch<UploadUserFileCubit>().state;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              'input.form_response'.tr(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(15),
            UploadImageWidget(
              selectedImage: XFile(imageCliente.imagen1),
              title: '1- Imagen Cliente 1',
              onPressed: () {},
            ),
            const Gap(15),
            UploadImageWidget(
              selectedImage: XFile(imageCliente.imagen2),
              title: '1- Imagen Cliente 2',
              onPressed: () {},
            ),
            const Gap(15),
            UploadImageWidget(
              selectedImage: XFile(imageCliente.imagen3),
              title: '1- Imagen Cliente 3',
              onPressed: () {},
            ),
            const Gap(15),
            BlocBuilder<ResponseCubit, ResponseState>(
              builder: (context, state) {
                return ListView.separated(
                  itemCount: state.responses.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) {
                    return const Gap(20);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return _ResponseWidget(
                      response: state.responses[index],
                      controller: widget.controller,
                    );
                  },
                );
              },
            ),
            const Gap(20),
            ButtonActionsWidget(
              onPreviousPressed: () {
                widget.controller.previousPage(
                  duration: const Duration(
                    milliseconds: 350,
                  ),
                  curve: Curves.easeIn,
                );
              },
              onNextPressed: () {
                widget.controller.nextPage(
                  duration: const Duration(
                    milliseconds: 350,
                  ),
                  curve: Curves.easeIn,
                );
              },
              previousTitle: 'button.previous'.tr(),
              nextTitle: 'button.signed'.tr(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResponseWidget extends StatelessWidget {
  final PageController controller;
  final Response response;
  const _ResponseWidget({required this.response, required this.controller});

  static String? _normalizar(String value) {
    final texto = value.trim();
    final lower = texto.toLowerCase();
    if (texto.isEmpty || lower == 'null' || lower == 'n/a') return null;
    return switch (lower) {
      'true' => 'Sí',
      'false' => 'No',
      _ => texto,
    };
  }

  void _irAPregunta() {
    if (!controller.hasClients) return;
    controller.animateToPage(
      response.index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final primary = AppColors.getPrimaryColor();
    final valor = _normalizar(response.response);

    return WhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  response.question,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    height: 1.3,
                  ),
                ),
              ),
              const Gap(8),
              IconButton(
                tooltip: 'Editar respuesta',
                visualDensity: VisualDensity.compact,
                onPressed: _irAPregunta,
                icon: Icon(Icons.edit_outlined, color: primary),
              ),
            ],
          ),
          const Gap(10),
          Text(
            valor ?? 'Sin respuesta',
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: valor == null ? FontWeight.w400 : FontWeight.w600,
              fontStyle: valor == null ? FontStyle.italic : FontStyle.normal,
              color: valor == null ? Colors.grey : null,
            ),
          ),
        ],
      ),
    );
  }
}
