// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      id: json['id'] as String?,
      dayOfWeek: $enumDecodeNullable(_$DayOfWeekEnumMap, json['dayOfWeek']),
      timeOfDay: _$JsonConverterFromJson<String, TimeOfDay>(
          json['timeOfDay'], const TimeOfDayConverter().fromJson),
      courseColor:
          $enumDecodeNullable(_$CourseColorEnumMap, json['courseColor']),
      coaches: (json['coaches'] as List<dynamic>?)
              ?.map((e) => Coach.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'id': instance.id,
      'dayOfWeek': _$DayOfWeekEnumMap[instance.dayOfWeek],
      'timeOfDay': _$JsonConverterToJson<String, TimeOfDay>(
          instance.timeOfDay, const TimeOfDayConverter().toJson),
      'courseColor': _$CourseColorEnumMap[instance.courseColor],
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

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

const _$CourseColorEnumMap = {
  CourseColor.red: 'red',
  CourseColor.blue: 'blue',
  CourseColor.green: 'green',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
