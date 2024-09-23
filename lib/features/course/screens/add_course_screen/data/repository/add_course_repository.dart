import 'package:class_cloud/core/data/course/model/course.dart';
import 'package:class_cloud/features/course/screens/add_course_screen/data/source/add_course_data_source.dart';

abstract class AddCourseRepository {
  abstract final AddCourseDataSource remoteDataSource;

  Future<void> addCourse({required Course course});

  String get generateCourseId;
}
