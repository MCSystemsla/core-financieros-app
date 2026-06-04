import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';

import '../../../../../bloc/solicitudes/hn/cubit/informacion_peps_hn/informacion_peps_hn_cubit.dart';

class PepsInformacionNegocioWidget extends StatelessWidget {
  const PepsInformacionNegocioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<InformacionPepsHnCubit>();
    return BlocBuilder<InformacionPepsHnCubit, InformacionPepsHnState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Empresa/Negocio',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const Gap(5),
              OutlineTextfieldWidget(
                title: 'Porcentaje Accionario que posee en el negocio?',
                icon: const Icon(Icons.account_balance_outlined),
                textInputType: TextInputType.number,
                textCapitalization: TextCapitalization.none,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
                validator: (value) => ClassValidator.validateRequired(value),
                onChange: (value) {
                  final newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      negocioPorcentajeAccion: double.tryParse(newValue) ?? 0,
                    ),
                  );
                },
              ),
              const Gap(5),
              OutlineTextfieldWidget(
                title: 'Cuantas sucursales tiene el negocio?',
                icon: const Icon(Icons.account_balance_outlined),
                textInputType: TextInputType.number,
                textCapitalization: TextCapitalization.none,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
                validator: (value) => ClassValidator.validateRequired(value),
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      negocioCantidadSucursal: int.tryParse(value) ?? 0,
                    ),
                  );
                },
              ),
              const Gap(5),
              OutlineTextfieldWidget(
                title: 'Ciudad (es) de la (s) Sucursal (es)',
                icon: const Icon(Icons.location_on),
                textCapitalization: TextCapitalization.none,
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                validator: (value) => ClassValidator.validateRequired(value),
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      negocioCiudadSucursales: value,
                    ),
                  );
                },
              ),
              const Gap(5),
              OutlineTextfieldWidget(
                title: 'Proveedores',
                icon: const Icon(Icons.people),
                textCapitalization: TextCapitalization.none,
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                validator: (value) => ClassValidator.validateRequired(value),
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      negocioProveedores: value,
                    ),
                  );
                },
              ),
              const Gap(10),
              CustomSwitch(
                title: '¿La empresa es proveedor del estado?',
                subtitle: 'Indique si la empresa es proveedor del estado',
                value: state.negocioEsProveedorEstado,
                onChanged: (v) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      negocioEsProveedorEstado: v,
                    ),
                  );
                },
              ),
              if (state.negocioEsProveedorEstado) ...[
                const Gap(5),
                OutlineTextfieldWidget(
                  title:
                      'Nombre de la institución del estado a quien le provee la empresa',
                  icon: const Icon(Icons.account_balance_outlined),
                  textCapitalization: TextCapitalization.none,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  validator: (value) => ClassValidator.validateRequired(value),
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        negocioAdquirienteInstitucion: value,
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
