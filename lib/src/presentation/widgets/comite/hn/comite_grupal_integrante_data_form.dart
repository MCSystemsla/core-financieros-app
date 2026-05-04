import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/select_date/select_date_helper.dart';
import 'package:core_financiero_app/src/config/helpers/snackbar/custom_snackbar.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/comite/comite__approved_grupal_schema.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_solicitud_response.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/catalogo_frecuencia_pago/catalogo_frecuencia_pago.dart';
import 'package:core_financiero_app/src/domain/repository/comite/hn/comite_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/comite/hn/v2_servicios_comite_grupal_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/catalogo_frecuencia_pago_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/fuentes_financiamientos_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/tipos_credito_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/switch/custom_switch.dart';
import 'package:core_financiero_app/src/utils/extensions/catalogo_type/catalogo_type.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';

import '../../../bloc/comite/comite_create_servicios/comite_create_servicios_cubit.dart';
import '../../../bloc/comite/comite_servicios/comite_servicios_cubit.dart';
import '../../../bloc/comite/v2_comite_calculo_datos_grupal/v2_comite_calculo_datos_grupal_cubit.dart';
import '../../../bloc/comite/v2_comite_configuration_grupal/v2_comite_configuration_grupal_cubit.dart';
import '../../../bloc/comite/v2_comite_solicitudes_grupales/v2_comite_solicitudes_grupales_cubit.dart';

class IntegranteDataForm extends StatefulWidget {
  final ComiteSolicitudResponse data;
  final String tipoSolicitud;
  final int numeroSolicitud;
  final int actaId;

  const IntegranteDataForm({
    super.key,
    required this.data,
    required this.tipoSolicitud,
    required this.numeroSolicitud,
    required this.actaId,
  });

  @override
  State<IntegranteDataForm> createState() => _IntegranteDataFormState();
}

class _IntegranteDataFormState extends State<IntegranteDataForm> {
  num? monto;
  Item? sector;
  ActiivdadCNBS? actividad;
  bool esReestructuracion = false;
  bool alVencimiento = false;
  bool cuotaNivelada = false;
  bool mantienesTasa = false;
  bool financiaComisionYSeguros = false;
  int plazoMeses = 0;
  Item? producto;

