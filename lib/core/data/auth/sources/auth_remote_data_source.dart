import 'package:class_cloud/core/clients/firebase_auth_client/firebase_auth_client.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource(this.auth);

  final FirebaseAuthClient auth;

  Stream<User?> get authChanges => auth.authChanges;

  Future<void> signInWithCredentials({
    required String email,
    required String password,
  }) async {
    await auth.signInWithEmailAndPass(email: email, password: password);
  }

  Future<void> signOut() async => await auth.signOut();

  Future<void> signUp({required String email, required String password}) async {
    throw UnimplementedError();
  }
}
