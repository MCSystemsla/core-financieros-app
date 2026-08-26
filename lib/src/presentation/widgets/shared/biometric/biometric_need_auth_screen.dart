import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/biometric/biometric_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class BiometricNeedAuthScreen extends StatelessWidget {
  const BiometricNeedAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BiometricCubit, BiometricState>(
      bloc: global<BiometricCubit>(),
      listener: (context, state) {
        if (state.isAuthenticated && Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return PopScope(
          canPop: false,
          child: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.fingerprint,
                    size: 100,
                    color: AppColors.getPrimaryColor(),
                  ),
                  const Gap(20),
                  const Text(
                    'Por favor, autentíquese para continuar',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(10),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 22),
                    padding: const EdgeInsets.all(18),
                    child: CustomElevatedButton(
                      onPressed: () async {
                        global<BiometricCubit>().authenticate(context);
                      },
                      text: 'Autenticar',
                      color: AppColors.getSecondaryColor(),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
