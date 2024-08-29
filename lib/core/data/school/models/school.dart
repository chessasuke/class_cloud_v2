import 'package:class_cloud/core/data/school/models/course.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'school.g.dart';

@JsonSerializable(explicitToJson: true)
class School extends Equatable {
  const School({
    required this.id,
    required this.name,
    required this.courses,
  });

  final String id;
  final String name;
  final List<Course> courses;

  bool get isValid {
    return id.isNotEmpty && name.isNotEmpty && courses.isNotEmpty;
  }

  Map<String, Object> get toTableData {
    return {
      'Id': id,
      'Name': name,
      'Courses': courses.map((e) => e.id).toList(),
    };
  }

  String get prettyCourses => courses.map((e) => e.id).join(', ');

  @override
  List<Object> get props => [
        id,
        name,
        courses,
      ];

  SchoolWithoutCourses toSchoolWithoutCourses() {
    return SchoolWithoutCourses(
      id: id,
      name: name,
    );
  }

  factory School.fromJson(Map<String, dynamic> json) => _$SchoolFromJson(json);

  Map<String, dynamic> toJson() => _$SchoolToJson(this);
}

@JsonSerializable()
class SchoolWithoutCourses extends Equatable {
  const SchoolWithoutCourses({
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

  factory SchoolWithoutCourses.fromJson(Map<String, dynamic> json) => _$SchoolWithoutCoursesFromJson(json);

  Map<String, dynamic> toJson() => _$SchoolWithoutCoursesToJson(this);
}
