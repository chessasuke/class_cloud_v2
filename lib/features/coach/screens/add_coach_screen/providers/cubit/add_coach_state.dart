import 'package:class_cloud/core/data/coaches/models/coach.dart';
import 'package:equatable/equatable.dart';

sealed class AddCoachState extends Equatable {
  const AddCoachState();
}

class AddCoachInitial extends AddCoachState {
  const AddCoachInitial({
    this.email = (value: '', error: ''),
    this.firstName = (value: '', error: ''),
    this.lastName = (value: '', error: ''),
  });

  final ({String value, String error}) email;
  final ({String value, String error}) firstName;
  final ({String value, String error}) lastName;

  bool get isValid =>
      email.error.isEmpty &&
      email.value.isNotEmpty &&
      firstName.error.isEmpty &&
      firstName.value.isNotEmpty &&
      lastName.error.isEmpty &&
      lastName.value.isNotEmpty;

  AddCoachInitial copyWith({
    String? coachId,
    ({String value, String error})? email,
    ({String value, String error})? firstName,
    ({String value, String error})? lastName,
  }) =>
      AddCoachInitial(
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
      );

  Coach toCoach(String coachId) {
    if (!isValid) {
      throw Exception('Coach data is not valid');
    }
    return Coach(
      id: coachId,
      email: email.value,
      firstName: firstName.value,
      lastName: lastName.value,
    );
  }

  @override
  List<Object?> get props => [
        email,
        firstName,
        lastName,
      ];
}

class AddCoachLoading extends AddCoachState {
  const AddCoachLoading();

  @override
  List<Object?> get props => [];
}

class AddCoachSuccess extends AddCoachState {
  const AddCoachSuccess({
    required this.coachId,
  });

  final String coachId;

  @override
  List<Object?> get props => [coachId];
}

class AddCoachError extends AddCoachState {
  const AddCoachError({
    this.error,
  });

  final Object? error;

  @override
  List<Object?> get props => [error];
}
