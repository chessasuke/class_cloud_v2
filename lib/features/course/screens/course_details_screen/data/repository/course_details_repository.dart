import 'package:class_cloud/core/data/course/model/course.dart';

abstract class CourseDetailsRepository {
  Future<Course?> fetchCourseById({required String courseId});
}
