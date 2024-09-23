import 'package:class_cloud/core/data/course/model/course.dart';
import 'package:class_cloud/features/course/screens/add_course_screen/data/repository/add_course_repository.dart';
import 'package:class_cloud/features/course/screens/add_course_screen/data/source/add_course_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addCourseRepository = Provider(
  (ref) => AddCourseRepositoryImpl(
    remoteDataSource: ref.read(addCourseDataSource),
  ),
);

class AddCourseRepositoryImpl extends AddCourseRepository {
  AddCourseRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  final AddCourseDataSource remoteDataSource;

  @override
  String get generateCourseId => remoteDataSource.generateCourseId;

  @override
  Future<void> addCourse({required Course course}) async {
    await remoteDataSource.addCourse(course: course);
  }
}
