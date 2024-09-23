import 'package:class_cloud/core/data/course/model/course.dart';
import 'package:class_cloud/features/course/screens/course_details_screen/data/repository/course_details_repository.dart';
import 'package:class_cloud/features/course/screens/course_details_screen/data/source/course_details_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final courseDetailsRepository = Provider(
  (ref) => CourseDetailsRepositoryImpl(
    courseDataSource: ref.read(courseDetailsDataSource),
  ),
);

class CourseDetailsRepositoryImpl implements CourseDetailsRepository {
  CourseDetailsRepositoryImpl({required this.courseDataSource});

  final CourseDetailsDataSource courseDataSource;

  @override
  Future<Course?> fetchCourseById({required String courseId}) async {
    return await courseDataSource.fetchCourseById(courseId: courseId);
  }
}
