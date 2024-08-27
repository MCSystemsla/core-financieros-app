import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/domain/repository/auth/auth_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/auth_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/lang/change_lang_widget.dart';
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
            ),
        ),
        BlocProvider(create: (ctx) => AuthCubit(AuthRepositoryImpl())),
      ],
      child: const Scaffold(
        backgroundColor: Color(0xffF1F1F1),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ChangeLangWidget(route: '/login'),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Image(
                      image: AssetImage(ImageAsset.logo),
                    ),
                  ),
                ),
                // const Gap(10),
                Expanded(
                  flex: 5,
                  child: LoginFormWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputSimple(
          title: 'auth.user'.tr(),
          activeColor: true,
          hintText: 'Ejem: John Doe',
          enabled: true,
          onChanged: (p0) {},
          textFieldSettings: const TextFieldSettings(
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        // const Gap(25),
        InputSimple(
          title: 'auth.password'.tr(),
          activeColor: true,
          hintText: '****',
          isPasswordField: true,
          enabled: true,
          onChanged: (p0) {},
        ),
        const Gap(25),
        BlocBuilder<BranchteamCubit, BranchteamState>(
          builder: (context, state) {
            return JLuxDropdown(
              isContainIcon: true,
              isLoading: state.status == Status.inProgress,
              title: 'auth.branch'.tr(),
              items: state.branchTeams,
              onChanged: (item) {},
              toStringItem: (item) {
                return item.nombre;
              },
              hintText: 'auth.select_branch'.tr(),
            );
          },
        ),
        const Gap(30),
        BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
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
              context.pushReplacement('/');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  showCloseIcon: true,
                  content: Text('Usuario Loguado exitosamente'),
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
                context.read<AuthCubit>().login(
                      userName: 'ABRIZUELA',
                      password: 'Micredito1.',
                      dbName: 'MICREDITO_CM',
                    );
              },
            );
          },
        )
      ],
    );
  }
}
