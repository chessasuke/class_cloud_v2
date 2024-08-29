import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'student.g.dart';

@JsonSerializable()
class Student extends Equatable {
  const Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.age,
    required this.grade,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final int age;
  final int grade;

  @override
  List<Object> get props => [
        id,
        firstName,
        lastName,
        email,
        age,
        grade,
      ];

  Map<String, Object> get toTableData {
    return {
      'id': id,
      'Name': '$firstName $lastName',
      'Email': email,
      'Age': age,
      'Grade': grade,
    };
  }

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);

  Map<String, dynamic> toJson() => _$StudentToJson(this);
}
