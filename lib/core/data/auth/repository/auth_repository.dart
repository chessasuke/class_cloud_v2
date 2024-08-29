import 'package:class_cloud/core/clients/firebase_auth_client/firebase_auth_client.dart';
import 'package:class_cloud/core/data/auth/sources/auth_remote_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'auth_repository_impl.dart';

abstract class AuthRepository {
  Stream<User?> get authChanges;
  Future<void> signInWithCredentials({
    required String email,
    required String password,
  });
  Future<void> signUp({required String email, required String password});
  Future<void> signOut();
}
