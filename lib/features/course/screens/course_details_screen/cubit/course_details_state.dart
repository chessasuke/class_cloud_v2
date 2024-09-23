import 'package:class_cloud/core/data/course/model/course.dart';
import 'package:equatable/equatable.dart';

sealed class CourseDetailsState extends Equatable {
  const CourseDetailsState();
}

class CourseDetailsInitial extends CourseDetailsState {
  const CourseDetailsInitial();

  @override
  List<Object?> get props => [];
}

class CourseDetailsLoading extends CourseDetailsState {
  const CourseDetailsLoading();

  @override
  List<Object?> get props => [];
}

class CourseDetailsLoaded extends CourseDetailsState {
  const CourseDetailsLoaded(this.course);

  final Course course;

  @override
  List<Object?> get props => [course];
}

class CourseDetailsError extends CourseDetailsState {
  const CourseDetailsError(this.error);
  final Object error;
  @override
  List<Object?> get props => [error];
}
