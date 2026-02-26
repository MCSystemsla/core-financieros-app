import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_solicitud_response.dart';
import 'package:core_financiero_app/src/presentation/bloc/comite/comite_calculo_datos/comite_calculo_datos_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';

class ComiteSegurosDesembolsoForm extends StatelessWidget {
  final ComiteSolicitudData data;
  const ComiteSegurosDesembolsoForm({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Container(
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
                    'Seguros en desembolso en Lempiras',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const Gap(12),
                OutlineTextfieldWidget(
                  readOnly: true,
                  hintText:
                      state.data?.data.seguros.saldoDeudor.toCurrencyString(),
                  title: 'Tasa Saldo deudor:',
                  icon: Icon(
                    Icons.percent_outlined,
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
                  hintText:
                      state.data?.data.seguros.agricola.toCurrencyString(),
                  title: 'Monto seguro agrícola:',
                  icon: Icon(
                    Icons.agriculture_outlined,
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
                  hintText: state.data?.data.seguros.vida.toCurrencyString(),
                  title: 'Monto seguro de vida:',
                  icon: Icon(
                    Icons.percent_outlined,
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
                  hintText: state.data?.data.seguros.montoTotalSeguros
                      .toCurrencyString(),
                  title: 'Total seguros financiados:',
                  icon: Icon(
                    Icons.security,
                    color: AppColors.getPrimaryColor(),
                  ),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {},
                ),
                const Gap(12),
              ],
            );
          },
        ),
      ),
    );
  }
}
