import 'dart:io';

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/user_by_document/user_by_document.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/signature_client/signature_client_db.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_aslariado_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/user_by_document_asalariado/user_by_document_asalariado_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/cedula/add_cedula_photos_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/ni/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/icon_border.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/navbar/navbar.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/asalariado/online/asalariado_historial_credito_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/asalariado/online/asalariado_hn_form1.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/asalariado/online/asalariado_hn_form2.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/asalariado/online/asalariado_hn_form3.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/asalariado/online/asalariado_hn_form4.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/asalariado/online/asalariado_hn_form5.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/asalariado/online/asalariado_hn_form6.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/asalariado/online/asalariado_hn_form7.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/asalariado/online/asalariado_hn_form8.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/asalariado/online/asalariado_hn_form9.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/signature/client_signature_list_data.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/signature/nueva/solicitud_nueva_signature_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/signature/nueva/verify_client_signature_nueva_sheet.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/user_identification_alert/user_identification_alert_dialog.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

import '../../../../bloc/solicitudes/hn/cubit/user_have_cedula/user_have_cedula_cubit.dart';

class AsalariadoHnForm extends StatefulWidget {
  const AsalariadoHnForm({super.key});

  @override
  State<AsalariadoHnForm> createState() => _AsalariadoHnFormState();
}

class _AsalariadoHnFormState extends State<AsalariadoHnForm> {
  @override
  void initState() {
    super.initState();
    final userByDocumentProvider =
        context.read<UserByDocumentAsalariadoCubit>().state;

    context.read<UserHaveCedulaCubit>().userHaveCedula(
          documentoCliente: userByDocumentProvider.cedula,
        );
  }

