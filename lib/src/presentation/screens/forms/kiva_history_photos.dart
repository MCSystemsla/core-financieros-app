import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/upload_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class KivaHistoryPhotos extends StatefulWidget {
  final int solicitudId;

  const KivaHistoryPhotos({super.key, required this.solicitudId});

  @override
  State<KivaHistoryPhotos> createState() => _KivaHistoryPhotosState();
}

class _KivaHistoryPhotosState extends State<KivaHistoryPhotos> {
  @override
  void initState() {
    initFunctions();
    super.initState();
  }

  initFunctions() async {
    final solicitudesProvider =
        context.read<SolicitudesPendientesLocalDbCubit>();
    await solicitudesProvider.getImagesModel(widget.solicitudId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<SolicitudesPendientesLocalDbCubit,
          SolicitudesPendientesLocalDbState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UploadImageWidget(
                  selectedImage: XFile(state.imageModel?.imagen1 ?? 'NO PATH'),
                  title: 'Imagen 1',
                  onPressed: () {},
                ),
                const Gap(20),
                UploadImageWidget(
                  selectedImage: XFile(state.imageModel?.imagen2 ?? 'NO PATH'),
                  title: 'Imagen 2',
                  onPressed: () {},
                ),
                const Gap(20),
                UploadImageWidget(
                  selectedImage: XFile(state.imageModel?.imagen3 ?? 'NO PATH'),
                  title: 'Imagen 3',
                  onPressed: () {},
                ),
                const Gap(20),
                UploadImageWidget(
                  selectedImage:
                      XFile(state.imageModel?.imagenFirma ?? 'NO PATH'),
                  title: 'Imagen Firma',
                  onPressed: () {},
                ),
                const Gap(20),
              ],
            ),
          );
        },
      ),
    );
  }
}
