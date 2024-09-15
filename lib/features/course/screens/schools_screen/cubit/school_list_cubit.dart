import 'package:class_cloud/core/data/school/repository/schools_repository.dart';
import 'package:class_cloud/features/school/screens/schools_screen/cubit/school_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SchoolListCubit extends Cubit<SchoolListState> {
  SchoolListCubit({
    required this.schoolsRepository,
  }) : super(const SchoolListInitial());

  final SchoolsRepository schoolsRepository;

  Future<void> fetchAllSchools() async {
    final schools = await schoolsRepository.fetchSchools();

    if (schools == null) {
      emit(const SchoolListError('Failed to fetch Schools'));
      return;
    }
    emit(SchoolListLoaded(schools: schools));
  }

  void filterSchools(String filter) {
    final currentState = state;
    if (currentState is! SchoolListLoaded) return;
    emit(currentState.copyWith(filter: filter));

  }
}
