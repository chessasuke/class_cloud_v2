
import 'package:class_cloud/core/failures/failures.dart';

class SharedPreferencesFailure extends Failure {
  SharedPreferencesFailure({
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
      'SharedPreferencesFailure(failureTitle: $failureTitle, error: $error)';
}
