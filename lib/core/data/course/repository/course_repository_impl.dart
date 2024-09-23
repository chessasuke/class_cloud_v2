import 'package:class_cloud/core/data/course/model/course.dart';
import 'package:class_cloud/core/data/course/repository/course_repository.dart';
import 'package:class_cloud/core/data/course/sources/course_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final courseRepository = Provider<CourseRepository>(
  (ref) => CourseRepositoryImpl(
    courseDataSource: ref.read(courseDataSource),
  ),
);

class CourseRepositoryImpl implements CourseRepository {
  CourseRepositoryImpl({
    required CoursesDataSource courseDataSource,
  }) : _courseDataSource = courseDataSource;

  final CoursesDataSource _courseDataSource;

  @override
  Future<List<Course>?> fetchCourses() async {
    return await _courseDataSource.fetchCourses();
  }
}
