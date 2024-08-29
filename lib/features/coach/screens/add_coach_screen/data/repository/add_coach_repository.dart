import 'package:class_cloud/core/data/coaches/models/coach.dart';
import 'package:class_cloud/features/coach/screens/add_coach_screen/data/source/add_coach_data_source.dart';

abstract class AddCoachRepository {
  abstract final AddCoachDataSource remoteDataSource;

  Future<void> addCoach({required Coach coach});

  String get generateCoachId;
}
