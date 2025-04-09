import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/domain/repository/auth/auth_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/auth_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/autoupdate/autoupdate_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/logo/logo_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/exceptions/vpn_no_found/vpn_no_found.dart';
import 'package:core_financiero_app/src/presentation/widgets/lang/change_lang_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/update_app_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/inputs/input_simple.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => BranchteamCubit(AuthRepositoryImpl())
            ..getBranchTeam(
              accessCode: '2wydJKIvNuO41hCZ7Y6',
              context: context,
            ),
        ),
        BlocProvider(create: (ctx) => AuthCubit(AuthRepositoryImpl())),
        BlocProvider(
          create: (ctx) => LogoCubit(AuthRepositoryImpl())..getLogo(),
        ),
      ],
      child: BlocConsumer<AutoupdateCubit, AutoupdateState>(
        listener: (context, state) {
          if (state is AutoupdateSuccess) {
            UpdateAppDialog(
              apkUrl: state.apkVersion,
              context: context,
              title: 'Debes actualiar la app para poder continuar',
              versionName: state.apkVersionName,
            ).showDialog(context);
          }
        },
        builder: (context, state) {
          return BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
            builder: (context, state) {
              if (!state.isCorrectNetwork) {
                return const VpnNoFound(routeIsVpnConnected: '/login');
              }

              return Scaffold(
                body: PopScope(
                  canPop: false,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ChangeLangWidget(
                            child: LoginScreen(),
                          ),
                          BlocBuilder<LogoCubit, LogoState>(
                            builder: (context, state) {
                              if (state is OnLogoSuccess) {
                                return Image(
                                    height: 200,
                                    image: NetworkImage(
                                      state.imgUrl,
                                    ));
                              }
                              if (state is OnLogoLoading) {
                                return const CircularProgressIndicator();
                              }
                              if (state is OnLogoError) {
                                return const Text('error');
                              }
                              return const SizedBox();
                            },
                          ),
                          // const Gap(10),
                          const Expanded(
                            flex: 5,
                            child: LoginFormWidget(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            InputSimple(
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
            const Gap(30),
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
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      context.read<AuthCubit>().login(
                            userName: username!.toUpperCase().trim(),
                            password: password!.trim(),
                            dbName: branchTeam!,
                          );
                    }
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
