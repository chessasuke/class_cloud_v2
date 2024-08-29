import 'package:class_cloud/core/app/cubits/user_cubit/user_cubit.dart';
import 'package:class_cloud/core/app/cubits/user_cubit/user_state.dart';
import 'package:class_cloud/core/go_router/go_router_keys.dart';
import 'package:class_cloud/features/auth/sign_in_screen/widgets/email_input.dart';
import 'package:class_cloud/features/auth/sign_in_screen/widgets/password_input.dart';
import 'package:class_cloud/features/auth/sign_in_screen/widgets/sign_in_cta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserAuthenticated) {
            context.goNamed(GoRouterNames.home);
          }
        },
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EmailInput(),
              SizedBox(height: 8),
              PasswordInput(),
              SizedBox(height: 8),
              SignInCta(),
              SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}
