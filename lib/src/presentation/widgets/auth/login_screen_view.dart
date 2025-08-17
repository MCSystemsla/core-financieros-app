import 'package:animate_do/animate_do.dart';
import 'package:cloudflare_turnstile/cloudflare_turnstile.dart';
import 'package:core_financiero_app/src/config/helpers/snackbar/custom_snackbar.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/domain/repository/auth/auth_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/auth_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/autoupdate/autoupdate_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/update_app_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/background/custom_background.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/inputs/input_simple.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/version/version_control_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (ctx) =>
                AutoupdateCubit()..verificarActualizacion(context)),
        BlocProvider(
          create: (ctx) => BranchteamCubit(AuthRepositoryImpl())
            ..getBranchTeam(
              accessCode: '2wydJKIvNuO41hCZ7Y6',
              context: context,
            ),
        ),
      ],
      child: BlocConsumer<AutoupdateCubit, AutoupdateState>(
        listener: (context, state) {
          if (state is AutoupdateSuccess) {
            UpdateAppDialog(
              apkUrl: state.apkVersion,
              context: context,
              title: 'Para continuar, es necesario actualizar la aplicación.',
              versionName: state.apkVersionName,
            ).showDialog(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: PopScope(
              canPop: false,
              child: FadeIn(
                child: const CustomBackground(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SafeArea(
                            child: Image(
                              height: 180,
                              image: AssetImage(ImageAsset.logoNi),
                            ),
                          ),
                          Gap(5),
                          LoginFormWidget(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
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
  String? username;
  String? password;
  String? branchTeam;
  bool isPasswordVisible = false;
  String? turnstileToken;
  bool isOffline = false;
  final localStorage = LocalStorage();

  final _formKey = GlobalKey<FormState>();

  final TurnstileOptions options = TurnstileOptions(
    size: TurnstileSize.flexible,
    theme: TurnstileTheme.light,
    borderRadius: BorderRadius.circular(10),
    language: 'es',
    retryAutomatically: false,
    refreshTimeout: TurnstileRefreshTimeout.manual,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              const Gap(20),
              InputSimple(
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                icon: const Icon(
                  Icons.person_2,
                  size: 20,
                ),
                title: 'auth.user'.tr(),
                activeColor: true,
                hintText: 'Ejem: DGALEAS',
                enabled: true,
                onChanged: (value) {
                  username = value;
                  setState(() {});
                },
                textFieldSettings: TextFieldSettings(
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.characters,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'auth.errors.username'.tr();
                    }
                    return null;
                  },
                ),
              ),
              const Gap(25),
              InputSimple(
                title: 'auth.password'.tr(),
                icon: const Icon(
                  Icons.security_outlined,
                  size: 20,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
                activeColor: true,
                hintText: '****',
                isPasswordField: !isPasswordVisible,
                enabled: true,
                textFieldSettings: TextFieldSettings(
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'auth.errors.password'.tr();
                    }
                    return null;
                  },
                ),
                onChanged: (value) {
                  password = value;
                  setState(() {});
                },
              ),
              const Gap(25),
              BlocBuilder<BranchteamCubit, BranchteamState>(
                builder: (context, state) {
                  return JLuxDropdown(
                    isContainIcon: true,
                    isLoading: state.status == Status.inProgress,
                    validator: (value) {
                      if (value == null) return 'auth.errors.branchTeam'.tr();

                      return null;
                    },
                    title: 'auth.branch'.tr(),
                    items: state.branchTeams,
                    onChanged: (item) {
                      if (item == null) return;
                      branchTeam = item.nombreDb;
                      setState(() {});
                    },
                    toStringItem: (item) {
                      return item.nombre;
                    },
                    hintText: 'auth.select_branch'.tr(),
                  );
                },
              ),
              const VersionControlWidget(),
              const Gap(10),
              CloudflareTurnstile(
                options: options,
                siteKey: const String.fromEnvironment('CFAccessSiteKey'),
                baseUrl: 'http://localhost/',
                onTokenReceived: (token) {
                  turnstileToken = token;
                  setState(() {});
                },
              ),
              if (localStorage.currentUserName.isNotEmpty &&
                  localStorage.jwt.isNotEmpty)
                SwitchListTile(
                  title: const Text('Entrar al modo offline:'),
                  subtitle: Text(localStorage.currentUserName),
                  value: isOffline,
                  onChanged: (e) async {
                    if (e == isOffline) return;
                    setState(() => isOffline = e);
                    await Future.delayed(const Duration(milliseconds: 500));
                    if (!context.mounted) return;
                    if (e) {
                      context
                          .read<InternetConnectionCubit>()
                          .makeToOfflineMode();
                      ScaffoldMessenger.of(context).showSnackBar(
                        customSnackbar(
                          title: 'Modo offline Activado',
                          icon: const Icon(
                            Icons.offline_bolt,
                            color: Colors.white,
                          ),
                        ),
                      );
                      context.pushReplacement('/');
                    }
                  },
                ),
              const Gap(14),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) async {
                  final status = state.status;
                  if (status == Status.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        showCloseIcon: true,
                        content: Text(state.errorMsg),
                      ),
                    );
                  }
                  if (state.status == Status.done) {
                    if (!context.mounted) return;
                    context.pushReplacement('/');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        showCloseIcon: true,
                        content: Text('auth.logged'.tr()),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return CustomElevatedButton(
                    enabled: state.status != Status.inProgress,
                    text: 'button.login'.tr(),
                    color: Colors.black,
                    onPressed: () async {
                      FocusScope.of(context).unfocus();

                      if (turnstileToken == null) {
                        CustomAlertDialog(
                          context: context,
                          title: 'Por favor verifica que eres un humano',
                          onDone: () => context.pop(),
                        ).showDialog(context);
                        return;
                      }
                      if (_formKey.currentState?.validate() ?? false) {
                        context.read<AuthCubit>().login(
                              userName: username!.trim(),
                              password: password!.trim(),
                              dbName: branchTeam!,
                            );
                      }
                    },
                  );
                },
              ),
              const Gap(5),
            ],
          ),
        ),
      ),
    );
  }
}
