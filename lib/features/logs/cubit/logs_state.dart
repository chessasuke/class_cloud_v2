import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';

class LogsState extends Equatable {
  const LogsState({
    this.logs = const <LogRecord>[],
  });

  final List<LogRecord> logs;

  @override
  List<Object?> get props => [logs];
}
