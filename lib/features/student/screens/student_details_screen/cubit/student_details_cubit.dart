

import 'package:class_cloud/core/data/students/models/student.dart';
import 'package:class_cloud/core/services/logger_service.dart/logger_constants.dart';
import 'package:class_cloud/features/student/screens/student_details_screen/cubit/student_details_state.dart';
import 'package:class_cloud/features/student/screens/student_details_screen/data/repository/student_details_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

class StudentDetailsCubit extends Cubit<StudentDetailsState> {
  StudentDetailsCubit({
    required this.studentRepository,
  }) : super(const StudentDetailsInitial());

  late final StudentDetailsRepository studentRepository;

  Future<void> fetchStudent({
    Student? student,
    String? studentId,
  }) async {
    assert(
      student != null || studentId != null,
      'Student or StudentId required',
    );
    if (student != null) {
      emit(StudentDetailsLoaded(student));
      return;
    }
    if (studentId != null) {
      emit(const StudentDetailsLoading());
      try {
        final student =
            await studentRepository.fetchStudentById(studentId: studentId);
        if (student != null) {
          emit(StudentDetailsLoaded(student));
          return;
        }
        emit(const StudentDetailsError('Student not found'));
        return;
      } catch (e, _) {
        Logger(LoggerConstants.student)
            .log(Level.SEVERE, 'Error fetching Student: $e');
        emit(StudentDetailsError(e));
      }
    }
  }
}
