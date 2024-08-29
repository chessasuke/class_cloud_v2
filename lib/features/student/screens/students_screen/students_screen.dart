import 'package:class_cloud/common/widgets/cairdio_search_bar.dart';
import 'package:class_cloud/common/widgets/custom_app_bar.dart';
import 'package:class_cloud/core/design_system/text_style.dart';
import 'package:class_cloud/features/student/screens/students_screen/cubit/student_list_cubit.dart';
import 'package:class_cloud/features/student/screens/students_screen/cubit/student_list_state.dart';
import 'package:class_cloud/features/student/screens/students_screen/widgets/student_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Studentes',
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () => context.read<StudentListCubit>().fetchAllStudentes(),
        child: const _Content(),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentListCubit, StudentListState>(
      builder: (context, state) {
        if (state is StudentListLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is StudentListError) {
          return Center(
            child: Text(state.message, style: TextStyles.body01),
          );
        } else if (state is StudentListLoaded) {
          if (state.studentes.isEmpty) {
            return Center(
              child: Text(
                'No Studentes Found',
                style: TextStyles.body01,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                AppSearchBar(
                  labelText: 'Search Email or Name',
                  onChanged: (value) =>
                      context.read<StudentListCubit>().filterStudents(value),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.studentes.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: StudentTile(student: state.studentes[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
