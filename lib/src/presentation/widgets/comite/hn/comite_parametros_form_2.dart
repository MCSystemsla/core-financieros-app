import 'dart:developer';

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_solicitud_response.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/catalogo_frecuencia_pago/catalogo_frecuencia_pago.dart';
import 'package:core_financiero_app/src/presentation/bloc/comite/comite_aprobacion/comite_aprobacion_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/catalogo_frecuencia_pago_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/fuentes_financiamientos_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/tipos_credito_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/catalogo_type/catalogo_type.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';

import '../../../bloc/comite/comite_calculo_datos/comite_calculo_datos_cubit.dart';

class ComiteParametrosForm2 extends StatefulWidget {
  final ComiteSolicitudData data;

  const ComiteParametrosForm2({
    super.key,
    required this.data,
  });

  @override
  State<ComiteParametrosForm2> createState() => _ComiteParametrosForm2State();
}

class _ComiteParametrosForm2State extends State<ComiteParametrosForm2> {
  String? formadePago;
  String? formadePagoNombre;
  String? estado;
  String? monedaDesembolso;

  String? observaciones;
  Item? fuenteFinanciamiento;
  Item? tipoDesembolso;
  Item? tipoCredito;
  Item? programa;
  Item? periodicidadPrincipal;
  Item? periodicidadInteres;

