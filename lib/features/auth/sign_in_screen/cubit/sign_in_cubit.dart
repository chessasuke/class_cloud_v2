
import 'package:class_cloud/core/data/auth/repository/auth_repository.dart';
import 'package:class_cloud/features/auth/sign_in_screen/cubit/sign_in_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({
    required this.authRepository,
  }) : super(const SignInInitial());

  final AuthRepository authRepository;

  void reset() {
    emit(const SignInInitial());
  }

  void updateEmail(String email) {
    final currentState = state;
    if (currentState is! SignInInitial) return;
    emit(currentState.copyWith(emailRecord: (value: email, error: '')));
  }

  void updatePassword(String password) {
    final currentState = state;
    if (currentState is! SignInInitial) return;
    emit(currentState.copyWith(passwordRecord: (value: password, error: '')));
  }
}
