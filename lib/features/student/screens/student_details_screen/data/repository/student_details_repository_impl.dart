import 'package:class_cloud/core/data/students/models/student.dart';
import 'package:class_cloud/features/student/screens/student_details_screen/data/repository/student_details_repository.dart';
import 'package:class_cloud/features/student/screens/student_details_screen/data/source/student_details_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final studentDetailsRepository = Provider(
  (ref) => StudentDetailsRepositoryImpl(
    studentDataSource: ref.read(studentDetailsDataSource),
  ),
);

class StudentDetailsRepositoryImpl implements StudentDetailsRepository {
  StudentDetailsRepositoryImpl({required this.studentDataSource});

  final StudentDetailsDataSource studentDataSource;

  @override
  Future<Student?> fetchStudentById({required String studentId}) async {
    return await studentDataSource.fetchStudentById(studentId: studentId);
  }
}
