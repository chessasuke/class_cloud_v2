

import 'package:class_cloud/features/student/screens/add_student_screen/cubit/add_student_state.dart';

abstract class AddStudentUtils {
  static String _isEmailValid(String? email) {
    if (email == null) return 'Email is required';
    if (email.isEmpty) return 'Email cannot be empty';
    final isEmailValid = RegExp(
      r'''^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$''',
    ).hasMatch(email);
    if (isEmailValid) {
      return '';
    } else {
      return 'Invalid email';
    }
  }

  static String _isFirstNameValid(String? name) {
    if (name == null) return 'First name is required';
    if (name.isEmpty) return 'First name cannot be empty';
    return '';
  }

  static String _isLastNameValid(String? name) {
    if (name == null) return 'Last name is required';
    if (name.isEmpty) return 'Last name is required';
    return '';
  }

  static AddStudentInitial isStudentInfoValid(
    AddStudentInitial student,
  ) {
    final emailError = _isEmailValid(student.email.value);
    final firstNameError = _isFirstNameValid(student.firstName.value);
    final lastNameError = _isLastNameValid(student.lastName.value);

    final updatedStudent = student.copyWith(
      email: (value: student.email.value, error: emailError),
      firstName: (value: student.firstName.value, error: firstNameError),
      lastName: (value: student.lastName.value, error: lastNameError),
    );

    return updatedStudent;
  }
}
