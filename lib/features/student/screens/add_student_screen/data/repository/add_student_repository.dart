import 'package:class_cloud/core/data/students/models/student.dart';
import 'package:class_cloud/features/student/screens/add_student_screen/data/source/add_student_data_source.dart';

abstract class AddStudentRepository {
  abstract final AddStudentDataSource remoteDataSource;

  Future<void> addStudent({required Student student});

  String get generateStudentId;
}