  @override
  void initState() {
    super.initState();
    monto = widget.data.data.monto?.toDouble();
    esReestructuracion = widget.data.data.esReestructuracion ?? false;
    alVencimiento = widget.data.data.alVencimiento ?? false;
    financiaComisionYSeguros = widget.data.data.comisionFinanciada ?? false;
    cuotaNivelada = true;
    sector = Item(
      name: widget.data.data.sectorNombre ?? '',
      value: widget.data.data.sectorCodigo,
    );
    actividad = ActiivdadCNBS(
      valor: widget.data.data.actividadCodigo ?? '',
      nombre: widget.data.data.actividadNombre ?? '',
      esAPNFD: false,
    );
    plazoMeses = widget.data.data.plazoSolicitud ?? 0;
    producto = Item(
      name: widget.data.data.nombreProducto ?? '',
      value: widget.data.data.codigoProducto ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    final configCubit = context.watch<V2ComiteConfigurationGrupalCubit>();
    final calculoCubit = context.read<V2ComiteCalculoDatosGrupalCubit>();

    return BlocConsumer<V2ComiteCalculoDatosGrupalCubit,
        V2ComiteCalculoDatosGrupalState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == Status.done) {
          _handleSubmission(
            context,
            configCubit,
            state.data?.data.interes.tasaInteresCorriente.toDouble() ?? 0,
            state.data?.data.interes.tasaInteresMoratorio.toDouble() ?? 0,
            state.data?.data.comision.tasa ?? 0,
            state.data?.data.comision.monto ?? 0,
            state.data?.data.seguros.vida ?? 0,
          );
        }
        if (state.status == Status.error) {
          showV2CustomSnackbar(
            context,
            title: state.errorMsg,
            type: SnackbarType.error,
          );
        }
      },
      builder: (context, state) {
        return Form(
          child: Column(
            children: [
              _FormCard(
                child: Column(
                  children: [
                    if (state.sharedIndividuals) ...[
                      _buildInputsSharedIndividuals(context, widget.data),
                    ],
                    _buildMainInputs(context, calculoCubit),
                    const Gap(12),
                    _buildParametersSection(context, state, calculoCubit),
                  ],
                ),
              ),
              const Gap(20),
              _buildSubmitButton(context, state, configCubit),
              const Gap(30),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInputsSharedIndividuals(
      BuildContext context, ComiteSolicitudResponse data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 20),
          child: Text(
            'Datos del crédito',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const Gap(12),
        SearchDropdownWidget(
          key: const Key('productoDropdown'),
          selectedItem: Item(
            name: data.data.nombreProducto ?? '',
            value: data.data.codigoProducto ?? '',
          ),
          validator: (value) => ClassValidator.validateRequired(
            value?.value.toString(),
          ),
          codigo: 'PRODUCTO',
          onChanged: (item) {
            if (item == null) return;
          },
          title: 'Producto',
        ),
        const Divider(),
        OutlineTextfieldWidget(
          initialValue: plazoMeses.toString(),
          key: const Key('plazoDropdown'),
          title: 'Plazo en meses',
          validator: (value) => ClassValidator.validateRequired(value),
          icon: Icon(
            Icons.schedule_outlined,
            color: AppColors.getPrimaryColor(),
          ),
          textInputType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChange: (value) {
            final newValue = toNumericString(value);
          },
        ),
        const Gap(20),
        OutlineTextfieldWidget(
          key: const Key('periodoGraciaDropdown'),
          initialValue: data.data.periodoGracia.toString(),
          title: 'Periodo de gracia',
          textInputType: TextInputType.number,
          icon: Icon(
            Icons.schedule_outlined,
            color: AppColors.getPrimaryColor(),
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChange: (value) {
            final newValue = toNumericString(value);
          },
        ),
        const Gap(20),
        FuentesFinanciamientosDropdown(
          key: const Key('fuenteFinanciamientoDropdown'),
          selectedItem: Item(
            name: data.data.fuenteFinanciamientoNombre ?? '',
            value: data.data.fuenteFinanciamientoCodigo ?? '',
          ),
          isRequired: true,
          onChanged: (item) {
            if (item == null) return;
          },
          validator: (value) => ClassValidator.validateRequired(value?.value),
        ),
        const Gap(20),
        OutlineTextfieldWidget(
          key: const Key('fechaPrimerPagoDropdown'),
          title: 'Fecha de primer pago',
          onTap: () async {
            final date = await pickDate(context);
            if (date == null) return;
          },
          readOnly: true,
          icon: Icon(
            Icons.calendar_today_outlined,
            color: AppColors.getPrimaryColor(),
          ),
          inputFormatters: [
            UpperCaseTextFormatter(),
          ],
          onChange: (value) {},
        ),
        const Gap(20),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 20),
          child: Text(
            'Parametros',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const Gap(12),
        SearchDropdownWidget(
          key: const Key('monedaDropdown'),
          selectedItem: Item(
            name: data.data.monedaNombre ?? '',
            value: data.data.monedaCodigo ?? '',
          ),
          isRequired: true,
          codigo: 'MONEDA',
          enabled: true,
          title: 'Moneda de desembolso',
          validator: (value) => ClassValidator.validateRequired(value?.value),
          onChanged: (item) {
            if (item == null) return;
          },
        ),
        const Gap(12),
        SearchDropdownWidget(
          key: const Key('tipoDesembolsoDropdown'),
          selectedItem: Item(
            name: data.data.tipoDesembolsoNombre ?? '',
            value: data.data.tipoDesembolsoCodigo ?? '',
          ),
          isRequired: true,
          codigo: CatalogoType.tipoDesembolsos.codigo,
          validator: (value) => ClassValidator.validateRequired(value?.value),
          enabled: true,
          title: 'Tipo Desembolso',
          onChanged: (item) {
            if (item == null) return;
          },
        ),
        const Gap(12),
        CatalogoFrecuenciaPagoDropdown(
          key: const Key('formaDePagoDropdown'),
          selectedItem: CatalogoFrecuenciaItem(
            valor: data.data.formaDePagoCodigo ?? '',
            nombre: data.data.formaDePagoNombre ?? '',
            meses: '',
          ),
          isRequired: true,
          title: 'Forma de pago',
          validator: (value) => ClassValidator.validateRequired(value?.valor),
          onChanged: (value) {
            if (value == null) return;
          },
        ),
        const Gap(12),
        CatalogoFrecuenciaPagoDropdown(
          key: const Key('periodicidadPrincipalDropdown'),
          selectedItem: CatalogoFrecuenciaItem(
            valor: data.data.periodicidadPrincipalCodigo ?? '',
            nombre: data.data.periodicidadPrincipalNombre ?? '',
            meses: '',
          ),
          isRequired: true,
          title: 'Periodicidad principal',
          validator: (value) => ClassValidator.validateRequired(value?.valor),
          onChanged: (value) {
            if (value == null) return;
          },
        ),
        const Gap(12),
        CatalogoFrecuenciaPagoDropdown(
          key: const Key('periodicidadInteresDropdown'),
          selectedItem: CatalogoFrecuenciaItem(
            valor: data.data.periodicidadInteresCodigo ?? '',
            nombre: data.data.periodicidadInteresNombre ?? '',
            meses: '',
          ),
          isRequired: true,
          onChanged: (item) {
            if (item == null) return;
          },
          title: 'Periodicidad interes',
          validator: (value) => ClassValidator.validateRequired(value?.valor),
        ),
        const Gap(12),
        TiposCreditoDropdown(
          key: const Key('tipoCreditoDropdown'),
          selectedItem: Item(
            name: data.data.tipoCreditoNombre ?? '',
            value: data.data.tipoCreditoNombre ?? '',
          ),
          // selectedItem: tipoCredito,
          isRequired: true,
          validator: (value) =>
              ClassValidator.validateRequired(value?.value.toString()),
          onChanged: (item) {
            if (item == null) return;
          },
        ),
        const Gap(12),
        SearchDropdownWidget(
          key: const Key('tipoProgramaDropdown'),
          selectedItem: Item(
            name: data.data.tipoProgramaNombre ?? '',
            value: data.data.tipoProgramaCodigo ?? '',
          ),
          isRequired: true,
          // selectedItem: programa,
          codigo: CatalogoType.programa.codigo,
          validator: (value) => ClassValidator.validateRequired(value?.value),
          title: 'Programa',
          onChanged: (item) {
            if (item == null) return;
          },
        ),
        const Gap(12),
        OutlineTextfieldWidget(
          key: const Key('observacionesDropdown'),
          initialValue: data.data.observacion,
          title: 'Observaciones',
          // validator: (value) => ClassValidator.validateRequired(value),
          icon: Icon(
            Icons.comment,
            color: AppColors.getPrimaryColor(),
          ),
          inputFormatters: [
            UpperCaseTextFormatter(),
          ],
          onChange: (value) {},
        ),
      ],
    );
  }

  // --- Funciones de Construcción de UI ---
  Widget _buildMainInputs(
      BuildContext context, V2ComiteCalculoDatosGrupalCubit cubit) {
    return Column(
      children: [
        OutlineTextfieldWidget(
          key: const Key('montoDropdown'),
          initialValue: monto?.toCurrencyString(),
          title: 'Monto solicitado',
          hintText: 'Ingrese el monto solicitado',
          inputFormatters: [CurrencyInputFormatter()],
          isRequired: true,
          icon: const Icon(Icons.wallet, color: Colors.green),
          onChange: (value) {
            final newValue = toNumericString(value, allowAllZeroes: true);
            monto = num.tryParse(newValue);

            cubit.onFieldChanged(
              () => cubit.state.copyWith(monto: num.tryParse(newValue)),
            );
          },
        ),
        const Gap(12),
        SearchDropdownWidget(
          key: const Key('sectorDropdown'),
          isRequired: true,
          title: 'Sector',
          codigo: CatalogoType.sectorEconomico.codigo,
          validator: (v) => ClassValidator.validateRequired(v?.value),
          selectedItem: sector,
          onChanged: (item) {
            if (item == null) return;
            sector = item;
          },
        ),
        const Gap(12),
        CatalogoActividadesCNBSDropdown(
          key: const Key('actividadDropdown'),
          selectedItem: actividad,
          enabled: true,
          hintText: 'Selecciona una actividad',
          isRequired: true,
          title: 'Actividad',
          onChanged: (item) {
            if (item == null) return;
            actividad = item;
          },
        ),
      ],
    );
  }

  Widget _buildParametersSection(
      BuildContext context,
      V2ComiteCalculoDatosGrupalState state,
      V2ComiteCalculoDatosGrupalCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 20, bottom: 12),
          child: Text(
            'Parámetros',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        CustomSwitch(
          value: esReestructuracion,
          subtitle: 'Si es un acta de reestructuración?',
          title: 'Es Reestructuración',
          onChanged: (v) {
            setState(() {
              esReestructuracion = v;
            });
          },
        ),
        const Divider(),
        CustomSwitch(
          value: alVencimiento,
          subtitle: 'Si es un acta de al vencimiento?',
          title: 'Al vencimiento',
          onChanged: (v) {
            setState(() {
              alVencimiento = v;
            });
          },
        ),
        const Divider(),
        CustomSwitch(
          title: 'Mantener tasa interés anterior',
          value: mantienesTasa,
          onChanged: (v) {
            setState(() {
              mantienesTasa = v;
            });
          },
          subtitle: 'Si se mantiene la tasa de interés?',
        ),
        const Divider(),
        CustomSwitch(
          title: 'Financiar comision y seguros',
          subtitle: 'Si se financia la comisión y los seguros?',
          value: financiaComisionYSeguros,
          onChanged: (v) {
            setState(() {
              financiaComisionYSeguros = v;
            });
          },
        ),
        const Divider(),
        CustomSwitch(
          title: 'Cuota nivelada',
          subtitle: 'Cuota nivelada',
          value: cuotaNivelada,
          onChanged: (v) {
            setState(() {
              cuotaNivelada = v;
            });
          },
        ),
      ],
    );
  }

  Widget _buildSubmitButton(
    BuildContext context,
    V2ComiteCalculoDatosGrupalState state,
    V2ComiteConfigurationGrupalCubit configCubit,
  ) {
    final isLoading = state.status == Status.inProgress;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: CustomElevatedButton(
          enabled: !isLoading,
          icon: isLoading
              ? const SizedBox(
                  width: 15,
                  height: 15,
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                    color: Colors.white,
                  ),
                )
              : const Icon(Icons.check_circle, color: Colors.white),
          color: Colors.green,
          text: isLoading ? 'Verificando...' : 'Verificar integrante',
          onPressed: () {
            if (!configCubit.state.dataAreLoaded) {
              showV2CustomSnackbar(
                context,
                title: 'Verificación incompleta',
                type: SnackbarType.warning,
                message:
                    'Es necesario crear la configuración compartida para continuar.',
              );

              return;
            }
            context.read<V2ComiteCalculoDatosGrupalCubit>().calcularDatos(
                  esMantieneTasa: mantienesTasa,
                  esReestructuracion: esReestructuracion,
                  financiaComisionYSeguros: financiaComisionYSeguros,
                  monto: monto ?? 0,
                  actaID: widget.data.data.id ?? 0,
                  comisionSegurosFinanciado: 0,
                  fechaPrimerPago: configCubit.state.fechaPrimerPago,
                  formaPagoCodigo: configCubit.state.formaDePagoCodigo,
                  monedaCodigo: configCubit.state.monedaCodigo,
                  plazoMeses: configCubit.state.plazo,
                  productoCodigo: configCubit.state.productoCodigo,
                  paisCodigo: 'HN',
                  tipoCobroSaldoDeudorCodigo:
                      widget.data.data.formaCobroSaldoDeudorCodigo ?? '',
                );
          }),
    );
  }

  Future<void> _handleSubmission(
    BuildContext context,
    V2ComiteConfigurationGrupalCubit config,
    double interesCorriente,
    double interesMoratorio,
    double porcentajeComision,
    double comisionSegurosFinanciado,
    double seguroMemorialMensual,
  ) async {
    final data = widget.data.data;
    final state = config.state;

    final member = ComiteGroupMember(
      numeroSolicitud: widget.numeroSolicitud,
      tipoSolicitudCodigo: widget.tipoSolicitud,
      observacion: state.observacion,
      formaPagoCodigo: state.formaDePagoCodigo,
      productoCodigo: state.productoCodigo,
      modificaActa: GrupalModificaActa(
        monto: monto ?? 0,
        montoSeguro: data.montoSeguroVida ?? 0,
        plazo: data.plazoSolicitud ?? 0,
        sectorCodigo: sector?.value ?? '',
        actividadCodigo: actividad?.valor ?? '',
        fuenteFinanciamientoCodigo: state.fuenteFinanciamientoCodigo,
        monedaDesembolsoCodigo: state.monedaCodigo,
        tipoDesembolsoCodigo: state.tipoDesembolsoCodigo,
        promotorId: data.oficialCreditoID ?? 0,
        esReestructurado: esReestructuracion,
        cuotaNivelada: cuotaNivelada,
        montoSinComision: monto ?? 0,
        periodoGracia: state.periodoGracia,
        porcentajeComision: porcentajeComision,
        tasaInteresCorriente: interesCorriente.toInt(),
        tasaInteresMoratorio: interesMoratorio.toInt(),
        comisionFinanciada: false,
        esRetencion: false,
        seguroMemorialMensual: seguroMemorialMensual.toInt(),
      ),
      insertaAprobacion: GrupalInsertaAprobacion(
        periodicidadPrinicipalCodigo: state.periodicidadPrincipalCodigo,
        periodicidadInteresCodigo: state.periodicidadInteresCodigo,
        alVencimiento: data.alVencimiento ?? false,
        fechaAprobacion: DateTime.now(),
        aprobacionDigital: false,
        esRecalculado: false,
      ),
    );

    final isServicesCreated = await context.pushTransparentRoute(
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => ComiteServiciosCubit(
                  ComiteRepositoryHNImpl(),
                )..getComiteServicios(
                    comiteId: data.id ?? 0,
                    numeroSolicitud: widget.numeroSolicitud,
                    plazoCredito: data.plazoSolicitud ?? 0,
                    montoCredito: monto?.toDouble() ?? 0,
                    capitalAdeudado: 0,
                    primaSegurosDanios: 0,
                    tipoSolicitud: widget.tipoSolicitud,
                  ),
              ),
              BlocProvider(
                create: (_) =>
                    ComiteCreateServiciosCubit(ComiteRepositoryHNImpl()),
              ),
            ],
            child: V2ServiciosComiteGrupalScreen(
              comiteId: data.id ?? 0,
              monto: monto?.toDouble() ?? 0,
              plazoCredito: data.plazoSolicitud ?? 0,
            ),
          ),
          backgroundColor: const Color(0xffF1F1F1),
        ) ??
        false;

    if (!context.mounted) return;

    if (!isServicesCreated) {
      showV2CustomSnackbar(
        context,
        title: 'Acta no verificada',
        type: SnackbarType.error,
        message: 'Debes crear los servicios para poder verificar el acta',
      );
      return;
    }

    final isVerified =
        context.read<V2ComiteSolicitudesGrupalesCubit>().addMemberToGroup(
              context,
              member: member,
              isServicesCreated: isServicesCreated,
            );

    if (isVerified) {
      showV2CustomSnackbar(
        context,
        title: 'Acta Verificada',
        type: SnackbarType.success,
        message: 'Acta verificada con éxito',
      );
    }
  }
}

// Widget de soporte para el diseño de tarjeta
class _FormCard extends StatelessWidget {
  final Widget child;
  const _FormCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))
        ],
      ),
      child: child,
    );
  }
}
