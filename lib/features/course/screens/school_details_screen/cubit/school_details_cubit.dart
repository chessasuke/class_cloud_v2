import 'package:class_cloud/core/data/school/models/school.dart';
import 'package:class_cloud/core/services/logger_service.dart/logger_constants.dart';
import 'package:class_cloud/features/school/screens/school_details_screen/cubit/school_details_state.dart';
import 'package:class_cloud/features/school/screens/school_details_screen/data/repository/school_details_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

class SchoolDetailsCubit extends Cubit<SchoolDetailsState> {
  SchoolDetailsCubit({
    required this.schoolRepository,
  }) : super(const SchoolDetailsInitial());

  late final SchoolDetailsRepository schoolRepository;

  Future<void> fetchSchool({
    School? school,
    String? schoolId,
  }) async {
    assert(
      school != null || schoolId != null,
      'School or schoolId required',
    );
    if (school != null) {
      emit(SchoolDetailsLoaded(school));
      return;
    }
    if (schoolId != null) {
      emit(const SchoolDetailsLoading());
      try {
        final school =
            await schoolRepository.fetchSchoolById(schoolId: schoolId);
        if (school != null) {
          emit(SchoolDetailsLoaded(school));
          return;
        }
        emit(const SchoolDetailsError('School not found'));
        return;
      } catch (e, _) {
        Logger(LoggerConstants.school)
            .log(Level.SEVERE, 'Error fetching School: $e');
        emit(SchoolDetailsError(e));
      }
    }
  }
}
