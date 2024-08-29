import 'package:class_cloud/core/data/auth/repository/auth_repository.dart';
import 'package:class_cloud/core/data/coaches/models/coach.dart';
import 'package:class_cloud/core/data/coaches/repository/coaches_repository_impl.dart';
import 'package:class_cloud/core/data/school/models/school.dart';
import 'package:class_cloud/core/data/school/repository/schools_repository_impl.dart';
import 'package:class_cloud/core/data/students/models/student.dart';
import 'package:class_cloud/core/data/students/repository/students_repository_impl.dart';
import 'package:class_cloud/core/data/user/repository/user_repository.dart';
import 'package:class_cloud/core/error/error_screen/error_screen.dart';
import 'package:class_cloud/core/go_router/go_router_keys.dart';
import 'package:class_cloud/features/auth/sign_in_screen/cubit/sign_in_cubit.dart';
import 'package:class_cloud/features/auth/sign_in_screen/sign_in_screen.dart';
import 'package:class_cloud/features/coach/screens/add_coach_screen/add_coach_screen.dart';
import 'package:class_cloud/features/coach/screens/add_coach_screen/data/repository/add_coach_repository_impl.dart';
import 'package:class_cloud/features/coach/screens/add_coach_screen/providers/cubit/add_coach_cubit.dart';
import 'package:class_cloud/features/coach/screens/coach_details_screen/coach_details.dart';
import 'package:class_cloud/features/coach/screens/coach_details_screen/cubit/coach_details_cubit.dart';
import 'package:class_cloud/features/coach/screens/coach_details_screen/data/repository/coach_details_repository_impl.dart';
import 'package:class_cloud/features/coach/screens/coaches_screen/coaches_screen.dart';
import 'package:class_cloud/features/coach/screens/coaches_screen/cubit/coach_list_cubit.dart';
import 'package:class_cloud/features/feature_switcher/screens/feature_switcher_screen.dart';
import 'package:class_cloud/features/home/home.dart';
import 'package:class_cloud/features/logs/logs_screen.dart';
import 'package:class_cloud/features/school/screens/add_school_screen/add_school_screen.dart';
import 'package:class_cloud/features/school/screens/add_school_screen/cubit/add_school_cubit.dart';
import 'package:class_cloud/features/school/screens/add_school_screen/data/repository/add_school_repository_impl.dart';
import 'package:class_cloud/features/school/screens/add_school_screen/widgets/course_input/cubit/add_course_cubit.dart';
import 'package:class_cloud/features/school/screens/school_details_screen/cubit/school_details_cubit.dart';
import 'package:class_cloud/features/school/screens/school_details_screen/data/repository/school_details_repository_impl.dart';
import 'package:class_cloud/features/school/screens/school_details_screen/school_details.dart';
import 'package:class_cloud/features/school/screens/schools_screen/cubit/school_list_cubit.dart';
import 'package:class_cloud/features/school/screens/schools_screen/schools_screen.dart';
import 'package:class_cloud/features/student/screens/add_student_screen/add_student_screen.dart';
import 'package:class_cloud/features/student/screens/add_student_screen/cubit/add_student_cubit.dart';
import 'package:class_cloud/features/student/screens/add_student_screen/data/repository/add_student_repository_impl.dart';
import 'package:class_cloud/features/student/screens/student_details_screen/cubit/student_details_cubit.dart';
import 'package:class_cloud/features/student/screens/student_details_screen/data/repository/student_details_repository_impl.dart';
import 'package:class_cloud/features/student/screens/student_details_screen/student_details.dart';
import 'package:class_cloud/features/student/screens/students_screen/cubit/student_list_cubit.dart';
import 'package:class_cloud/features/student/screens/students_screen/students_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

