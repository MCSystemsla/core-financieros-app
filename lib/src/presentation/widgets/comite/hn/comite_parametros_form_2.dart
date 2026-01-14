import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_solicitud_response.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/catalogo_frecuencia_pago/catalogo_frecuencia_pago.dart';
import 'package:core_financiero_app/src/presentation/bloc/comite/comite_aprobacion/comite_aprobacion_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/catalogo_frecuencia_pago_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

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
  String? estado;
  String? monedaDesembolso;
  String? periodicidadPrincipalCodigo;
  String? observaciones;

  @override
  void initState() {
    super.initState();
    formadePago = widget.data.formaDePagoCodigo;
    estado = widget.data.estadoComiteCodigo;
    monedaDesembolso = widget.data.monedaNombre;
    periodicidadPrincipalCodigo = widget.data.periodicidadCodigo;
    observaciones = widget.data.observacion;
    final cubit = context.read<ComiteAprobacionCubit>();
    cubit.onFieldChanged(
      () => cubit.state.copyWith(
        fromaPagoCodigo: formadePago,
        estadoSolicitudCodigo: estado,
        periodicidadPrinicipalCodigo: periodicidadPrincipalCodigo,
        observacion: observaciones,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ComiteAprobacionCubit>();

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 20),
            child: Text(
              'Parametros',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const Gap(12),
          OutlineTextfieldWidget(
            initialValue: monedaDesembolso,
            readOnly: true,
            title: 'Moneda de desembolso',
            icon: Icon(
              Icons.inventory_2_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(12),
          OutlineTextfieldWidget(
            initialValue: estado,
            title: 'Estado',
            icon: Icon(
              Icons.inventory_2_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(12),
          CatalogoFrecuenciaPagoDropdown(
            selectedItem: CatalogoFrecuenciaItem(
              valor: formadePago ?? '',
              nombre: formadePago ?? '',
              meses: '',
            ),
            title: 'Forma de pago',
            validator: (value) => ClassValidator.validateRequired(value?.valor),
            onChanged: (value) {
              if (value == null) return;
              cubit.onFieldChanged(
                () => cubit.state.copyWith(
                  fromaPagoCodigo: value.valor,
                ),
              );
            },
          ),
          const Gap(12),
          CatalogoFrecuenciaPagoDropdown(
            title: 'Periodicidad principal',
            validator: (value) => ClassValidator.validateRequired(value?.valor),
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
            onChanged: (item) {
              if (item == null) return;
              cubit.onFieldChanged(
                () => cubit.state.copyWith(
                  periodicidadInteresCodigo: item.valor,
                ),
              );
            },
            title: 'Periodicidad interes',
            validator: (value) => ClassValidator.validateRequired(value?.valor),
          ),
          const Gap(12),
          OutlineTextfieldWidget(
            initialValue: widget.data.sectorNombre,
            readOnly: true,
            title: 'Sector',
            icon: Icon(
              Icons.inventory_2_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            validator: (value) => ClassValidator.validateRequired(value),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(12),
          OutlineTextfieldWidget(
            readOnly: true,
            initialValue: widget.data.actividadNombre,
            title: 'Actividad',
            icon: Icon(
              Icons.inventory_2_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(12),
          OutlineTextfieldWidget(
            readOnly: true,
            initialValue: widget.data.nombreOficialCredito,
            title: 'Promotor',
            icon: Icon(
              Icons.inventory_2_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(12),
          OutlineTextfieldWidget(
            initialValue: widget.data.fuenteFinanciamientoNombre,
            title: 'Fuente de financiamiento',
            readOnly: true,
            icon: Icon(
              Icons.inventory_2_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(12),
          OutlineTextfieldWidget(
            readOnly: true,
            initialValue:
                widget.data.periodoGracia.toString().toNullIfEmptyOrZero(),
            title: 'Periodo de gracia',
            icon: Icon(
              Icons.inventory_2_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(12),
          OutlineTextfieldWidget(
            readOnly: true,
            initialValue: widget.data.tipoCreditoNombre,
            title: 'Tipo de crédito',
            icon: Icon(
              Icons.inventory_2_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(12),
          OutlineTextfieldWidget(
            initialValue: widget.data.tipoProgramaNombre,
            title: 'Programa',
            readOnly: true,
            icon: Icon(
              Icons.inventory_2_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(12),
          OutlineTextfieldWidget(
            initialValue: observaciones,
            title: 'Observaciones',
            validator: (value) => ClassValidator.validateRequired(value),
            icon: Icon(
              Icons.inventory_2_outlined,
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
          const Gap(20),
        ],
      ),
    );
  }
}
