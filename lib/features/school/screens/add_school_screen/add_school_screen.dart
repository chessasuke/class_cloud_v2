import 'package:class_cloud/common/constants/app_colors.dart';
import 'package:class_cloud/common/constants/display_properties.dart';
import 'package:class_cloud/common/extensions/string_extensions.dart';
import 'package:class_cloud/common/widgets/custom_app_bar.dart';
import 'package:class_cloud/core/data/school/models/course.dart';
import 'package:class_cloud/core/design_system/text_style.dart';
import 'package:class_cloud/core/go_router/go_router_keys.dart';
import 'package:class_cloud/core/widgets/basic_text_field.dart';
import 'package:class_cloud/core/widgets/cta_button/cta_button.dart';
import 'package:class_cloud/features/school/screens/add_school_screen/cubit/add_school_cubit.dart';
import 'package:class_cloud/features/school/screens/add_school_screen/cubit/add_school_state.dart';
import 'package:class_cloud/features/school/screens/add_school_screen/widgets/course_input/cubit/add_course_cubit.dart';
import 'package:class_cloud/features/school/screens/add_school_screen/widgets/course_input/cubit/add_course_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'widgets/course_input/course_input.dart';
part 'widgets/name_input.dart';

class AddSchoolScreen extends StatelessWidget {
  const AddSchoolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'School Data',
        onPressedBack: context.pop,
      ),
      body: SafeArea(
        child: BlocListener<AddCourseCubit, AddCourseState>(
          listener: (context, state) {
            if (state is AddCourseReady) {
              final isAdded =
                  context.read<AddSchoolCubit>().addCourse(state.course);
              context.read<AddCourseCubit>().reset();
              if (isAdded) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Course added'),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Course already exists'),
                  ),
                );
              }
            }
          },
          child: BlocBuilder<AddSchoolCubit, AddSchoolState>(
            builder: (context, state) {
              if (state is AddSchoolInitial) {
                return const _AddSchoolScreenContent();
              }
              if (state is AddSchoolError) {
                return Center(
                  child: Text(
                    'Error fetching School data',
                    style: TextStyles.body01,
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}

class _AddSchoolScreenContent extends StatefulWidget {
  const _AddSchoolScreenContent();

  @override
  State<_AddSchoolScreenContent> createState() =>
      _AddSchoolScreenContentState();
}

class _AddSchoolScreenContentState extends State<_AddSchoolScreenContent> {
  final FocusNode _nameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddSchoolCubit, AddSchoolState>(
      listener: (context, state) {
        if (state is AddSchoolSuccess) {
          context.goNamed(
            GoRouterNames.schoolDetails,
            pathParameters: {'schoolId': state.schoolId},
          );
        }
      },
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomScrollView(
              slivers: [
                const _Spacing(),
                SliverToBoxAdapter(
                    child: Column(
                  children: [
                    _NameInput(
                      focusNode: _nameFocusNode,
                    ),
                    const SizedBox(height: 8),
                    const _CourseInput(),
                    const _Courses(),
                  ],
                )),
                const _Spacing(),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 80.0),
                ),
                const SliverFillRemaining(child: _AddSchoolBtn()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Spacing extends StatelessWidget {
  const _Spacing();

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: SizedBox(height: 16),
    );
  }
}

class _Courses extends StatelessWidget {
  const _Courses();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddSchoolCubit, AddSchoolState, List<Course>>(
      selector: (state) => state is AddSchoolInitial ? state.courses.value : [],
      builder: (context, courses) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: courses.length,
          itemBuilder: (context, index) {
            final course = courses[index];
            return Dismissible(
              background: Container(
                color: Colors.red,
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              key: Key(course.id),
              onDismissed: (direction) {
                context.read<AddSchoolCubit>().deleteCourse(course.id);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  tileColor: course.courseColor.color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  title: Text(course.id.toUpperCase(),
                      style: TextStyles.body01
                          .copyWith(color: AppColors.white100)),
                  subtitle: Text(
                      '${course.dayOfWeek.name.toUpperCase()} - ${course.timeOfDay.prettyTime}',
                      style: TextStyles.body02
                          .copyWith(color: AppColors.white100)),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _AddSchoolBtn extends StatelessWidget {
  const _AddSchoolBtn();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddSchoolCubit, AddSchoolState, bool>(
      selector: (state) {
        if (state is AddSchoolInitial) {
          return state.isReadyForId;
        }
        return false;
      },
      builder: (context, isEnable) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 8.0,
              left: 8.0,
              right: 8.0,
            ),
            child: CtaButton(
              text: 'Add School',
              onPressed: isEnable
                  ? () async => context.read<AddSchoolCubit>().addSchool()
                  : null,
            ),
          ),
        );
      },
    );
  }
}
