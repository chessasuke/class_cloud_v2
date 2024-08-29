import 'package:class_cloud/common/extensions/string_extensions.dart';
import 'package:class_cloud/core/data/coaches/models/coach.dart';
import 'package:class_cloud/core/data/school/models/course.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class AddCourseState extends Equatable {
  const AddCourseState(
   {required this.coaches,}
  );

  final List<Coach> coaches;

  @override
  List<Object?> get props => [coaches, coaches];
}

class AddCourseLoading extends AddCourseState {
  const AddCourseLoading({required super.coaches});

  @override
  List<Object?> get props => [coaches, coaches];
}

class AddCourseInitial extends AddCourseState {
  const AddCourseInitial({
    this.dayOfWeek = (value: null, error: ''),
    this.timeOfDay = (value: null, error: ''),
    this.courseColor = (value: null, error: ''),
    this.coachesSelected = (value: const <Coach>[], error: ''),
    required super.coaches,
  });

  final ({DayOfWeek? value, String error}) dayOfWeek;
  final ({TimeOfDay? value, String error}) timeOfDay;
  final ({CourseColor? value, String error}) courseColor;
  final ({List<Coach> value, String error}) coachesSelected;

  bool get isValid =>
      dayOfWeek.error.isEmpty &&
      dayOfWeek.value != null &&
      timeOfDay.error.isEmpty &&
      timeOfDay.value != null &&
      courseColor.error.isEmpty &&
      courseColor.value != null &&
      coachesSelected.error.isEmpty &&
      coachesSelected.value.isNotEmpty;

  AddCourseInitial copyWith({
    ({DayOfWeek? value, String error})? dayOfWeek,
    ({TimeOfDay? value, String error})? timeOfDay,
    ({CourseColor? value, String error})? courseColor,
    ({List<Coach> value, String error})? coachesSelected,
  }) =>
      AddCourseInitial(
        dayOfWeek: dayOfWeek ?? this.dayOfWeek,
        timeOfDay: timeOfDay ?? this.timeOfDay,
        courseColor: courseColor ?? this.courseColor,
        coachesSelected: coachesSelected ?? this.coachesSelected,
        coaches: coaches,
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
      coaches: coachesSelected.value,
    );
  }

  @override
  List<Object?> get props => [
        dayOfWeek,
        timeOfDay,
        courseColor,
        coachesSelected,
        coaches,
      ];
}

class AddCourseReady extends AddCourseState {
  const AddCourseReady({
    required this.course,
    required super.coaches,
  });

  final Course course;

  @override
  List<Object?> get props => [course, coaches];
}

class AddCourseError extends AddCourseState {
  const AddCourseError({
    this.error,
    required super.coaches,
  });

  final Object? error;

  @override
  List<Object?> get props => [error, coaches];
}
