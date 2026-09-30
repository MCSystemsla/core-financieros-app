import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_search_by_document/analisis_search_by_document_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/user_by_document_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/fiadores/fiadores_hn_form_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/cliente_documento_form_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FiadoresSearchByDocumentScreen extends StatelessWidget {
  final FiadoresHnFormType typeForm;
  final int numeroSolicitud;
  const FiadoresSearchByDocumentScreen({
    super.key,
    required this.typeForm,
    required this.numeroSolicitud,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => AnalisisSearchByDocumentCubit(
        AnalisisRepositoryHNImpl(),
      ),
      child: Scaffold(
        backgroundColor: RedesignColors.background,
        body: SafeArea(
          bottom: false,
          child: _UserCedulaForm(
            typeForm: typeForm,
            numeroSolicitud: numeroSolicitud,
          ),
        ),
      ),
    );
  }
}

class _UserCedulaForm extends StatefulWidget {
  final FiadoresHnFormType typeForm;
  final int numeroSolicitud;
  const _UserCedulaForm({
    required this.typeForm,
    required this.numeroSolicitud,
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

  void _goToFiadorForm() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => BlocProvider.value(
          value: context.read<AnalisisSearchByDocumentCubit>(),
          child: FiadoresHnFormScreen(
            type: widget.typeForm,
            numeroSolicitud: widget.numeroSolicitud,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnalisisSearchByDocumentCubit,
        AnalisisSearchByDocumentState>(
      listener: (context, state) {
        if (state.status == UserByDocumentStatus.error) {
          CustomAlertDialog(
            context: context,
            title: state.errorMsg.contains('Sin conexión a internet')
                ? 'Necesitas conexión a internet para crear fiadores'
                : state.errorMsg,
            onDone: () => context.pop(),
          ).showDialog(context);
        }
        if (state.status == UserByDocumentStatus.done) {
          CustomAlertDialog(
            context: context,
            title:
                '${state.primerNombre} ${state.segundoNombre} listo para crear como fiador!!',
            onDone: _goToFiadorForm,
          ).showDialog(context, dialogType: DialogType.success);
        }
        if (state.status == UserByDocumentStatus.isNewUser) {
          _goToFiadorForm();
        }
      },
      builder: (context, state) {
        return ClienteDocumentoFormView(
          tipoCredito: '',
          title: 'Datos del fiador',
          subtitle: 'Solicitud #${widget.numeroSolicitud}. '
              'Ingresa los datos del fiador.',
          formKey: formKey,
          controllers: controllers,
          tipoDocumento: tipoDocumento,
          onTipoDocumentoChanged: (item) =>
              setState(() => tipoDocumento = item),
          isLoading: state.status == UserByDocumentStatus.inProgress,
          onSubmit: () {
            FocusScope.of(context).unfocus();
            if (!formKey.currentState!.validate()) return;
            context.read<AnalisisSearchByDocumentCubit>().getUserByDocument(
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
