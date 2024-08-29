import 'package:class_cloud/core/data/students/models/student.dart';
import 'package:equatable/equatable.dart';

sealed class StudentDetailsState extends Equatable {
  const StudentDetailsState();
}

class StudentDetailsInitial extends StudentDetailsState {
  const StudentDetailsInitial();

  @override
  List<Object?> get props => [];
}

class StudentDetailsLoading extends StudentDetailsState {
  const StudentDetailsLoading();

  @override
  List<Object?> get props => [];
}

class StudentDetailsLoaded extends StudentDetailsState {
  const StudentDetailsLoaded(this.student);

  final Student student;

  @override
  List<Object?> get props => [student];
}

class StudentDetailsError extends StudentDetailsState {
  const StudentDetailsError(this.error);
  final Object error;
  @override
  List<Object?> get props => [error];
}
