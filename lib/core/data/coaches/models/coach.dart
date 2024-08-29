import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'coach.g.dart';

@JsonSerializable()
class Coach extends Equatable {
  const Coach({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String email;

  @override
  List<Object> get props => [
        id,
        firstName,
        lastName,
        email,
      ];

  Map<String, Object> get tableData {
    return {
      'Id': id,
      'Name': '$firstName $lastName',
      'Email': email,
    };
  }

  factory Coach.fromJson(Map<String, dynamic> json) => _$CoachFromJson(json);

  Map<String, dynamic> toJson() => _$CoachToJson(this);
}
