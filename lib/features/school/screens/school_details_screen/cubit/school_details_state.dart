import 'package:class_cloud/core/data/school/models/school.dart';
import 'package:equatable/equatable.dart';

sealed class SchoolDetailsState extends Equatable {
  const SchoolDetailsState();
}

class SchoolDetailsInitial extends SchoolDetailsState {
  const SchoolDetailsInitial();

  @override
  List<Object?> get props => [];
}

class SchoolDetailsLoading extends SchoolDetailsState {
  const SchoolDetailsLoading();

  @override
  List<Object?> get props => [];
}

class SchoolDetailsLoaded extends SchoolDetailsState {
  const SchoolDetailsLoaded(this.school);

  final School school;

  @override
  List<Object?> get props => [school];
}

class SchoolDetailsError extends SchoolDetailsState {
  const SchoolDetailsError(this.error);
  final Object error;
  @override
  List<Object?> get props => [error];
}
