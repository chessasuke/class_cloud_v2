import 'package:class_cloud/core/failures/failures.dart';

class FirebaseAuthFailure extends Failure {
  FirebaseAuthFailure({
    required this.title,
    this.error,
  }) : super(
          failureTitle: title,
          failureData: {
            'error': error,
          },
        );
  final String title;
  final Object? error;

  @override
  String toString() =>
      'FirebaseAuthFailure(failureTitle: $failureTitle, error: $error)';

  static const weakPassowrd = 'weak-password';
  static const emailALreadyInUse = 'email-already-in-use';
  static const userNotFound = 'user-not-found';
  static const wrongPassword = 'wrong-password';
}