  @override
  Widget build(BuildContext context) {
    final userByDocumentProvider =
        context.read<UserByDocumentAsalariadoCubit>().state;
    final userHaveCedulaAlready = context.watch<UserHaveCedulaCubit>().state;

    final pageController = PageController();
    return Column(
      children: [
        const Navbar(
          title: 'Crear nueva Solicitud Asalariado',
          imageUrl: ImageAsset.represtamoBg,
        ),
        Expanded(
          child: SafeArea(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                SolicitudSignatureAsalariado(
                  pageController: pageController,
                  cedula: userByDocumentProvider.cedula,
                ),
                if (userHaveCedulaAlready.tieneFotoCedula)
                  UserIdentificationAlertDialog(
                    pageController: pageController,
                  ),
                if (userHaveCedulaAlready.isUserSelectUpdateImage ||
                    !userHaveCedulaAlready.tieneFotoCedula)
                  AddCedulaPhotosScreen(
                    controller: pageController,
                    onCedulaFrontTaken: (imagePath) {
                      context.read<SolicitudAslariadoHnCubit>().saveCedula(
                            imagenFrontal: imagePath,
                          );
                    },
                    onCedulaBackTaken: (imagePath) {
                      context.read<SolicitudAslariadoHnCubit>().saveCedula(
                            imagenTrasera: imagePath,
                          );
                    },
                  ),
                // RiskControlScreen(
                //   nombre1: userByDocumentProvider.primerNombre,
                //   nombre2: userByDocumentProvider.segundoNombre,
                //   apellido1: userByDocumentProvider.primerApellido,
                //   apellido2: userByDocumentProvider.segundoApellido,
                //   tipoIdentificacion: userByDocumentProvider.tipoDocumento,
                //   identificacion: userByDocumentProvider.cedula,
                //   tipoOrganizacion: 'PERSONANATURAL',
                //   pageController: pageController,
                // ),
                AsalariadoHnForm1(
                  controller: pageController,
                  userByDocumentHnData: UserDocumentDataHN(
                    cedula: userByDocumentProvider.cedula,
                    primerNombre: userByDocumentProvider.primerNombre,
                    segundoNombre: userByDocumentProvider.segundoNombre,
                    primerApellido: userByDocumentProvider.primerApellido,
                    segundoApellido: userByDocumentProvider.segundoApellido,
                    fechaNacimiento: DateTime.tryParse(
                        userByDocumentProvider.fechaNacimiento),
                    sexo: userByDocumentProvider.sexo,
                    direccion: userByDocumentProvider.direccion,
                    fechaEmision:
                        DateTime.tryParse(userByDocumentProvider.fechaEmision),
                    fechaExpira:
                        DateTime.tryParse(userByDocumentProvider.fechaExpira),
                    tipoDocumento: userByDocumentProvider.tipoDocumento,
                  ),
                ),
                AsalariadoHnForm2(
                  controller: pageController,
                  userByDocumentHnData: UserDocumentDataHN(
                    cedula: userByDocumentProvider.cedula,
                    primerNombre: userByDocumentProvider.primerNombre,
                    segundoNombre: userByDocumentProvider.segundoNombre,
                    primerApellido: userByDocumentProvider.primerApellido,
                    segundoApellido: userByDocumentProvider.segundoApellido,
                    fechaNacimiento: DateTime.tryParse(
                        userByDocumentProvider.fechaNacimiento),
                    sexo: userByDocumentProvider.sexo,
                    direccion: userByDocumentProvider.direccion,
                    fechaEmision:
                        DateTime.tryParse(userByDocumentProvider.fechaEmision),
                    fechaExpira:
                        DateTime.tryParse(userByDocumentProvider.fechaExpira),
                    tipoDocumento: userByDocumentProvider.tipoDocumento,
                  ),
                ),
                AsalariadoHnForm3(
                  controller: pageController,
                ),
                AsalariadoHnForm4(
                  controller: pageController,
                ),
                AsalariadoHnForm5(
                  controller: pageController,
                ),
                AsalariadoHnForm6(
                  controller: pageController,
                ),
                AsalariadoHnForm7(
                  controller: pageController,
                ),
                AsalariadoHnForm8(
                  controller: pageController,
                ),
                AsalariadoHistorialCreditoHn(
                  controller: pageController,
                ),
                AsalariadoHnForm9(
                  controller: pageController,
                  isUserSelectUpdateImage:
                      userHaveCedulaAlready.isUserSelectUpdateImage,
                  tieneFotoCedula: userHaveCedulaAlready.tieneFotoCedula,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SolicitudSignatureAsalariado extends StatelessWidget {
  final PageController pageController;
  final String cedula;
  const SolicitudSignatureAsalariado({
    super.key,
    required this.pageController,
    required this.cedula,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      margin: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            ImageAsset.solicitudSignature,
            height: 180,
          ),
          const Gap(25),
          Text(
            'Validacion de firma de solicitante',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Gap(16),
          Text(
            'Mediante esta firma, el solicitante certifica la veracidad de los datos ingresados y autoriza el trámite correspondiente y autoriza a la busqueda centrales de riesgo',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[700],
                ),
          ),
          const Gap(30),
          CustomElevatedButton(
            onPressed: () => {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (ctx) => BlocProvider.value(
                  value: context.read<SolicitudAslariadoHnCubit>(),
                  child: VerifyClientSignatureSheetAsalariado(
                    pageController: pageController,
                    cedula: cedula,
                    typeform: TypeForm.asalariado,
                  ),
                ),
              ),
            },
            text: 'Verificar',
            color: AppColors.getSecondaryColor(),
          ),
        ],
      ),
    );
  }
}

class VerifyClientSignatureSheetAsalariado extends StatelessWidget {
  final PageController pageController;
  final String cedula;
  final TypeForm typeform;
  const VerifyClientSignatureSheetAsalariado({
    super.key,
    required this.pageController,
    required this.cedula,
    required this.typeform,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.40,
      minChildSize: 0.30,
      maxChildSize: 0.50,
      expand: false,
      builder: (context, _) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xfff9fafb),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(28),
            ),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.12),
                blurRadius: 25,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: 42,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const Gap(18),
              ClientSignatureListData(
                onClientNoPossibleSignatureTap: () {
                  context
                      .read<SolicitudAslariadoHnCubit>()
                      .setClientSignatureStatus(
                        status: ClientSignatureStatus.noPossible,
                      );
                  context.pop();

                  context.pushTransparentRoute(BlocProvider.value(
                    value: context.read<SolicitudAslariadoHnCubit>(),
                    child: VerifyClientIfNotPossibleToSignWidget(
                      controller: pageController,
                      cedula: cedula,
                      typeform: typeform,
                    ),
                  ));
                },
                onClientPossibleSignatureTap: () {
                  context
                      .read<SolicitudAslariadoHnCubit>()
                      .setClientSignatureStatus(
                        status: ClientSignatureStatus.yes,
                      );
                  context.pop();
                  context.pushTransparentRoute(
                    BlocProvider.value(
                      value: context.read<SolicitudAslariadoHnCubit>(),
                      child: SolicitudSignatureClientWidgetAsalariado(
                        clientSignatureStatus: ClientSignatureStatus.yes,
                        pageController: pageController,
                        cedula: cedula,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class SolicitudSignatureClientWidgetAsalariado extends StatefulWidget {
  final ClientSignatureStatus clientSignatureStatus;
  final PageController pageController;
  final String cedula;
  const SolicitudSignatureClientWidgetAsalariado({
    super.key,
    required this.clientSignatureStatus,
    required this.pageController,
    required this.cedula,
  });

  @override
  State<SolicitudSignatureClientWidgetAsalariado> createState() =>
      _SolicitudSignatureClientWidgetAsalariadoState();
}

class _SolicitudSignatureClientWidgetAsalariadoState
    extends State<SolicitudSignatureClientWidgetAsalariado> {
  final formKey = GlobalKey<FormState>();
  final controller = SignatureController();

  @override
  Widget build(BuildContext context) {
    final localDbProvider = global<SolicitudesHnBoxService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Firma'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.clientSignatureStatus == ClientSignatureStatus.yes
                      ? 'Firma de solicitante de MiCredito'
                      : 'Firma de representante de Micredito',
                  style: const TextStyle(
                    color: AppColors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(10),
                Text(
                  'El usuario debe firmar correctamente',
                  style: TextStyle(
                    color: AppColors.greyWithOpacityV4,
                  ),
                ),
                const Gap(10),
                ClientSignatureSolicitud(
                  signatureController: controller,
                ),
                const Gap(30),
                CustomElevatedButton(
                  icon: const Icon(
                    Icons.edit,
                    color: AppColors.white,
                  ),
                  positionIcon: PositionIcon.left,
                  text: 'Enviar',
                  color: context.primaryColor(),
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    if (!isValidSignature(controller)) {
                      CustomAlertDialog(
                        context: context,
                        title: 'Ingresa una firma válida',
                        onDone: () => context.pop(),
                      ).showDialog(context);
                      return;
                    }
                    final signatureImage = await controller.toPngBytes();
                    final directory = await getApplicationDocumentsDirectory();
                    final filePath =
                        '${directory.path}/solicitud_signature_${DateTime.now().millisecondsSinceEpoch}.png';

                    // Guarda la imagen en el archivo
                    final file = File(filePath);
                    await file.writeAsBytes(signatureImage!);

                    final clientSignature = SignatureClientDb(
                      typeSolicitud: TypeForm.asalariado.codigo,
                      cedula: widget.cedula,
                      imageSignature: filePath,
                    );
                    localDbProvider.saveClientSignature(clientSignature);
                    widget.pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                    widget.pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                    if (!context.mounted) return;
                    context.pop();
                  },
                ),
                const Gap(10),
                Expanded(
                  flex: 0,
                  child: CustomElevatedButton(
                    alignment: MainAxisAlignment.center,
                    text: 'Regresar',
                    color: Colors.red,
                    onPressed: () => context.pop(),
                  ),
                ),
                const Gap(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ClientSignatureSolicitud extends StatefulWidget {
  final SignatureController signatureController;

  const ClientSignatureSolicitud({
    super.key,
    required this.signatureController,
  });

  @override
  State<ClientSignatureSolicitud> createState() =>
      _ClientSignatureSolicitudState();
}

class _ClientSignatureSolicitudState extends State<ClientSignatureSolicitud> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Stack(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.boxGrey,
              width: .9,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Signature(
              key: const Key('signature'),
              controller: widget.signatureController,
              height: size.height * .56,
              width: size.width * .9,
              backgroundColor: AppColors.white,
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: IconBorder.fromIcon(
            color: AppColors.red,
            icon: Icons.delete_forever,
            onTap: () => widget.signatureController.clear(),
            size: const Size(44, 44),
          ),
        ),
      ],
    );
  }
}

bool isValidSignature(SignatureController controller) {
  return controller.points.length >= 50;
}