List<RouteBase> getGoRouterRoutes(Ref ref) {
  return [
    // Top Level Routes

    // Sign In
    GoRoute(
      name: GoRouterNames.signIn,
      path: GoRouterPath.signIn,
      builder: (context, state) => BlocProvider(
        create: (context) =>
            SignInCubit(authRepository: ref.read(authRepository)),
        child: const SignIn(),
      ),
    ),

    // Error
    GoRoute(
      name: GoRouterNames.error,
      path: GoRouterPath.error,
      builder: (context, state) => const ErrorScreen(),
    ),

    // Logs
    GoRoute(
      name: GoRouterNames.logs,
      path: GoRouterPath.logs,
      builder: (context, state) => const LogsScreen(),
    ),

    // Home
    GoRoute(
      name: GoRouterNames.home,
      path: GoRouterPath.home,
      builder: (context, state) => const HomeScreen(),
      routes: [
        // Feature Switcher Routes
        GoRoute(
          name: GoRouterNames.featureSwitcher,
          path: GoRouterPath.featureSwitcher,
          builder: (context, state) => const FeatureSwitcherScreen(),
        ),
        GoRoute(
            name: GoRouterNames.coaches,
            path: GoRouterPath.coaches,
            builder: (context, state) => BlocProvider(
                  create: (context) => CoachListCubit(
                    coachesRepository: ref.read(coachesRepository),
                  )..fetchAllCoaches(),
                  child: const CoachesScreen(),
                ),
            routes: [
              GoRoute(
                name: GoRouterNames.coachDetails,
                path: GoRouterPath.coachDetails,
                builder: (context, state) {
                  final coach = (state.pathParameters)['coach'] as Coach?;
                  final coachId = (state.pathParameters)['coachId'];
                  return BlocProvider<CoachDetailsCubit>(
                    create: (context) => CoachDetailsCubit(
                        coachRepository: ref.read(coachDetailsRepository))
                      ..fetchCoach(
                        coachId: coachId,
                        coach: coach,
                      ),
                    child: CoachDetailsScreen(coachId: coachId ?? ''),
                  );
                },
              ),
            ]),
        GoRoute(
          name: GoRouterNames.addCoach,
          path: GoRouterPath.addCoach,
          builder: (context, state) => BlocProvider(
            create: (context) => AddCoachCubit(
                addCoachRepository: ref.read(addCoachRepository),
                userRepository: ref.read(userRepository)),
            child: const AddCoachScreen(),
          ),
        ),
        GoRoute(
            name: GoRouterNames.students,
            path: GoRouterPath.students,
            builder: (context, state) => BlocProvider(
                  create: (context) => StudentListCubit(
                    studentesRepository: ref.read(studentsRepository),
                  )..fetchAllStudentes(),
                  child: const StudentsScreen(),
                ),
            routes: [
              GoRoute(
                name: GoRouterNames.studentDetails,
                path: GoRouterPath.studentDetails,
                builder: (context, state) {
                  final student = (state.pathParameters)['student'] as Student?;
                  final studentId = (state.pathParameters)['studentId'];
                  return BlocProvider<StudentDetailsCubit>(
                    create: (context) => StudentDetailsCubit(
                        studentRepository: ref.read(studentDetailsRepository))
                      ..fetchStudent(
                        studentId: studentId,
                        student: student,
                      ),
                    child: StudentDetailsScreen(studentId: studentId ?? ''),
                  );
                },
              ),
            ]),
        GoRoute(
          name: GoRouterNames.addStudent,
          path: GoRouterPath.addStudent,
          builder: (context, state) => BlocProvider(
            create: (context) => AddStudentCubit(
                addStudentRepository: ref.read(addStudentRepository),
                userRepository: ref.read(userRepository)),
            child: const AddStudentScreen(),
          ),
        ),
        GoRoute(
            name: GoRouterNames.schools,
            path: GoRouterPath.schools,
            builder: (context, state) => BlocProvider(
                  create: (context) => SchoolListCubit(
                    schoolsRepository: ref.read(schoolsRepository),
                  )..fetchAllSchools(),
                  child: const SchoolsScreen(),
                ),
            routes: [
              GoRoute(
                name: GoRouterNames.schoolDetails,
                path: GoRouterPath.schoolDetails,
                builder: (context, state) {
                  final school = (state.pathParameters)['school'] as School?;
                  final schoolId = (state.pathParameters)['schoolId'];
                  return BlocProvider<SchoolDetailsCubit>(
                    create: (context) => SchoolDetailsCubit(
                        schoolRepository: ref.read(schoolDetailsRepository))
                      ..fetchSchool(
                        schoolId: schoolId,
                        school: school,
                      ),
                    child: SchoolDetailsScreen(schoolId: schoolId ?? ''),
                  );
                },
              ),
            ]),

        GoRoute(
          name: GoRouterNames.addSchool,
          path: GoRouterPath.addSchool,
          builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AddSchoolCubit(
                    addSchoolRepository: ref.read(addSchoolRepository),
                    userRepository: ref.read(userRepository)),
              ),
              BlocProvider(
                create: (context) => AddCourseCubit(
                    coachesRepository: ref.read(coachesRepository)),
              ),
            ],
            child: const AddSchoolScreen(),
          ),
        ),
      ],
    ),
  ];
}
