import 'package:class_cloud/core/data/coaches/models/coach.dart';
import 'package:class_cloud/core/services/logger_service.dart/logger_constants.dart';
import 'package:class_cloud/features/coach/screens/coach_details_screen/cubit/coach_details_state.dart';
import 'package:class_cloud/features/coach/screens/coach_details_screen/data/repository/coach_details_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

class CoachDetailsCubit extends Cubit<CoachDetailsState> {
  CoachDetailsCubit({
    required this.coachRepository,
  }) : super(const CoachDetailsInitial());

  late final CoachDetailsRepository coachRepository;

  Future<void> fetchCoach({
    Coach? coach,
    String? coachId,
  }) async {
    assert(
      coach != null || coachId != null,
      'Coach or CoachId required',
    );
    if (coach != null) {
      emit(CoachDetailsLoaded(coach));
      return;
    }
    if (coachId != null) {
      emit(const CoachDetailsLoading());
      try {
        final coach =
            await coachRepository.fetchCoachById(coachId: coachId);
        if (coach != null) {
          emit(CoachDetailsLoaded(coach));
          return;
        }
        emit(const CoachDetailsError('Coach not found'));
        return;
      } catch (e, _) {
        Logger(LoggerConstants.coach)
            .log(Level.SEVERE, 'Error fetching Coach: $e');
        emit(CoachDetailsError(e));
      }
    }
  }
}
