import 'package:class_cloud/core/data/students/models/student.dart';

abstract class StudentsRepository {
  Future<List<Student>?> fetchStudents();

  Future<List<Student>?> queryStudents(
    String school,
  );
}
