// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      id: json['id'] as String,
      dayOfWeek: $enumDecode(_$DayOfWeekEnumMap, json['dayOfWeek']),
      timeOfDay:
          const TimeOfDayConverter().fromJson(json['timeOfDay'] as String),
      courseColor: $enumDecode(_$CourseColorEnumMap, json['courseColor']),
      coaches: (json['coaches'] as List<dynamic>)
          .map((e) => Coach.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'id': instance.id,
      'dayOfWeek': _$DayOfWeekEnumMap[instance.dayOfWeek]!,
      'timeOfDay': const TimeOfDayConverter().toJson(instance.timeOfDay),
      'courseColor': _$CourseColorEnumMap[instance.courseColor]!,
      'coaches': instance.coaches.map((e) => e.toJson()).toList(),
    };

const _$DayOfWeekEnumMap = {
  DayOfWeek.monday: 'monday',
  DayOfWeek.tuesday: 'tuesday',
  DayOfWeek.wednesday: 'wednesday',
  DayOfWeek.thursday: 'thursday',
  DayOfWeek.friday: 'friday',
  DayOfWeek.saturday: 'saturday',
  DayOfWeek.sunday: 'sunday',
};

const _$CourseColorEnumMap = {
  CourseColor.red: 'red',
  CourseColor.blue: 'blue',
  CourseColor.green: 'green',
};
