import 'package:class_cloud/core/data/students/models/student.dart';
import 'package:class_cloud/core/data/students/repository/students_repository.dart';
import 'package:class_cloud/core/data/students/sources/student_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final studentsRepository = Provider<StudentsRepository>(
  (ref) => StudentsRepositoryImpl(
    studentDataSource: ref.read(studentDataSource),
  ),
);

class StudentsRepositoryImpl implements StudentsRepository {
  StudentsRepositoryImpl({
    required StudentDataSource studentDataSource,
  }) : _studentDataSource = studentDataSource;

  final StudentDataSource _studentDataSource;

  @override
  Future<List<Student>?> fetchStudents() async {
    return await _studentDataSource.fetchStudents();
  }
}
