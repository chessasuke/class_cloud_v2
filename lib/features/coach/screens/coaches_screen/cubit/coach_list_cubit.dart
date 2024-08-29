import 'dart:async';

import 'package:class_cloud/core/data/coaches/repository/coaches_repository.dart';
import 'package:class_cloud/features/coach/screens/coaches_screen/cubit/coach_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoachListCubit extends Cubit<CoachListState> {
  CoachListCubit({
    required this.coachesRepository,
  }) : super(const CoachListInitial());

  final CoachesRepository coachesRepository;

  Future<void> fetchAllCoaches() async {
    final coaches = await coachesRepository.fetchCoaches();

    if (coaches == null) {
      emit(const CoachListError('Failed to fetch Coachs'));
      return;
    }
    emit(CoachListLoaded(coaches));
  }

  void filterCoaches(String filter) {
    final currentState = state;
    if (currentState is! CoachListLoaded) return;
    final coaches = currentState.coaches;

    if (filter.isNotEmpty) {
      final filteredCoachs = coaches
          .where(
            (coach) => (coach.firstName
                    .toLowerCase()
                    .startsWith(filter.toLowerCase()) ||
                coach.lastName.toLowerCase().startsWith(filter.toLowerCase()) ||
                coach.email.toLowerCase().startsWith(
                      filter.toLowerCase(),
                    )),
          )
          .toList();
      emit(CoachListLoaded(filteredCoachs));
    }
  }
}
