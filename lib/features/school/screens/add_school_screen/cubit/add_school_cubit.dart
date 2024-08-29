import 'package:class_cloud/core/data/school/models/course.dart';
import 'package:class_cloud/core/data/user/repository/user_repository.dart';
import 'package:class_cloud/features/school/screens/add_school_screen/cubit/add_school_state.dart';
import 'package:class_cloud/features/school/screens/add_school_screen/data/repository/add_school_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddSchoolCubit extends Cubit<AddSchoolState> {
  AddSchoolCubit({
    required this.addSchoolRepository,
    required this.userRepository,
  }) : super(const AddSchoolInitial());

  late final AddSchoolRepository addSchoolRepository;
  late final UserRepository userRepository;

  void updateName(String name) {
    final currentState = state;
    if (currentState is! AddSchoolInitial) return;
    emit(currentState.copyWith(name: (value: name, error: '')));
  }

  bool addCourse(Course newCourse) {
    final currentState = state;
    if (currentState is! AddSchoolInitial) return false;

    if (currentState.courses.value.contains(newCourse)) {
      emit(currentState.copyWith(courses: (
        value: currentState.courses.value,
        error: 'Course already exists'
      )));
      return false;
    }

    final courses = [...currentState.courses.value, newCourse];
    emit(currentState.copyWith(courses: (value: courses, error: '')));
    return true;
  }

  void deleteCourse(String id) {
    final currentState = state;
    if (currentState is! AddSchoolInitial) return;
    final courses = <Course>[];
    for (var course in currentState.courses.value) {
      if (course.id == id) {
        continue;
      } else {
        courses.add(course);
      }
    }
    emit(currentState.copyWith(courses: (value: courses, error: '')));
  }

  Future<void> addSchool() async {
    final schoolToAdd = state;
    if (schoolToAdd is! AddSchoolInitial) return;
    emit(const AddSchoolLoading());

    /// Generate School ID and add it
    final schoolId = addSchoolRepository.generateSchoolId;
    if (schoolId.isEmpty) {
      emit(const AddSchoolError(error: 'Failed to generate School ID'));
      return;
    }
    final schoolWithId = schoolToAdd.copyWith(id: (value: schoolId, error: ''));
    //// Convert School data to School object and validate it
    final school = schoolWithId.toSchool;
    if (school == null) {
      emit(const AddSchoolError(error: 'Invalid School data'));
      return;
    }

    // If school info is valid, upload the School info
    try {
      await addSchoolRepository.addSchool(school: school);
      emit(AddSchoolSuccess(schoolId: schoolId));
    } catch (e) {
      emit(const AddSchoolError(error: 'Failed to add School'));
    }
  }
}
