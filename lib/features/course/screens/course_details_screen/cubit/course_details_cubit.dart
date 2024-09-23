import 'package:class_cloud/core/data/course/model/course.dart';
import 'package:class_cloud/core/services/logger_service.dart/logger_constants.dart';
import 'package:class_cloud/features/course/screens/course_details_screen/cubit/course_details_state.dart';
import 'package:class_cloud/features/course/screens/course_details_screen/data/repository/course_details_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

class CourseDetailsCubit extends Cubit<CourseDetailsState> {
  CourseDetailsCubit({
    required this.courseRepository,
  }) : super(const CourseDetailsInitial());

  late final CourseDetailsRepository courseRepository;

  Future<void> fetchCourse({
    Course? course,
    String? courseId,
  }) async {
    assert(
      course != null || courseId != null,
      'Course or courseId required',
    );
    if (course != null) {
      emit(CourseDetailsLoaded(course));
      return;
    }
    if (courseId != null) {
      emit(const CourseDetailsLoading());
      try {
        final course =
            await courseRepository.fetchCourseById(courseId: courseId);
        if (course != null) {
          emit(CourseDetailsLoaded(course));
          return;
        }
        emit(const CourseDetailsError('Course not found'));
        return;
      } catch (e, _) {
        Logger(LoggerConstants.course)
            .log(Level.SEVERE, 'Error fetching course: $e');
        emit(CourseDetailsError(e));
      }
    }
  }
}
