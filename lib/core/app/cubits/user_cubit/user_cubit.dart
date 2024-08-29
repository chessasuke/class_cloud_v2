import 'package:class_cloud/core/app/cubits/user_cubit/user_state.dart';
import 'package:class_cloud/core/data/auth/repository/auth_repository.dart';
import 'package:class_cloud/core/data/user/repository/user_repository.dart';
import 'package:class_cloud/core/services/logger_service.dart/logger_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({
    required this.authRepository,
    required this.userRepository,
  }) : super(const UserUnauthenticated());

  final AuthRepository authRepository;
  final UserRepository userRepository;

  void listenUserChanges() {
    userRepository.userStream.listen((user) {
      if (user == null) {
        emit(const UserUnauthenticated());
      } else {
        emit(UserAuthenticated(user: user));
      }
    });
  }

  Future<void> login({required String email, required String password}) async {
    try {
      await authRepository.signInWithCredentials(
        email: email,
        password: password,
      );
    } catch (e) {
      Logger(LoggerConstants.auth)
          .log(Level.SHOUT, 'Error signing in user: $e');
    }
  }

  Future<void> logout() async {
    try {
      await authRepository.signOut();
    } catch (e) {
      Logger(LoggerConstants.auth).log(Level.SHOUT, 'Error signing out user');
    }
  }
}
