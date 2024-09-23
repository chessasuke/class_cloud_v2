import 'package:class_cloud/core/design_system/text_style.dart';
import 'package:class_cloud/core/go_router/go_router_keys.dart';
import 'package:class_cloud/features/course/screens/select_school_screen/cubit/select_school_cubit.dart';
import 'package:class_cloud/features/course/screens/select_school_screen/cubit/select_school_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SelectSchoolScreen extends StatelessWidget {
  const SelectSchoolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select School'),
      ),
      body: BlocBuilder<SelectSchoolCubit, SelectSchoolState>(
        builder: (context, state) {
          if (state is SelectSchoolLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SelectSchoolSuccess) {
            return GridView.count(
              crossAxisCount: 2,
              children: [
                for (final school in state.schools)
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(
                        GoRouterNames.addCourse,
                        pathParameters: {
                          'schoolId': school.name,
                        },
                      );
                    },
                    child: Card(
                      elevation: 8,
                      child: Center(
                        child: Text(
                          school.name,
                          style: TextStyles.heading03,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          }
          if (state is SelectSchoolError) {
            return const Center(
              child: Text(
                'Error fetching schools',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
