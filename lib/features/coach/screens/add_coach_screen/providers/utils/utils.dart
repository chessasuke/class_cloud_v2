
import 'package:class_cloud/features/coach/screens/add_coach_screen/providers/cubit/add_coach_state.dart';

abstract class AddCoachUtils {
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

  static AddCoachInitial isCoachInfoValid(
    AddCoachInitial coach,
  ) {
    final emailError = _isEmailValid(coach.email.value);
    final firstNameError = _isFirstNameValid(coach.firstName.value);
    final lastNameError = _isLastNameValid(coach.lastName.value);

    final updatedCoach = coach.copyWith(
      email: (value: coach.email.value, error: emailError),
      firstName: (value: coach.firstName.value, error: firstNameError),
      lastName: (value: coach.lastName.value, error: lastNameError),
    );

    return updatedCoach;
  }
}
