// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/kiva_history_request.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../../../bloc/codigo_verificacion/codigo_verificacion_cubit.dart';

class CustomPinputWidget extends StatelessWidget {
  const CustomPinputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => CodigoVerificacionCubit(
        ResponsesRepositoryImpl(),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FB),
        appBar: AppBar(
          title: const Text('Código de verificación'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const _TitlePinputField(),
                  const Gap(32),
                  _PinPutField(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TitlePinputField extends StatelessWidget {
  const _TitlePinputField();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.verified_user,
            size: 64, color: Theme.of(context).primaryColor),
        const Gap(24),
        Text(
          'Verifica tu codigo de verificacion',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
          textAlign: TextAlign.center,
        ),
        const Gap(12),
        Text(
          'Ingresa el código de verificación autorizado por la sucursal para continuar.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[700],
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _PinPutField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: const TextStyle(fontSize: 20, color: Colors.black),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
    );
    return BlocConsumer<CodigoVerificacionCubit, CodigoVerificacionState>(
      listener: (context, state) {
        if (state is OnCodigoVerificacionInitialError) {
          CustomAlertDialog(
            context: context,
            title: state.errorMsg,
            onDone: () => context.pop(),
          ).showDialog(context, dialogType: DialogType.error);
        }
        if (state is OnCodigoVerificacionInitialSuccess) {
          CustomAlertDialog(
            context: context,
            onDone: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return const KivaHistoryRequestScreen();
                },
              ));
            },
            title: 'Codigo de Verificacion Correcto',
          ).showDialog(context, dialogType: DialogType.success);
        }
      },
      builder: (context, state) {
        return Pinput(
          inputFormatters: [
            LengthLimitingTextInputFormatter(6),
            FilteringTextInputFormatter.digitsOnly,
          ],
          enabled: state is! OnCodigoVerificacionInitialLoading,
          length: 6,
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: defaultPinTheme.copyWith(
            decoration: defaultPinTheme.decoration?.copyWith(
              border:
                  Border.all(color: Theme.of(context).primaryColor, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          ),
          onCompleted: (pin) {
            context
                .read<CodigoVerificacionCubit>()
                .sendCodigoVerificacion(codigo: pin);
          },
          showCursor: true,
          autofocus: true,
        );
      },
    );
  }
}
