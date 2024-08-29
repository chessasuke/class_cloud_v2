import 'package:class_cloud/core/widgets/basic_text_field.dart';
import 'package:class_cloud/features/auth/sign_in_screen/cubit/sign_in_cubit.dart';
import 'package:class_cloud/features/auth/sign_in_screen/cubit/sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SignInCubit, SignInState, RecordValue>(
      selector: (state) {
        if (state is SignInInitial) {
          return state.emailRecord;
        }
        return (value: '', error: '');
      },
      builder: (context, emailRecord) {
        return BasicTextField(
          autofocus: false,
          hintText: 'Email',
          initialValue: emailRecord.value,
          onChanged: (val) {
            if (val.isNotEmpty) {
              context.read<SignInCubit>().updateEmail(val);
            }
          },
          errorText: emailRecord.error.isEmpty ? null : emailRecord.error,
        );
      },
    );
  }
}
