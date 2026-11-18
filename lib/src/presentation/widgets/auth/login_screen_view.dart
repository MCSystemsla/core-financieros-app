import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/snackbar/custom_snackbar.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/domain/repository/auth/auth_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/auth_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/autoupdate/autoupdate_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/auth/change_password/change_password_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/auth/login/login_field_widgets.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/update_app_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/background/custom_background.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/debug/debug_panel_trigger.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/search_branch_sheet_delegate.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/connection_pill_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/version/version_control_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/logo/logo_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginScreenView extends StatefulWidget {
  const LoginScreenView({super.key});

  @override
  State<LoginScreenView> createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends State<LoginScreenView>
    with WidgetsBindingObserver {
  final _formWidgetKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  Widget _buildLogo(String logo, {required double width}) {
    return Center(
      child: DebugPanelTrigger(
        child: Image(width: width, image: AssetImage(logo)),
      ),
    );
  }

  Widget _buildPortrait(BoxConstraints constraints, String logo) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: constraints.maxHeight - 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [ConnectionPillWidget()],
                ),
                const Gap(22),
                _buildLogo(logo, width: 228),
                const Gap(26),
                const _LoginGreeting(),
                const Gap(20),
                LoginFormWidget(key: _formWidgetKey),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 24),
              child: VersionControlWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLandscape(String logo) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Panel izquierdo: marca, saludo y versión.
          Expanded(
            flex: 5,
            child: LayoutBuilder(
              builder: (context, side) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: side.maxHeight - 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildLogo(logo, width: 180),
                            const Gap(20),
                            const _LoginGreeting(),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: VersionControlWidget(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Gap(24),
          // Panel derecho: conexión y formulario.
          Expanded(
            flex: 6,
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.only(top: 12, bottom: 20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [ConnectionPillWidget()],
                      ),
                      const Gap(12),
                      LoginFormWidget(key: _formWidgetKey),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final isCurrent = ModalRoute.of(context)?.isCurrent ?? false;
    if (!isCurrent) return;

    if (state == AppLifecycleState.resumed) {
      context.read<InternetConnectionCubit>().getInternetStatusConnection();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    final flavor = global<FlavorCubit>().state.flavor;
    const isProdMode = bool.fromEnvironment('isProdMode');
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AutoupdateCubit(flavor)..verificarActualizacion(),
        ),
        BlocProvider(
          create: (_) => BranchteamCubit(AuthRepositoryImpl())..getBranchTeam(),
        ),
      ],
      child: BlocListener<AutoupdateCubit, AutoupdateState>(
        listener: (context, state) {
          if (state is AutoupdateSuccess && isProdMode) {
            UpdateAppDialog(
              flavor: flavor,
              apkUrl: state.apkVersion,
              context: context,
              title: 'Para continuar, es necesario actualizar la aplicación.',
              versionName: state.apkVersionName,
            ).showDialog(context, dismissOnBackKeyPress: false);
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: PopScope(
            canPop: false,
            child: FadeIn(
              child: CustomBackground(
                child: Stack(
                  children: [
                    const Positioned.fill(
                      child: LoginBackgroundDecoration(),
                    ),
                    SafeArea(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final logo = flavor.toLogoExtension;
                          final isLandscape =
                              constraints.maxWidth > constraints.maxHeight;
                          return isLandscape
                              ? _buildLandscape(logo)
                              : _buildPortrait(constraints, logo);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginGreeting extends StatelessWidget {
  const _LoginGreeting();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'auth.welcome_title'.tr(),
            style: const TextStyle(
              fontSize: 28,
              height: 34 / 28,
              fontWeight: FontWeight.w800,
              letterSpacing: -.4,
              color: RedesignColors.ink,
            ),
          ),
          const Gap(6),
          Text(
            'auth.welcome_subtitle'.tr(),
            style: const TextStyle(
              fontSize: 15,
              height: 22 / 15,
              color: Color(0xff1D3B36),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? branchTeam;
  bool isPasswordVisible = false;
  String? turnstileToken;
  final localStorage = LocalStorage();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _openChangePassword() async {
    final changed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => ChangePasswordScreen(
          username: _usernameController.text.trim(),
          database: branchTeam ?? '',
          currentPassword: _passwordController.text.trim(),
        ),
      ),
    );
    if (changed != true || !mounted) return;
    _passwordController.clear();
    showV2CustomSnackbar(
      context,
      title: 'Contraseña actualizada',
      message: 'Inicia sesión con tu nueva contraseña.',
      type: SnackbarType.success,
    );
  }

  void _enterOfflineMode() {
    context.read<InternetConnectionCubit>().makeToOfflineMode();
    context.pushReplacement('/');
    showV2CustomSnackbar(
      context,
      title: 'Modo offline Activado',
      type: SnackbarType.success,
      message:
          'Has entrado al modo offline, puedes gestionar tus datos sin conexión a internet.',
    );
  }

  void _login() {
    FocusScope.of(context).unfocus();

    final isValid = _formKey.currentState?.validate() ?? false;
    final dbName = branchTeam;
    if (!isValid || dbName == null) return;

    context.read<AuthCubit>().login(
          userName: _usernameController.text.trim(),
          password: _passwordController.text.trim(),
          dbName: dbName,
        );
  }

  @override
  Widget build(BuildContext context) {
    final hasSavedSession =
        localStorage.currentUserName.isNotEmpty && localStorage.jwt.isNotEmpty;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      decoration: BoxDecoration(
        color: RedesignColors.surface,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: RedesignColors.ink.withValues(alpha: .22),
            blurRadius: 48,
            spreadRadius: -12,
            offset: const Offset(0, 24),
          ),
          BoxShadow(
            color: RedesignColors.ink.withValues(alpha: .06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoginTextField(
              label: 'auth.user'.tr(),
              hintText: 'Ej.: BGODOY',
              icon: Icons.person_outline_rounded,
              controller: _usernameController,
              inputFormatters: [UpperCaseTextFormatter()],
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.characters,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'auth.errors.username'.tr();
                }
                return null;
              },
            ),
            const Gap(16),
            LoginTextField(
              label: 'auth.password'.tr(),
              hintText: 'auth.password_hint'.tr(),
              icon: Icons.lock_outline_rounded,
              controller: _passwordController,
              obscureText: !isPasswordVisible,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              suffixIcon: IconButton(
                tooltip: isPasswordVisible
                    ? 'Ocultar contraseña'
                    : 'Mostrar contraseña',
                icon: Icon(
                  isPasswordVisible
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 20,
                  color: RedesignColors.inkMuted,
                ),
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'auth.errors.password'.tr();
                }
                return null;
              },
            ),
            const Gap(16),
            BlocBuilder<BranchteamCubit, BranchteamState>(
              builder: (context, state) {
                return SearchBranchSheetDelegate(
                  title: 'auth.branch'.tr(),
                  isRequired: true,
                  onChanged: (item) {
                    if (item == null) return;
                    branchTeam = item.nombreDb;
                    setState(() {});
                  },
                  hintText: state.status == Status.error
                      ? state.errorMsg
                      : 'auth.select_branch'.tr(),
                  enabled: state.status == Status.done,
                  isLoading: state.status == Status.inProgress,
                  items: state.branchTeams,
                  validator: (value) {
                    if (value == null) return 'auth.errors.branchTeam'.tr();

                    return null;
                  },
                );
              },
            ),
            const Gap(22),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) async {
                final status = state.status;
                if (status == AuthStatus.mustChangePassword) {
                  showV2CustomSnackbar(
                    context,
                    title: state.errorMsg,
                    type: SnackbarType.warning,
                  );
                  _openChangePassword();
                  return;
                }
                if (status == AuthStatus.unauthenticated) {
                  showV2CustomSnackbar(
                    context,
                    title: state.errorMsg,
                    type: SnackbarType.warning,
                  );
                }
                if (status == AuthStatus.error) {
                  showV2CustomSnackbar(
                    context,
                    title: state.errorMsg,
                    type: SnackbarType.error,
                  );
                }
                if (state.status == AuthStatus.authenticated) {
                  if (!context.mounted) return;
                  context.pushReplacement('/');
                  showV2CustomSnackbar(
                    context,
                    title: 'auth.logged'.tr(),
                    type: SnackbarType.success,
                  );
                }
              },
              builder: (context, state) {
                return LoginSubmitButton(
                  text: 'button.login'.tr(),
                  loadingText: 'auth.signing_in'.tr(),
                  isLoading: state.status == AuthStatus.authenticating,
                  onPressed: _login,
                );
              },
            ),
            if (hasSavedSession) ...[
              const Gap(18),
              LoginOfflineTile(
                dividerText: 'auth.offline_divider'.tr(),
                title: 'auth.offline_title'.tr(),
                subtitle: 'auth.offline_subtitle'.tr(
                  args: {'user': localStorage.currentUserName},
                ),
                userName: localStorage.currentUserName,
                onTap: _enterOfflineMode,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
