import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_solicitud_response.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/comite/hn/comite_comision_en_desembolso_form.dart';
import 'package:core_financiero_app/src/presentation/widgets/comite/hn/comite_datos_del_credito_form.dart';
import 'package:core_financiero_app/src/presentation/widgets/comite/hn/comite_parametros_form_2.dart';
import 'package:core_financiero_app/src/presentation/widgets/comite/hn/comite_parametros_form_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/comite/hn/comite_servicios_acta_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/comite/hn/comite_user_info.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../bloc/comite/comite_aprobacion/comite_aprobacion_cubit.dart';
import '../../../bloc/comite/comite_calculo_datos/comite_calculo_datos_cubit.dart';

class ComiteGeneralForm extends StatefulWidget {
  final PageController pageController;
  final ComiteSolicitudData data;
  final int actaId;
  final String tipoSolicitud;
  const ComiteGeneralForm({
    super.key,
    required this.pageController,
    required this.data,
    required this.actaId,
    required this.tipoSolicitud,
  });
  @override
  State<ComiteGeneralForm> createState() => _ComiteGeneralFormState();
}

class _ComiteGeneralFormState extends State<ComiteGeneralForm>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormState>();
  bool isCalcularDatosClicked = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SafeArea(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(child: _buildFormContent()),
            _buildFooterButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildFormContent() {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(20),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 20),
            child: Text(
              'General',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          ComiteUserInfoWidget(data: widget.data),
          ComiteParametrosForm(data: widget.data),
          const Gap(12),
          ComiteDatosDelCreditoForm(data: widget.data),
          const Gap(12),
          ComiteComisionEnDesembolsoForm(
            data: widget.data,
            numeroSolicitud:
                int.tryParse(widget.data.numeroSolicitud ?? '') ?? 0,
            tipoSolicitud: widget.tipoSolicitud,
          ),
          const Gap(12),
          ComiteParametrosForm2(data: widget.data),
        ],
      ),
    );
  }

  Widget _buildFooterButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _buildCalcularButton(),
          const Gap(20),
          _buildAgregarServiciosButton(),
        ],
      ),
    );
  }

  Widget _buildCalcularButton() {
    return BlocConsumer<ComiteCalculoDatosCubit, ComiteCalculoDatosState>(
      buildWhen: (p, c) => p.status != c.status,
      listenWhen: (p, c) => p.status != c.status,
      listener: (context, state) {
        if (state.status == Status.done) {
          CustomAlertDialog(
            context: context,
            title: 'Datos calculados exitosamente',
            onDone: () => context.pop(),
          ).showDialog(context, dialogType: DialogType.success);
        }

        if (state.status == Status.error) {
          CustomAlertDialog(
            context: context,
            title: state.errorMsg,
            onDone: () => context.pop(),
          ).showDialog(context, dialogType: DialogType.error);
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: CustomElevatedButton(
            color: Colors.indigo,
            enabled: state.status != Status.inProgress,
            text: state.status == Status.inProgress
                ? 'Calculando...'
                : 'Calcular Datos',
            onPressed: _onCalcularPressed,
          ),
        );
      },
    );
  }

  void _onCalcularPressed() {
    if (!formKey.currentState!.validate()) {
      CustomAlertDialog(
        context: context,
        title: 'Debes completar los campos requeridos para continuar.',
        onDone: () => context.pop(),
      ).showDialog(context, dialogType: DialogType.warning);
      return;
    }

    setState(() {
      isCalcularDatosClicked = true;
    });

    context.read<ComiteCalculoDatosCubit>().calcularDatos(
          actaID: widget.actaId,
        );
  }

  Widget _buildAgregarServiciosButton() {
    return BlocBuilder<ComiteAprobacionCubit, ComiteAprobacionState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: CustomElevatedButton(
            // ignore: deprecated_member_use
            color: AppColors.greenLatern.withOpacity(0.4),
            text: 'Agregar Servicios',
            onPressed: () => _onAgregarServiciosPressed(state),
          ),
        );
      },
    );
  }

  void _onAgregarServiciosPressed(ComiteAprobacionState state) {
    if (!formKey.currentState!.validate()) {
      CustomAlertDialog(
        context: context,
        title: 'Debes completar los campos requeridos para continuar.',
        onDone: () => context.pop(),
      ).showDialog(context, dialogType: DialogType.warning);
      return;
    }

    if (!isCalcularDatosClicked) {
      CustomAlertDialog(
        context: context,
        title: 'Debes primero calcular los datos para continuar',
        onDone: () => context.pop(),
      ).showDialog(context, dialogType: DialogType.warning);
      return;
    }

    final cubitCalculos = context.read<ComiteCalculoDatosCubit>();

    context.pushTransparentRoute(MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: context.read<ComiteAprobacionCubit>(),
        ),
        BlocProvider.value(
          value: context.read<ComiteCalculoDatosCubit>(),
        ),
      ],
      child: ComiteServiciosActaWidget(
        fechaPrimerPago: DateTime.parse(cubitCalculos.state.fechaPrimerPago),
        comiteId: widget.data.id ?? 0,
        numeroSolicitud: state.numeroSolicitud,
        capitalAdeudado: 0,
        montoCredito: state.monto,
        plazoCredito: state.plazo,
        primaSegurosDanios: 0,
        tipoSolicitud: state.tipoSolicitudCodigo,
        porcentajeComision: cubitCalculos.state.data?.data.comision.monto ?? 0,
        montoSeguro:
            cubitCalculos.state.data?.data.seguros.montoTotalSeguros ?? 0,
        montoSinComision: cubitCalculos.state.monto.toDouble(),
        montoTelemedicinaAprobada:
            cubitCalculos.state.data?.data.seguros.telemedicina ?? 0,
        seguroMapfre: cubitCalculos.state.data?.data.seguros.mapfre ?? 0,
        porcentajeSaldoDeudorAprobado:
            cubitCalculos.state.data?.data.comision.tasa ?? 0,
        tasaInteresCorriente:
            cubitCalculos.state.data?.data.interes.tasaInteresCorriente ?? 0,
        tasaInteresMoratorio:
            cubitCalculos.state.data?.data.interes.tasaInteresMoratorio ?? 0,
        seguoMemorialMensual: cubitCalculos.state.data?.data.seguros.vida ?? 0,
      ),
    ));
    setState(() {
      isCalcularDatosClicked = false;
    });
  }

  @override
  bool get wantKeepAlive => true;
}
