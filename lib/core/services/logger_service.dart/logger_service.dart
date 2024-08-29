import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

final loggerService = Provider((ref) => LoggerService());

class LoggerService {
  
  final _logs = <LogRecord>[];
  List<LogRecord> get logs => _logs;

  void init() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      _logs.add(record);
      if (_logs.length > 500) {
        _logs.removeAt(0);
      }
    });
  }
}
