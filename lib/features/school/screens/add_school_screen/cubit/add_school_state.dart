import 'package:class_cloud/common/extensions/string_extensions.dart';
import 'package:class_cloud/core/data/school/models/course.dart';
import 'package:class_cloud/core/data/school/models/school.dart';
import 'package:equatable/equatable.dart';

sealed class AddSchoolState extends Equatable {
  const AddSchoolState();
}

class AddSchoolInitial extends AddSchoolState {
  const AddSchoolInitial({
    this.id = (value: '', error: ''),
    this.name = (value: '', error: ''),
    this.courses = (value: const <Course>[], error: ''),
  });

  final ({String? value, String error}) id;
  final ({String? value, String error}) name;
  final ({List<Course> value, String error}) courses;

  bool get isReadyForId =>
      name.error.isEmpty &&
      name.value.isNotEmptyOrNull &&
      courses.error.isEmpty &&
      courses.value.isNotEmpty;

  bool get isValid =>
      id.error.isEmpty &&
      id.value.isNotEmptyOrNull &&
      name.error.isEmpty &&
      name.value.isNotEmptyOrNull &&
      courses.error.isEmpty &&
      courses.value.isNotEmpty;

  AddSchoolInitial copyWith({
    ({String value, String error})? id,
    ({String value, String error})? name,
    ({List<Course> value, String error})? courses,
  }) =>
      AddSchoolInitial(
        id: id ?? this.id,
        name: name ?? this.name,
        courses: courses ?? this.courses,
      );

  School? get toSchool {
    print(
        ' ---- id: ${id.value} | name: ${name.value} | courses: ${courses.value}');

    if (!isValid) {
      return null;
    }
    return School(
      id: id.value!,
      name: name.value!,
      courses: courses.value,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        courses,
      ];
}

class AddSchoolLoading extends AddSchoolState {
  const AddSchoolLoading();

  @override
  List<Object?> get props => [];
}

class AddSchoolSuccess extends AddSchoolState {
  const AddSchoolSuccess({
    required this.schoolId,
  });

  final String schoolId;

  @override
  List<Object?> get props => [schoolId];
}

class AddSchoolError extends AddSchoolState {
  const AddSchoolError({
    this.error,
  });

  final Object? error;

  @override
  List<Object?> get props => [error];
}
