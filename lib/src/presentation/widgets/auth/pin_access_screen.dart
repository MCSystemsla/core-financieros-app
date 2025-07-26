// ignore_for_file: deprecated_member_use
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class PinAccessScreen extends StatelessWidget {
  const PinAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
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
          'Ingresa PIN de acceso',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
          textAlign: TextAlign.center,
        ),
        const Gap(12),
        Text(
          'Ingresa el PIN de acceso autorizado por la sucursal para continuar.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[700],
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _PinPutField extends StatefulWidget {
  @override
  State<_PinPutField> createState() => _PinPutFieldState();
}

class _PinPutFieldState extends State<_PinPutField> {
  String pinPassword = '885133';
  final pinController = TextEditingController();

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
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Pinput(
        obscureText: true,
        controller: pinController,
        inputFormatters: [
          LengthLimitingTextInputFormatter(6),
          FilteringTextInputFormatter.digitsOnly,
        ],
        length: 6,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration?.copyWith(
            border: Border.all(color: Theme.of(context).primaryColor, width: 2),
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
          if (pinController.text != pinPassword) {
            CustomAlertDialog(
              context: context,
              title: 'PIN Incorrecto vuelve a intentarlo.',
              onDone: () => context.pop(),
            ).showDialog(
              context,
              dialogType: DialogType.error,
            );
            pinController.clear();
            return;
          }
          pinController.clear();
          context.pop();
        },
        showCursor: true,
        autofocus: true,
      ),
    );
  }
}
