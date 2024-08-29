import 'package:class_cloud/core/data/students/repository/students_repository.dart';
import 'package:class_cloud/features/student/screens/students_screen/cubit/student_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentListCubit extends Cubit<StudentListState> {
  StudentListCubit({
    required this.studentesRepository,
  }) : super(const StudentListInitial());

  final StudentsRepository studentesRepository;

  Future<void> fetchAllStudentes() async {
    final studentes = await studentesRepository.fetchStudents();

    if (studentes == null) {
      emit(const StudentListError('Failed to fetch Students'));
      return;
    }
    emit(StudentListLoaded(studentes));
  }

  void filterStudents(String filter) {
    final currentState = state;
    if (currentState is! StudentListLoaded) return;
    final studentes = currentState.studentes;

    if (filter.isNotEmpty) {
      final filteredStudents = studentes
          .where(
            (student) => (student.firstName
                    .toLowerCase()
                    .startsWith(filter.toLowerCase()) ||
                student.lastName
                    .toLowerCase()
                    .startsWith(filter.toLowerCase()) ||
                student.email.toLowerCase().startsWith(
                      filter.toLowerCase(),
                    )),
          )
          .toList();
      emit(StudentListLoaded(filteredStudents));
    }
  }
}
