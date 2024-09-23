import 'package:class_cloud/core/data/coaches/models/coach.dart';
import 'package:class_cloud/core/data/students/models/student.dart';
import 'package:class_cloud/core/utils/json_converters.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

enum DayOfWeek {
  @JsonValue("monday")
  monday,
  @JsonValue("tuesday")
  tuesday,
  @JsonValue("wednesday")
  wednesday,
  @JsonValue("thursday")
  thursday,
  @JsonValue("friday")
  friday,
  @JsonValue("saturday")
  saturday,
  @JsonValue("sunday")
  sunday;
}

enum CourseColor {
  @JsonValue("red")
  red,
  @JsonValue("blue")
  blue,
  @JsonValue("green")
  green;

  Color get color {
    switch (this) {
      case CourseColor.red:
        return Colors.red;
      case CourseColor.blue:
        return Colors.blue;
      case CourseColor.green:
        return Colors.green;
    }
  }
}

@JsonSerializable(explicitToJson: true)
class Course extends Equatable {
  const Course({
    required this.id,
    required this.dayOfWeek,
    required this.timeOfDay,
    required this.courseColor,
    required this.school,
    this.coaches = const [],
    this.students = const [],
  });

  final String? id;
  final DayOfWeek? dayOfWeek;
  @TimeOfDayConverter()
  final TimeOfDay? timeOfDay;
  final CourseColor? courseColor;
  final List<Coach> coaches;
  final List<Student> students;
  final String school;

  bool get isComplete {
    return id != null &&
        dayOfWeek != null &&
        timeOfDay != null &&
        courseColor != null &&
        school.isNotEmpty &&
        coaches.isNotEmpty &&
        students.isNotEmpty;
  }

  @override
  List<Object?> get props => [
        id,
        dayOfWeek,
        timeOfDay,
        courseColor,
        coaches,
        students,
        school,
      ];

  Map<String, Object?> get toTableData {
    return {
      'Id': id,
      'Day': dayOfWeek?.name,
      'Time': timeOfDay,
      'Color': courseColor,
      'School': school,
    };
  }

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);
}

extension TimeOfDayX on TimeOfDay? {
  String get prettyTime {
    if (this?.hour != null && this?.minute != null) {
      return DateFormat.jm()
          .format(DateTime(0, 0, 0, this!.hour, this!.minute));
    }
    return '';
  }
}
