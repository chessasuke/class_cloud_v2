import 'package:class_cloud/core/data/user/repository/user_repository.dart';
import 'package:class_cloud/features/coach/screens/add_coach_screen/data/repository/add_coach_repository.dart';
import 'package:class_cloud/features/coach/screens/add_coach_screen/providers/cubit/add_coach_state.dart';
import 'package:class_cloud/features/coach/screens/add_coach_screen/providers/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCoachCubit extends Cubit<AddCoachState> {
  AddCoachCubit({
    required this.addCoachRepository,
    required this.userRepository,
  }) : super(const AddCoachInitial());

  late final AddCoachRepository addCoachRepository;
  late final UserRepository userRepository;

  void updateEmail(String email) {
    final currentState = state;
    if (currentState is! AddCoachInitial) return;
    emit(currentState.copyWith(email: (value: email, error: '')));
  }

  void updateFirstName(String firstName) {
    final currentState = state;
    if (currentState is! AddCoachInitial) return;
    emit(currentState.copyWith(firstName: (value: firstName, error: '')));
  }

  void updateLastName(String lastName) {
    final currentState = state;
    if (currentState is! AddCoachInitial) return;
    emit(currentState.copyWith(lastName: (value: lastName, error: '')));
  }

  Future<void> addCoach() async {
    final coachToAdd = state;
    if (coachToAdd is! AddCoachInitial) return;
    emit(const AddCoachLoading());

    // Validate Coach info
    final validatedCoachInfo = AddCoachUtils.isCoachInfoValid(coachToAdd);
    // If Coach info is not valid, return the updated state with the collected errors
    if (!validatedCoachInfo.isValid) {
      emit(validatedCoachInfo);
      return;
    }
    final coachId = addCoachRepository.generateCoachId;

    if (coachId.isEmpty) {
      emit(const AddCoachError(error: 'Failed to generate Coach ID'));
      return;
    }
    final coach = coachToAdd.toCoach(coachId);
    // If Coach info is valid, upload the Coach info
    try {
      await addCoachRepository.addCoach(coach: coach);
      emit(AddCoachSuccess(coachId: coachId));
    } catch (e) {
      emit(const AddCoachError(error: 'Failed to add Coach'));
    }
  }
}
