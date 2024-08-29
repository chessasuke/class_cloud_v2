
import 'package:class_cloud/core/app/cubits/user_cubit/user_cubit.dart';
import 'package:class_cloud/core/widgets/cta_button/cta_button.dart';
import 'package:class_cloud/features/auth/sign_in_screen/cubit/sign_in_cubit.dart';
import 'package:class_cloud/features/auth/sign_in_screen/cubit/sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInCta extends StatelessWidget {
  const SignInCta({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        if (state is! SignInInitial) return const SizedBox();
        return CtaButton(
          text: 'Sign In',
          onPressed: () async {
            if (state.emailRecord.value.isNotEmpty &&
                state.passwordRecord.value.isNotEmpty) {
              await context.read<UserCubit>().login(
                    email: state.emailRecord.value,
                    password: state.passwordRecord.value,
                  );
            }
          },
        );
      },
    );
  }
}
