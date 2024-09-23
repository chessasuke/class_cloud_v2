import 'package:class_cloud/core/data/course/model/course.dart';

abstract class CourseRepository {
  Future<List<Course>?> fetchCourses();
}