  @override
  void initState() {
    super.initState();
    formadePago = widget.data.formaDePagoCodigo ?? 'MEN';
    formadePagoNombre = widget.data.formaDePagoNombre;
    estado = widget.data.estadoComiteCodigo;
    monedaDesembolso = widget.data.monedaNombre;
    observaciones = widget.data.observacion;
    tipoDesembolso = Item(
      name: widget.data.tipoDesembolsoNombre ??
          'TRANSFERENCIA BANCARIA A MICREDITO',
      value: widget.data.tipoDesembolsoCodigo ?? 'TRANSFERENCIAMICREDITO',
    );
    tipoCredito = Item(
      name: widget.data.tipoCreditoNombre ?? '',
      value: widget.data.tipoCreditoNombre ?? '',
    );
    programa = Item(
      name: widget.data.tipoProgramaNombre ?? '',
      value: widget.data.tipoProgramaCodigo ?? '',
    );
    fuenteFinanciamiento = Item(
      name: widget.data.fuenteFinanciamientoNombre ?? '',
      value: widget.data.fuenteFinanciamientoCodigo ?? '',
    );
    periodicidadPrincipal = Item(
      name: widget.data.periodicidadPrincipalNombre ?? '',
      value: widget.data.periodicidadPrincipalCodigo ?? '',
    );
    periodicidadInteres = Item(
      name: widget.data.periodicidadInteresNombre ?? '',
      value: widget.data.periodicidadInteresCodigo ?? '',
    );

    final cubit = context.read<ComiteAprobacionCubit>();
    final cubitCalculos = context.read<ComiteCalculoDatosCubit>();
    cubit.onFieldChanged(
      () => cubit.state.copyWith(
        fromaPagoCodigo: formadePago,
        estadoSolicitudCodigo: estado,
        periodicidadPrinicipalCodigo: periodicidadPrincipal?.value,
        observacion: observaciones,
        monedaDesembolsoCodigo: widget.data.monedaCodigo,
        tipoCreditoNombre: tipoCredito?.name,
        tipoProgramaCodigo: programa?.value,
        actividadCodigo: widget.data.actividadCodigo,
        sectorCodigo: widget.data.sectorCodigo,
        periodoGracia: widget.data.periodoGracia,
        fuenteFinanciamientoCodigo: fuenteFinanciamiento?.value,
        tipoDesembolsoCodigo: tipoDesembolso?.value,
        periodicidadInteresCodigo: periodicidadInteres?.value,
      ),
    );
    cubitCalculos.onFieldChanged(
      () => cubitCalculos.state.copyWith(
        monedaCodigo: widget.data.monedaCodigo,
        formaPagoCodigo: formadePago,
        plazoMeses: widget.data.plazoSolicitud,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ComiteAprobacionCubit>();
    final calculosCubit = context.read<ComiteCalculoDatosCubit>();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: BlocBuilder<ComiteCalculoDatosCubit, ComiteCalculoDatosState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                isRequired: true,
                selectedItem: Item(
                  name: monedaDesembolso ?? '',
                  value: monedaDesembolso,
                ),
                codigo: 'MONEDA',
                enabled: true,
                title: 'Moneda de desembolso',
                validator: (value) =>
                    ClassValidator.validateRequired(value?.value),
                onChanged: (item) {
                  if (item == null) return;
                  calculosCubit.onFieldChanged(
                    () => calculosCubit.state.copyWith(
                      monedaCodigo: item.value,
                    ),
                  );
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      monedaDesembolsoCodigo: item.value,
                    ),
                  );
                },
              ),
              const Gap(12),
              SearchDropdownWidget(
                isRequired: true,
                selectedItem: tipoDesembolso,
                codigo: CatalogoType.tipoDesembolsos.codigo,
                validator: (value) =>
                    ClassValidator.validateRequired(value?.value),
                enabled: true,
                title: 'Tipo Desembolso',
                onChanged: (item) {
                  if (item == null) return;
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      tipoDesembolsoCodigo: item.value,
                    ),
                  );
                  tipoDesembolso = item;
                  log(item.value);
                },
              ),
              const Gap(12),
              CatalogoFrecuenciaPagoDropdown(
                isRequired: true,
                selectedItem: CatalogoFrecuenciaItem(
                  valor: formadePago ?? 'MEN',
                  nombre: formadePagoNombre ?? 'MENSUAL',
                  meses: '',
                ),
                title: 'Forma de pago',
                validator: (value) =>
                    ClassValidator.validateRequired(value?.valor),
                onChanged: (value) {
                  if (value == null) return;
                  log('Forma de pago: ${value.valor}');
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      fromaPagoCodigo: value.valor,
                    ),
                  );
                  calculosCubit.onFieldChanged(
                    () => calculosCubit.state.copyWith(
                      formaPagoCodigo: value.valor,
                    ),
                  );
                },
              ),
              const Gap(12),
              CatalogoFrecuenciaPagoDropdown(
                isRequired: true,
                selectedItem: CatalogoFrecuenciaItem(
                  valor: periodicidadPrincipal?.value ?? '',
                  nombre: periodicidadPrincipal?.name ?? '',
                  meses: '',
                ),
                title: 'Periodicidad principal',
                validator: (value) =>
                    ClassValidator.validateRequired(value?.valor),
                onChanged: (value) {
                  if (value == null) return;
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      periodicidadPrinicipalCodigo: value.valor,
                    ),
                  );
                },
              ),
              const Gap(12),
              CatalogoFrecuenciaPagoDropdown(
                isRequired: true,
                selectedItem: CatalogoFrecuenciaItem(
                  valor: periodicidadInteres?.value ?? '',
                  nombre: periodicidadInteres?.name ?? '',
                  meses: '',
                ),
                onChanged: (item) {
                  if (item == null) return;
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      periodicidadInteresCodigo: item.valor,
                    ),
                  );
                },
                title: 'Periodicidad interes',
                validator: (value) =>
                    ClassValidator.validateRequired(value?.valor),
              ),
              const Gap(12),
              SearchDropdownWidget(
                isRequired: true,
                title: 'Sector',
                codigo: CatalogoType.sectorEconomico.codigo,
                validator: (value) =>
                    ClassValidator.validateRequired(value?.value),
                selectedItem: Item(
                  name: widget.data.sectorNombre ?? '',
                  value: widget.data.sectorCodigo,
                ),
                onChanged: (item) {
                  if (item == null) return;
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      sectorCodigo: item.value,
                    ),
                  );
                },
              ),
              const Gap(12),
              CatalogoActividadesCNBSDropdown(
                selectedItem: ActiivdadCNBS(
                  esAPNFD: false,
                  valor: widget.data.actividadCodigo ?? '',
                  nombre: widget.data.actividadNombre ?? '',
                ),
                isRequired: true,
                enabled: true,
                validator: (value) =>
                    ClassValidator.validateRequired(value?.valor),
                hintText: 'selecciona actividad económica',
                onChanged: (item) {
                  if (item == null || !mounted) return;
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      actividadCodigo: item.valor,
                    ),
                  );
                },
                title: 'Actividad',
              ),
              const Gap(12),
              FuentesFinanciamientosDropdown(
                isRequired: true,
                selectedItem: fuenteFinanciamiento,
                onChanged: (item) {
                  if (item == null) return;
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      fuenteFinanciamientoCodigo: item.value,
                    ),
                  );
                },
                validator: (value) =>
                    ClassValidator.validateRequired(value?.value),
              ),
              const Gap(12),
              OutlineTextfieldWidget(
                initialValue: widget.data.periodoGracia
                    ?.toCurrencyString()
                    .toNullIfEmptyOrZero(),
                title: 'Periodo de gracia',
                icon: Icon(
                  Icons.timer,
                  color: AppColors.getPrimaryColor(),
                ),
                textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      periodoGracia: int.tryParse(value) ?? 0,
                    ),
                  );
                },
              ),
              const Gap(12),
              TiposCreditoDropdown(
                selectedItem: tipoCredito,
                isRequired: true,
                validator: (value) =>
                    ClassValidator.validateRequired(value?.value.toString()),
                onChanged: (item) {
                  if (item == null) return;
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      tipoCreditoNombre: item.name,
                    ),
                  );
                },
              ),
              const Gap(12),
              SearchDropdownWidget(
                isRequired: true,
                selectedItem: programa,
                codigo: CatalogoType.programa.codigo,
                validator: (value) =>
                    ClassValidator.validateRequired(value?.value),
                title: 'Programa',
                onChanged: (item) {
                  if (item == null) return;
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      tipoProgramaCodigo: item.value,
                    ),
                  );
                },
              ),
              const Gap(12),
              OutlineTextfieldWidget(
                initialValue: observaciones,
                title: 'Observaciones',
                // validator: (value) => ClassValidator.validateRequired(value),
                icon: Icon(
                  Icons.comment,
                  color: AppColors.getPrimaryColor(),
                ),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      observacion: value,
                    ),
                  );
                },
              ),
              // const Gap(12),

              const Gap(20),
            ],
          );
        },
      ),
    );
  }
}
