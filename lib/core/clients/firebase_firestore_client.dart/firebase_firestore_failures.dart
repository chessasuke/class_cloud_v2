
import 'package:class_cloud/core/failures/failures.dart';

class FirebaseFirestoreFailure extends Failure {
  FirebaseFirestoreFailure({
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
      'FirebaseFirestoreFailure(failureTitle: $failureTitle, error: $error)';
}
