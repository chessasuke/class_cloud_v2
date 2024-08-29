import 'package:equatable/equatable.dart';

typedef RecordValue = ({String value, String error});

sealed class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {
  const SignInInitial({
    this.emailRecord = (value: 'craptestingacc508@gmail.com', error: ''),
    this.passwordRecord = (value: 'Test123!', error: ''),
  });

  final RecordValue emailRecord;
  final RecordValue passwordRecord;

  bool get isValid =>
      emailRecord.error.isEmpty &&
      emailRecord.value.isNotEmpty &&
      passwordRecord.error.isEmpty &&
      passwordRecord.value.isNotEmpty;

  SignInInitial copyWith({
    RecordValue? emailRecord,
    RecordValue? passwordRecord,
  }) =>
      SignInInitial(
        emailRecord: emailRecord ?? this.emailRecord,
        passwordRecord: passwordRecord ?? this.passwordRecord,
      );

  @override
  List<Object> get props => [emailRecord, passwordRecord];
}

class SignInLoading extends SignInState {
  const SignInLoading();
}

class SignInSuccess extends SignInState {
  const SignInSuccess();
}

class SignInError extends SignInState {
  const SignInError({
    required this.message,
  });

  final String message;

  @override
  List<Object> get props => [message];
}
