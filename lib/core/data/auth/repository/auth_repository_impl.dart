part of 'auth_repository.dart';

final authRepository = Provider<AuthRepositoryImpl>(
  (ref) => AuthRepositoryImpl(
    AuthRemoteDataSource(ref.watch(authClient)),
  ),
);

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this.dataSource);

  final AuthRemoteDataSource dataSource;

  @override
  Stream<User?> get authChanges => dataSource.authChanges;

  @override
  Future<void> signInWithCredentials({
    required String email,
    required String password,
  }) async {
    await dataSource.signInWithCredentials(email: email, password: password);
  }

  @override
  Future<void> signOut() async {
    await dataSource.signOut();
  }

  @override
  Future<void> signUp({required String email, required String password}) {
    throw UnimplementedError();
  }
}
