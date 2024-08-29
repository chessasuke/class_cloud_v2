
import 'package:class_cloud/core/widgets/basic_text_field.dart';
import 'package:class_cloud/features/auth/sign_in_screen/cubit/sign_in_cubit.dart';
import 'package:class_cloud/features/auth/sign_in_screen/cubit/sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({super.key});

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool isPasswordHidden = true;

  void onPressed() {
    setState(() {
      isPasswordHidden = !isPasswordHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SignInCubit, SignInState, RecordValue>(
      selector: (state) {
        if (state is SignInInitial) {
          return state.passwordRecord;
        }
        return (value: '', error: '');
      },
      builder: (context, passwordRecord) {
        return BasicTextField(
          autofocus: false,
          hintText: 'Password',
          initialValue: passwordRecord.value,
          obscureText: isPasswordHidden,
          onChanged: (val) {
            if (val.isNotEmpty) {
              context.read<SignInCubit>().updatePassword(val);
            }
          },
          errorText:
              passwordRecord.error.isEmpty ? null : passwordRecord.error,
          suffixIcon: _ShowPasswordIcon(
            onPressed: onPressed,
            isPasswordVisible: isPasswordHidden,
          ),
        );
      },
    );
  }
}

class _ShowPasswordIcon extends StatelessWidget {
  const _ShowPasswordIcon({
    required this.onPressed,
    required this.isPasswordVisible,
  });

  final VoidCallback onPressed;
  final bool isPasswordVisible;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        isPasswordVisible
            ? Icons.remove_red_eye
            : Icons.remove_red_eye_outlined,
      ),
    );
  }
}
