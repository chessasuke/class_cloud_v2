import 'package:logging/logging.dart';

mixin ReporterMixin {
  late final _logger = Logger(runtimeType.toString());

  /// Use this to log any unexpected and/or unhandled errors.
  void reportFailure(Object ex, StackTrace? st, {String? message}) {
    _logger.shout(message, ex, st);
  }
}
