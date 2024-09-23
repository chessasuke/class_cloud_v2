import 'package:class_cloud/common/widgets/cairdio_search_bar.dart';
import 'package:class_cloud/common/widgets/custom_app_bar.dart';
import 'package:class_cloud/core/design_system/text_style.dart';
import 'package:class_cloud/core/go_router/go_router_keys.dart';
import 'package:class_cloud/features/course/screens/courses_screen/cubit/course_list_cubit.dart';
import 'package:class_cloud/features/course/screens/courses_screen/cubit/course_list_state.dart';
import 'package:class_cloud/features/course/screens/courses_screen/widgets/course_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Courses',
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.pushNamed(
                GoRouterNames.selectSchool,
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => context.read<CourseListCubit>().fetchAllCourses(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppSearchBar(
                  labelText: 'Search Name',
                  onChanged: (value) =>
                      context.read<CourseListCubit>().filterCourses(value),
                ),
                const Flexible(child: _Content()),
                const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseListCubit, CourseListState>(
      builder: (context, state) {
        if (state is CourseListLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CourseListError) {
          return Center(
            child: Text(state.message, style: TextStyles.body01),
          );
        } else if (state is CourseListLoaded) {
          if (state.courses.isEmpty) {
            return Center(
              child: Text(
                'No Courses Found',
                style: TextStyles.body01,
              ),
            );
          }
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      if (state.filter.isNotEmpty)
                        for (final course in state.courses
                            .where(
                              (course) => (course.id!
                                  .toLowerCase()
                                  .startsWith(state.filter.toLowerCase())),
                            )
                            .toList())
                          CourseTile(course: course)
                      else
                        for (final course in state.courses)
                          CourseTile(course: course),
                    ],
                  ),
                ),
              )
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
