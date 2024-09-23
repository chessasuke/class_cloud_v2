import 'package:class_cloud/core/data/coaches/repository/coaches_repository.dart';
import 'package:class_cloud/core/data/course/model/course.dart';
import 'package:class_cloud/core/data/students/repository/students_repository.dart';
import 'package:class_cloud/features/course/screens/add_course_screen/cubit/add_course_state.dart';
import 'package:class_cloud/features/course/screens/add_course_screen/data/repository/add_course_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCourseCubit extends Cubit<AddCourseState> {
  AddCourseCubit({
    required this.coachesRepository,
    required this.studentsRepository,
    required this.addCourseRepository,
    required this.school,
  }) : super(const AddCourseInitial()) {
    fetchData();
  }

  final CoachesRepository coachesRepository;
  final StudentsRepository studentsRepository;
  final AddCourseRepository addCourseRepository;
  final String school;

  Future<void> fetchData() async {
    emit(AddCourseLoading());

    final coaches = await coachesRepository.fetchCoaches();
    final students = await studentsRepository.queryStudents(school);

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

  Future<void> addCourse() async {
    final currentState = state;
    if (currentState is! AddCourseInitial) return;
    emit(AddCourseLoading());

    // If course info is valid, upload the course info
    try {
      if (currentState.isValid) {
        final course = currentState.toCourse(school);
        if (course != null) {
          await addCourseRepository.addCourse(course: course);
          emit(AddCourseSuccess(
            courseId: course.id!,
          ));
        }
      } else {
        emit(const AddCourseError(error: 'Invalid course info'));
      }
    } catch (e) {
      emit(const AddCourseError(error: 'Failed to add course'));
    }
  }

  void reset() {
    fetchData();
  }
}
