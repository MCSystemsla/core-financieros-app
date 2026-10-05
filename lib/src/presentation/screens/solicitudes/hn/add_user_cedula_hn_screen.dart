import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/user_by_document_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/hn/crear_solicitud_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/ni/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/cliente_documento_form_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddUserCedulaHnScreen extends StatelessWidget {
  final TypeForm typeForm;
  const AddUserCedulaHnScreen({
    super.key,
    required this.typeForm,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => UserByDocumentCubit(
        SolicitudesCreditoHnRepositoryImpl(),
      ),
      child: Scaffold(
        backgroundColor: RedesignColors.background,
        body: SafeArea(
          bottom: false,
          child: _UserCedulaForm(
            typeForm: typeForm,
          ),
        ),
      ),
    );
  }
}

class _UserCedulaForm extends StatefulWidget {
  final TypeForm typeForm;
  const _UserCedulaForm({
    required this.typeForm,
  });

  @override
  State<_UserCedulaForm> createState() => _UserCedulaFormState();
}

class _UserCedulaFormState extends State<_UserCedulaForm> {
  Item? tipoDocumento;
  final formKey = GlobalKey<FormState>();
  final controllers = ClienteDocumentoControllers();

  @override
  void dispose() {
    controllers.dispose();
    super.dispose();
  }

  void _goToCrearSolicitud() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => BlocProvider.value(
          value: context.read<UserByDocumentCubit>(),
          child: CrearSolicitudHnScreen(
            typeForm: widget.typeForm,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserByDocumentCubit, UserByDocumentState>(
      listener: (context, state) {
        if (state.status == UserByDocumentStatus.error) {
          CustomAlertDialog(
            context: context,
            title: state.errorMsg.contains('Sin conexión a internet')
                ? 'No tienes conexión a internet, pero aun puedes crear solicitudes'
                : state.errorMsg,
            onDone: () {
              if (state.errorMsg.contains('Sin conexión a internet')) {
                _goToCrearSolicitud();
                return;
              }
              context.pop();
            },
          ).showDialog(context);
        }
        if (state.status == UserByDocumentStatus.done) {
          CustomAlertDialog(
            context: context,
            title:
                '${state.primerNombre} ${state.segundoNombre} listo para crear solicitud!!',
            onDone: _goToCrearSolicitud,
          ).showDialog(context, dialogType: DialogType.success);
        }
        if (state.status == UserByDocumentStatus.isNewUser) {
          _goToCrearSolicitud();
        }
      },
      builder: (context, state) {
        return ClienteDocumentoFormView(
          tipoCredito: 'comercial',
          formKey: formKey,
          controllers: controllers,
          tipoDocumento: tipoDocumento,
          onTipoDocumentoChanged: (item) =>
              setState(() => tipoDocumento = item),
          isLoading: state.status == UserByDocumentStatus.inProgress,
          onSubmit: () {
            FocusScope.of(context).unfocus();
            if (!formKey.currentState!.validate()) return;
            context.read<UserByDocumentCubit>().getUserByDocument(
                  primerNombre: controllers.primerNombre.text.trim(),
                  segundoNombre: controllers.segundoNombre.text.trim(),
                  primerApellido: controllers.primerApellido.text.trim(),
                  segundoApellido: controllers.segundoApellido.text.trim(),
                  cedula: controllers.documento.text.trim(),
                  tipoDocumentoCodigo: tipoDocumento?.value,
                );
          },
        );
      },
    );
  }
}
