import 'package:class_cloud/core/data/schools/models/school.dart';
import 'package:equatable/equatable.dart';

sealed class SelectSchoolState extends Equatable {
  const SelectSchoolState();

  @override
  List<Object?> get props => [];
}

class SelectSchoolLoading extends SelectSchoolState {
  @override
  List<Object?> get props => [];
}

class SelectSchoolSuccess extends SelectSchoolState {
  const SelectSchoolSuccess({
    required this.schools,
  });

  final List<School> schools;

  @override
  List<Object?> get props => [schools];
}

class SelectSchoolError extends SelectSchoolState {
  const SelectSchoolError({
    this.error,
  });

  final Object? error;

  @override
  List<Object?> get props => [error];
}
