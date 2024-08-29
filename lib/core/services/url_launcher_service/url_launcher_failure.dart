
import 'package:class_cloud/core/failures/failures.dart';

class UrlLauncherFailure extends Failure {
  UrlLauncherFailure({
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
      'UrlLauncherFailure(failureTitle: $failureTitle, error: $error)';
}
