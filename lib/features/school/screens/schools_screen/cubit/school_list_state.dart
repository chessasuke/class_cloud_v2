import 'package:class_cloud/core/data/school/models/school.dart';
import 'package:equatable/equatable.dart';

sealed class SchoolListState extends Equatable {
  const SchoolListState();

  @override
  List<Object> get props => [];
}

class SchoolListInitial extends SchoolListState {
  const SchoolListInitial();
}

class SchoolListLoading extends SchoolListState {
  const SchoolListLoading();
}

class SchoolListLoaded extends SchoolListState {
  const SchoolListLoaded({required this.schools, this.filter = ''});

  final List<School> schools;
  final String filter;

  SchoolListLoaded copyWith({
    List<School>? schools,
    String? filter,
  }) {
    return SchoolListLoaded(
      schools: schools ?? this.schools,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object> get props => [schools, filter];
}

class SchoolListError extends SchoolListState {
  const SchoolListError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
