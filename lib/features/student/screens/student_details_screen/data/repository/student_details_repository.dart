
import 'package:class_cloud/core/data/students/models/student.dart';

abstract class StudentDetailsRepository {
  Future<Student?> fetchStudentById({required String studentId});
}
