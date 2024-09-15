import 'package:class_cloud/common/extensions/string_extensions.dart';
import 'package:class_cloud/core/data/coaches/models/coach.dart';
import 'package:class_cloud/core/data/school/models/course.dart';
import 'package:class_cloud/core/data/students/models/student.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

typedef CoachSelection = ({Coach coach, bool isSelected});
typedef StudentSelection = ({Student student, bool isSelected});

sealed class AddCourseState extends Equatable {
  const AddCourseState();

  @override
  List<Object?> get props => [];
}

class AddCourseLoading extends AddCourseState {
  @override
  List<Object?> get props => [];
}

class AddCourseInitial extends AddCourseState {
  const AddCourseInitial({
    this.dayOfWeek = (value: null, error: ''),
    this.timeOfDay = (value: null, error: ''),
    this.courseColor = (value: null, error: ''),
    this.coaches = (value: const <CoachSelection>[], error: ''),
    this.students = (value: const <StudentSelection>[], error: ''),
  });

  final ({DayOfWeek? value, String error}) dayOfWeek;
  final ({TimeOfDay? value, String error}) timeOfDay;
  final ({CourseColor? value, String error}) courseColor;
  final ({List<CoachSelection> value, String error}) coaches;
  final ({List<StudentSelection> value, String error}) students;

  bool get isValid =>
      dayOfWeek.error.isEmpty &&
      dayOfWeek.value != null &&
      timeOfDay.error.isEmpty &&
      timeOfDay.value != null &&
      courseColor.error.isEmpty &&
      courseColor.value != null &&
      coaches.error.isEmpty &&
      coaches.value.isNotEmpty &&
      students.error.isEmpty &&
      students.value.isNotEmpty;

  AddCourseInitial copyWith({
    ({DayOfWeek? value, String error})? dayOfWeek,
    ({TimeOfDay? value, String error})? timeOfDay,
    ({CourseColor? value, String error})? courseColor,
    ({List<CoachSelection> value, String error})? coaches,
    ({List<StudentSelection> value, String error})? students,
  }) =>
      AddCourseInitial(
        dayOfWeek: dayOfWeek ?? this.dayOfWeek,
        timeOfDay: timeOfDay ?? this.timeOfDay,
        courseColor: courseColor ?? this.courseColor,
        coaches: coaches ?? this.coaches,
        students: students ?? this.students,
      );

  Course? toCourse() {
    if (!isValid) return null;
    final courseId =
        '${courseColor.value!.name}-${dayOfWeek.value!.name.substring(0, 2).capitalize()}';
    return Course(
      id: courseId,
      dayOfWeek: dayOfWeek.value!,
      timeOfDay: timeOfDay.value!,
      courseColor: courseColor.value!,
      coaches:
          coaches.value.where((c) => c.isSelected).map((e) => e.coach).toList(),
    );
  }

  @override
  List<Object?> get props => [
        dayOfWeek,
        timeOfDay,
        courseColor,
        coaches,
        students,
      ];
}

class AddCourseReady extends AddCourseState {
  const AddCourseReady({
    required this.course,
    required this.coaches,
    required this.students,
  });

  final Course course;
  final List<Coach> coaches;
  final List<Student> students;

  @override
  List<Object?> get props => [course, coaches, students];
}

class AddCourseError extends AddCourseState {
  const AddCourseError({
    this.error,
  });

  final Object? error;

  @override
  List<Object?> get props => [error];
}
