import 'package:class_cloud/core/data/course/model/course.dart';
import 'package:equatable/equatable.dart';

sealed class CourseListState extends Equatable {
  const CourseListState();

  @override
  List<Object> get props => [];
}

class CourseListInitial extends CourseListState {
  const CourseListInitial();
}

class CourseListLoading extends CourseListState {
  const CourseListLoading();
}

class CourseListLoaded extends CourseListState {
  const CourseListLoaded({required this.courses, this.filter = ''});

  final List<Course> courses;
  final String filter;

  CourseListLoaded copyWith({
    List<Course>? courses,
    String? filter,
  }) {
    return CourseListLoaded(
      courses: courses ?? this.courses,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object> get props => [courses, filter];
}

class CourseListError extends CourseListState {
  const CourseListError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
