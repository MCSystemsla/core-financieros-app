import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/snackbar/custom_snackbar.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/domain/repository/auth/auth_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/change_password/change_password_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/auth/change_password/password_field_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/auth/change_password/password_requirements_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ChangePasswordScreen extends StatelessWidget {
  final String username;
  final String database;
  final String currentPassword;
  const ChangePasswordScreen({
    super.key,
    required this.username,
    required this.database,
    required this.currentPassword,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChangePasswordCubit(AuthRepositoryImpl()),
      child: Scaffold(
        backgroundColor: RedesignColors.background,
        body: SafeArea(
          child: _ChangePasswordView(
            username: username,
            database: database,
            currentPassword: currentPassword,
          ),
        ),
      ),
    );
  }
}

class _ChangePasswordView extends StatefulWidget {
  final String username;
  final String database;
  final String currentPassword;
  const _ChangePasswordView({
    required this.username,
    required this.database,
    required this.currentPassword,
  });

  @override
  State<_ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<_ChangePasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    context.read<ChangePasswordCubit>().renovarPasswordVencida(
          userName: widget.username,
          dbName: widget.database,
          currentPassword: widget.currentPassword,
          newPassword: _newPasswordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          ScreenHeaderWidget(
            title: 'Cambia tu contraseña',
            subtitle: 'Tu contraseña expiró. Crea una nueva para continuar.',
            onBack: () => Navigator.pop(context),
          ),
          const Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _StatusBanner(username: widget.username),
          ),
          const Gap(14),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: RedesignColors.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: RedesignColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PasswordFieldWidget(
                  label: 'Contraseña nueva',
                  controller: _newPasswordController,
                  validator: ClassValidator.validateNewPassword,
                ),
                const Gap(10),
                ValueListenableBuilder(
                  valueListenable: _newPasswordController,
                  builder: (context, value, _) {
                    return PasswordRequirementsWidget(password: value.text);
                  },
                ),
                const Gap(16),
                PasswordFieldWidget(
                  label: 'Confirmar contraseña nueva',
                  controller: _confirmPasswordController,
                  validator: (value) => ClassValidator.validateConfirmPassword(
                    value,
                    _newPasswordController.text,
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ],
            ),
          ),
          const Gap(24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
              listener: (context, state) {
                if (state.status == ChangePasswordStatus.success) {
                  Navigator.pop(context, true);
                }
                if (state.status == ChangePasswordStatus.error) {
                  showV2CustomSnackbar(
                    context,
                    title: state.errorMsg,
                    type: SnackbarType.error,
                  );
                }
              },
              builder: (context, state) {
                final isLoading = state.status == ChangePasswordStatus.loading;
                return SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _onSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: RedesignColors.ink,
                      foregroundColor: RedesignColors.surface,
                      disabledBackgroundColor: RedesignColors.ink,
                      disabledForegroundColor: RedesignColors.surface,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.4,
                              color: RedesignColors.surface,
                            ),
                          )
                        : const Text(
                            'Guardar contraseña',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Aviso compacto con el usuario al que se le cambia la contraseña.
class _StatusBanner extends StatelessWidget {
  final String username;
  const _StatusBanner({required this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: RedesignColors.redTint,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              color: RedesignColors.surface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.lock_clock_outlined,
              size: 19,
              color: RedesignColors.red,
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Cambio obligatorio',
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: RedesignColors.red,
                  ),
                ),
                const Gap(2),
                Text(
                  username,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: RedesignColors.inkMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
