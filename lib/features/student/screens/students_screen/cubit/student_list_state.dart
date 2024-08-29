import 'package:class_cloud/core/data/students/models/student.dart';
import 'package:equatable/equatable.dart';

sealed class StudentListState extends Equatable {
  const StudentListState();

  @override
  List<Object> get props => [];
}

class StudentListInitial extends StudentListState {
  const StudentListInitial();
}

class StudentListLoading extends StudentListState {
  const StudentListLoading();
}

class StudentListLoaded extends StudentListState {
  const StudentListLoaded(this.studentes);

  final List<Student> studentes;

  @override
  List<Object> get props => [studentes];
}

class StudentListError extends StudentListState {
  const StudentListError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
