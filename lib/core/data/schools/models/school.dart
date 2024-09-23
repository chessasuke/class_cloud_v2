import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'school.g.dart';

@JsonSerializable()
class School extends Equatable {
  const School({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  @override
  List<Object> get props => [
        id,
        name,
      ];

  Map<String, Object> get toTableData {
    return {
      'id': id,
      'Name': name,

    };
  }

  factory School.fromJson(Map<String, dynamic> json) =>
      _$SchoolFromJson(json);

  Map<String, dynamic> toJson() => _$SchoolToJson(this);
}
