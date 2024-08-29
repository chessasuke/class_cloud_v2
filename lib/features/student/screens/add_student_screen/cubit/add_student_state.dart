import 'package:class_cloud/core/data/students/models/student.dart';
import 'package:equatable/equatable.dart';

sealed class AddStudentState extends Equatable {
  const AddStudentState();
}

class AddStudentInitial extends AddStudentState {
  const AddStudentInitial({
    this.email = (value: '', error: ''),
    this.firstName = (value: '', error: ''),
    this.lastName = (value: '', error: ''),
    this.age = (value: 0, error: ''),
    this.grade = (value: 0, error: ''),
  });

  final ({String value, String error}) email;
  final ({String value, String error}) firstName;
  final ({String value, String error}) lastName;
  final ({int value, String error}) age;
  final ({int value, String error}) grade;

  bool get isValid =>
      email.error.isEmpty &&
      email.value.isNotEmpty &&
      firstName.error.isEmpty &&
      firstName.value.isNotEmpty &&
      lastName.error.isEmpty &&
      lastName.value.isNotEmpty &&
      age.error.isNotEmpty &&
      age.value > 0 &&
      grade.error.isEmpty &&
      grade.value > 0;

  AddStudentInitial copyWith({
    String? studentId,
    ({String value, String error})? email,
    ({String value, String error})? firstName,
    ({String value, String error})? lastName,
    ({int value, String error})? age,
    ({int value, String error})? grade,
  }) =>
      AddStudentInitial(
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        age: age ?? this.age,
        grade: grade ?? this.grade,
      );

  Student toStudent(String studentId) {
    if (!isValid) {
      throw Exception('Student data is not valid');
    }
    return Student(
      id: studentId,
      email: email.value,
      firstName: firstName.value,
      lastName: lastName.value,
      age: age.value,
      grade: grade.value,
    );
  }

  @override
  List<Object?> get props => [
        email,
        firstName,
        lastName,
        age,
        grade,
      ];
}

class AddStudentLoading extends AddStudentState {
  const AddStudentLoading();

  @override
  List<Object?> get props => [];
}

class AddStudentSuccess extends AddStudentState {
  const AddStudentSuccess({
    required this.studentId,
  });

  final String studentId;

  @override
  List<Object?> get props => [studentId];
}

class AddStudentError extends AddStudentState {
  const AddStudentError({this.error});

  final Object? error;

  @override
  List<Object?> get props => [error];
}
