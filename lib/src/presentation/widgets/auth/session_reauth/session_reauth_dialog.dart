import 'package:core_financiero_app/src/config/helpers/snackbar/custom_snackbar.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/domain/repository/auth/auth_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/session_reauth/session_reauth_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/inputs/input_simple.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/info_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SessionReauthDialog extends StatelessWidget {
  const SessionReauthDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SessionReauthCubit(AuthRepositoryImpl()),
      child: const PopScope(
        canPop: false,
        child: Dialog(
          backgroundColor: RedesignColors.surface,
          insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: _SessionReauthForm(),
        ),
      ),
    );
  }
}

class _SessionReauthForm extends StatefulWidget {
  const _SessionReauthForm();

  @override
  State<_SessionReauthForm> createState() => _SessionReauthFormState();
}

class _SessionReauthFormState extends State<_SessionReauthForm> {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    context
        .read<SessionReauthCubit>()
        .reauthenticate(password: _passwordController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final storage = LocalStorage();
    return BlocConsumer<SessionReauthCubit, SessionReauthState>(
      listener: (context, state) {
        if (state.status == SessionReauthStatus.success) {
          showV2CustomSnackbar(
            context,
            title: 'Sesión renovada',
            message: 'Puedes continuar donde estabas.',
            type: SnackbarType.success,
          );
          Navigator.of(context).pop(true);
        }
      },
      builder: (context, state) {
        final isLoading = state.status == SessionReauthStatus.loading;
        final passwordExpired =
            state.status == SessionReauthStatus.passwordExpired;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tu sesión expiró',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: RedesignColors.ink,
                  ),
                ),
                const Gap(6),
                const Text(
                  'Ingresa tu contraseña para continuar donde estabas.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.35,
                    color: RedesignColors.inkMuted,
                  ),
                ),
                const Gap(16),
                InfoRowWidget(
                  icon: Icons.person_2_outlined,
                  color: RedesignColors.indigo,
                  background: RedesignColors.indigoTint,
                  label: 'Usuario',
                  value: storage.currentUserName,
                ),
                if (!passwordExpired) ...[
                  const Gap(16),
                  InputSimple(
                    title: 'Contraseña',
                    icon: const Icon(Icons.security_outlined, size: 20),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: RedesignColors.inkMuted,
                      ),
                      onPressed: () => setState(
                        () => isPasswordVisible = !isPasswordVisible,
                      ),
                    ),
                    activeColor: true,
                    hintText: '****',
                    controller: _passwordController,
                    isPasswordField: !isPasswordVisible,
                    enabled: !isLoading,
                    textFieldSettings: TextFieldSettings(
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingresa tu contraseña';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
                if (state.errorMsg.isNotEmpty) ...[
                  const Gap(12),
                  _ErrorMessage(
                    message: passwordExpired
                        ? '${state.errorMsg}\nInicia sesión desde la pantalla de login para cambiarla.'
                        : state.errorMsg,
                  ),
                ],
                const Gap(20),
                if (!passwordExpired)
                  CustomElevatedButton(
                    enabled: !isLoading,
                    text: isLoading ? 'Verificando...' : 'Continuar',
                    color: RedesignColors.ink,
                    onPressed: _submit,
                  ),
                const Gap(8),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: isLoading
                        ? null
                        : () => Navigator.of(context).pop(false),
                    child: Text(
                      passwordExpired
                          ? 'Ir al login'
                          : 'No quiero autenticarme',
                      style: const TextStyle(
                        color: RedesignColors.inkMuted,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  final String message;
  const _ErrorMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: RedesignColors.redTint,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        message,
        style: const TextStyle(
          fontSize: 13,
          height: 1.35,
          color: RedesignColors.red,
        ),
      ),
    );
  }
}
