import 'dart:async';

import 'package:class_cloud/core/clients/firebase_auth_client/firebase_auth_failures.dart';
import 'package:class_cloud/core/services/logger_service.dart/logger_constants.dart';
import 'package:class_cloud/core/services/reporter/reporter_mixin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

final authClient = Provider((ref) => FirebaseAuthClient());

class FirebaseAuthClient with ReporterMixin {
  final _auth = FirebaseAuth.instance;

  Stream<User?> get authChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future<UserCredential?> signUpWithEmailAndPass({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e, st) {
      late FirebaseAuthFailure failure;
      if (e.code == FirebaseAuthFailure.weakPassowrd) {
        failure = FirebaseAuthFailure(
          title: e.message ?? '',
          error: e,
        );
      } else if (e.code == FirebaseAuthFailure.emailALreadyInUse) {
        failure = FirebaseAuthFailure(
          title: e.message ?? '',
          error: e,
        );
      } else {
        failure = FirebaseAuthFailure(
          title: e.code,
          error: e,
        );
      }
      reportFailure(
        failure,
        st,
        message: 'Failed signUpWithEmailAndPass: ${e.code} : ${e.message}',
      );
      return null;
    } catch (e, st) {
      Logger(LoggerConstants.auth).log(Level.SHOUT, 'Error signing up user');
      reportFailure(
        FirebaseAuthFailure(
          title: 'signUpWithEmailAndPass',
          error: e,
        ),
        st,
        message: 'Failed signUpWithEmailAndPass',
      );
      return null;
    }
  }

  Future<String> signInWithEmailAndPass({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'ok';
    } on FirebaseAuthException catch (e, st) {
      late FirebaseAuthFailure failure;
      if (e.code == FirebaseAuthFailure.userNotFound) {
        failure = FirebaseAuthFailure(
          title: e.message ?? '',
          error: e,
        );
      } else if (e.code == FirebaseAuthFailure.wrongPassword) {
        failure = FirebaseAuthFailure(
          title: e.code,
          error: e,
        );
      } else {
        failure = FirebaseAuthFailure(
          title: e.code,
          error: e,
        );
      }
      Logger(LoggerConstants.auth)
          .log(Level.SHOUT, 'Error signing in user: ${e.code} : ${e.message}');
      reportFailure(
        failure,
        st,
        message: 'Failed signInWithEmailAndPass: ${e.code} : ${e.message}',
      );
      return e.code;
    } catch (e, st) {
      Logger(LoggerConstants.auth).log(Level.SHOUT, 'Error signing in user');
      reportFailure(
        FirebaseAuthFailure(title: 'signInWithEmailAndPass', error: e),
        st,
        message: 'Failed signInWithEmailAndPass',
      );
      return e.toString();
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e, st) {
      Logger(LoggerConstants.auth).log(Level.SHOUT, 'Error signing out user');
      reportFailure(
        FirebaseAuthFailure(title: 'signOut', error: e),
        st,
        message: 'Failed signOut',
      );
    }
  }
}
