import 'package:class_cloud/core/data/students/models/student.dart';
import 'package:class_cloud/features/student/screens/add_student_screen/data/repository/add_student_repository.dart';
import 'package:class_cloud/features/student/screens/add_student_screen/data/source/add_student_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addStudentRepository = Provider(
  (ref) => AddStudentRepositoryImpl(
    remoteDataSource: ref.read(addStudentDataSource),
  ),
);

class AddStudentRepositoryImpl extends AddStudentRepository {
  AddStudentRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  final AddStudentDataSource remoteDataSource;

  @override
  String get generateStudentId => remoteDataSource.generateStudentId;

  @override
  Future<void> addStudent({required Student student}) async {
    await remoteDataSource.addStudent(student: student);
  }
}
