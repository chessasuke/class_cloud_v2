import 'package:class_cloud/core/data/coaches/repository/coaches_repository.dart';
import 'package:class_cloud/core/data/school/models/course.dart';
import 'package:class_cloud/core/data/students/repository/students_repository.dart';
import 'package:class_cloud/features/school/screens/add_school_screen/widgets/course_input/cubit/add_course_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCourseCubit extends Cubit<AddCourseState> {
  AddCourseCubit({
    required this.coachesRepository,
    required this.studentsRepository,
  }) : super(const AddCourseInitial()) {
    fetchCoachesAndStudents();
  }

  final CoachesRepository coachesRepository;
  final StudentsRepository studentsRepository;

  Future<void> fetchCoachesAndStudents() async {
    emit(AddCourseLoading());

    final coaches = await coachesRepository.fetchCoaches();
    final students = await studentsRepository.queryStudents('Travis');

    if (coaches == null || students == null) {
      emit(const AddCourseError());
      return;
    } else {
      emit(AddCourseInitial(
        coaches: (
          value: coaches.map((e) => (coach: e, isSelected: false)).toList(),
          error: ''
        ),
        students: (
          value: students.map((e) => (student: e, isSelected: false)).toList(),
          error: '',
        ),
      ));
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

  void toggleCoach({required String coachId, required bool isSelected}) {
    final currentState = state;
    if (currentState is! AddCourseInitial) return;

    final coaches = <CoachSelection>[];

    for (var coachSelection in currentState.coaches.value) {
      if (coachSelection.coach.id == coachId) {
        final updatedCoachSelection = (
          coach: coachSelection.coach,
          isSelected: isSelected,
        );
        coaches.add(updatedCoachSelection);
      } else {
        coaches.add(coachSelection);
      }
    }

    emit(currentState.copyWith(coaches: (value: coaches, error: '')));
  }

  void toggleStudent({required String studentId, required bool isSelected}) {
    final currentState = state;
    if (currentState is! AddCourseInitial) return;

    final students = <StudentSelection>[];

    for (var studentSelection in currentState.students.value) {
      if (studentSelection.student.id == studentId) {
        final updatedStudentsSelection = (
          student: studentSelection.student,
          isSelected: isSelected,
        );
        students.add(updatedStudentsSelection);
      } else {
        students.add(studentSelection);
      }
    }

    emit(currentState.copyWith(students: (value: students, error: '')));
  }

  bool checkIfCourseReady() {
    final currentState = state;
    if (currentState is AddCourseInitial && currentState.isValid) {
      final course = currentState.toCourse();
      if (course != null) {
        emit(AddCourseReady(
          course: course,
          coaches: currentState.coaches.value
              .where((c) => c.isSelected)
              .map((e) => e.coach)
              .toList(),
          students: currentState.students.value
              .where((s) => s.isSelected)
              .map((e) => e.student)
              .toList(),
        ));
        return true;
      }
    }
    return false;
  }

  Future<void> addCourse() async {
    final currentState = state;
    if (currentState is AddCourseInitial) return;
    emit(AddCourseLoading());

    /// Generate School ID and add it
    final courseId = addCourseRe.generateSchoolId;
    if (schoolId.isEmpty) {
      emit(const AddSchoolError(error: 'Failed to generate School ID'));
      return;
    }
    final schoolWithId = schoolToAdd.copyWith(id: (value: schoolId, error: ''));
    //// Convert School data to School object and validate it
    final school = schoolWithId.toSchool;
    if (school == null) {
      emit(const AddSchoolError(error: 'Invalid School data'));
      return;
    }

    // If school info is valid, upload the School info
    try {
      await addSchoolRepository.addSchool(school: school);
      emit(AddSchoolSuccess(schoolId: schoolId));
    } catch (e) {
      emit(const AddSchoolError(error: 'Failed to add School'));
    }
  }


  void reset() {
    fetchCoachesAndStudents();
  }
}
