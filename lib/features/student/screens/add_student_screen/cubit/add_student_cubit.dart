import 'package:class_cloud/core/data/user/repository/user_repository.dart';
import 'package:class_cloud/features/student/screens/add_student_screen/data/repository/add_student_repository.dart';
import 'package:class_cloud/features/student/screens/add_student_screen/cubit/add_student_state.dart';
import 'package:class_cloud/features/student/screens/add_student_screen/cubit/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddStudentCubit extends Cubit<AddStudentState> {
  AddStudentCubit({
    required this.addStudentRepository,
    required this.userRepository,
  }) : super(const AddStudentInitial());

  late final AddStudentRepository addStudentRepository;
  late final UserRepository userRepository;

  void updateEmail(String email) {
    final currentState = state;
    if (currentState is! AddStudentInitial) return;
    emit(currentState.copyWith(email: (value: email, error: '')));
  }

  void updateFirstName(String firstName) {
    final currentState = state;
    if (currentState is! AddStudentInitial) return;
    emit(currentState.copyWith(firstName: (value: firstName, error: '')));
  }

  void updateLastName(String lastName) {
    final currentState = state;
    if (currentState is! AddStudentInitial) return;
    emit(currentState.copyWith(lastName: (value: lastName, error: '')));
  }

  Future<void> addStudent() async {
    final studentToAdd = state;
    if (studentToAdd is! AddStudentInitial) return;
    emit(const AddStudentLoading());

    // Validate Student info
    final validatedStudentInfo =
        AddStudentUtils.isStudentInfoValid(studentToAdd);
    // If Student info is not valid, return the updated state with the collected errors
    if (!validatedStudentInfo.isValid) {
      emit(validatedStudentInfo);
      return;
    }
    final studentId = addStudentRepository.generateStudentId;

    if (studentId.isEmpty) {
      emit(const AddStudentError(error: 'Failed to generate Student ID'));
      return;
    }
    final student = studentToAdd.toStudent(studentId);
    // If Student info is valid, upload the Student info
    try {
      await addStudentRepository.addStudent(student: student);
      emit(AddStudentSuccess(studentId: studentId));
    } catch (e) {
      emit(const AddStudentError(error: 'Failed to add Student'));
    }
  }
}
