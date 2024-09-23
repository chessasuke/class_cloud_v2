import 'package:class_cloud/core/data/schools/repository/school_repository.dart';
import 'package:class_cloud/features/course/screens/select_school_screen/cubit/select_school_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectSchoolCubit extends Cubit<SelectSchoolState> {
  SelectSchoolCubit({
    required this.schoolRepository,
  }) : super(SelectSchoolLoading());

  final SchoolRepository schoolRepository;

  Future<void> fetchSchools() async {
    emit(SelectSchoolLoading());

    final schools = await schoolRepository.fetchSchools();

    if (schools == null) {
      emit(const SelectSchoolError());
      return;
    } else {
      emit(SelectSchoolSuccess(schools: schools));
    }
  }
}
