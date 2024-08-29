import 'package:class_cloud/core/data/coaches/models/coach.dart';
import 'package:class_cloud/core/data/coaches/repository/coaches_repository.dart';
import 'package:class_cloud/core/data/school/models/course.dart';
import 'package:class_cloud/features/school/screens/add_school_screen/widgets/course_input/cubit/add_course_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCourseCubit extends Cubit<AddCourseState> {
  AddCourseCubit({
    required this.coachesRepository,
  }) : super(const AddCourseInitial(coaches: [])) {
    fetchCoaches();
  }

  final CoachesRepository coachesRepository;

  Future<void> fetchCoaches() async {
    emit(const AddCourseLoading(
      coaches: [],
    ));

    final coaches = await coachesRepository.fetchCoaches();

    if (coaches == null) {
      emit(const AddCourseError(
        coaches: [],
      ));
      return;
    } else {
      emit(AddCourseInitial(coaches: coaches));
    }
  }

  void updateCourseColor(CourseColor color) {
    final currentState = state;
    if (currentState is! AddCourseInitial) return;
    emit(currentState.copyWith(courseColor: (value: color, error: '')));
  }

  void updateTimeOfDay(TimeOfDay timeOfDay) {
    final currentState = state;
    if (currentState is! AddCourseInitial) return;
    emit(currentState.copyWith(timeOfDay: (value: timeOfDay, error: '')));
  }

  void updateDayOfWeek(DayOfWeek dayOfWeek) {
    final currentState = state;
    if (currentState is! AddCourseInitial) return;
    emit(currentState.copyWith(dayOfWeek: (value: dayOfWeek, error: '')));
  }

  void addCoach(Coach coach) {
    final currentState = state;
    if (currentState is! AddCourseInitial) return;

    emit(currentState.copyWith(
      coachesSelected: (
        value: [...currentState.coachesSelected.value, coach],
        error: ''
      ),
    ));
  }

  void deleteCoach(String coachId) {
    final currentState = state;
    if (currentState is! AddCourseInitial) return;

    final coaches = <Coach>[];

    for (var coach in currentState.coachesSelected.value) {
      if (coach.id == coachId) {
        continue;
      }
      coaches.add(coach);
    }
    emit(currentState.copyWith(
      coachesSelected: (value: coaches, error: ''),
    ));
  }

  bool checkIfCourseReady() {
    final currentState = state;
    if (currentState is AddCourseInitial && currentState.isValid) {
      final course = currentState.toCourse();
      if (course != null) {
        emit(AddCourseReady(
          course: course,
          coaches: currentState.coachesSelected.value,
        ));
        return true;
      }
    }
    return false;
  }

  void reset() {
    emit(AddCourseInitial(coaches: state.coaches));
  }
}
