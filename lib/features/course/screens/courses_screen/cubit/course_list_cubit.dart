import 'package:class_cloud/core/data/course/repository/course_repository.dart';
import 'package:class_cloud/features/course/screens/courses_screen/cubit/course_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseListCubit extends Cubit<CourseListState> {
  CourseListCubit({
    required this.courseRepository,
  }) : super(const CourseListInitial());

  final CourseRepository courseRepository;

  Future<void> fetchAllCourses() async {
    final courses = await courseRepository.fetchCourses();

    if (courses == null) {
      emit(const CourseListError('Failed to fetch courses'));
      return;
    }
    emit(CourseListLoaded(courses: courses));
  }

  void filterCourses(String filter) {
    final currentState = state;
    if (currentState is! CourseListLoaded) return;
    emit(currentState.copyWith(filter: filter));
  }
}
