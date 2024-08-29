import 'package:class_cloud/core/services/logger_service.dart/logger_service.dart';
import 'package:class_cloud/features/logs/cubit/logs_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogsCubit extends Cubit<LogsState> {
  LogsCubit({
    required this.loggerService,
  }) : super(const LogsState());

  final LoggerService loggerService;

  void init() {
    emit(LogsState(logs: loggerService.logs));
  }
}
