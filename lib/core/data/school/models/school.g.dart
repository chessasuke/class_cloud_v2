// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

School _$SchoolFromJson(Map<String, dynamic> json) => School(
      id: json['id'] as String?,
      name: json['name'] as String?,
      courses: (json['courses'] as List<dynamic>?)
          ?.map((e) => Course.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SchoolToJson(School instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'courses': instance.courses?.map((e) => e.toJson()).toList(),
    };

SchoolWithoutCourses _$SchoolWithoutCoursesFromJson(
        Map<String, dynamic> json) =>
    SchoolWithoutCourses(
      id: json['id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$SchoolWithoutCoursesToJson(
        SchoolWithoutCourses instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
