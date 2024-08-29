import 'package:class_cloud/common/widgets/custom_app_bar.dart';
import 'package:class_cloud/core/design_system/text_style.dart';
import 'package:class_cloud/core/go_router/go_router_keys.dart';
import 'package:class_cloud/core/widgets/basic_text_field.dart';
import 'package:class_cloud/core/widgets/cta_button/cta_button.dart';
import 'package:class_cloud/features/student/screens/add_student_screen/cubit/add_student_cubit.dart';
import 'package:class_cloud/features/student/screens/add_student_screen/cubit/add_student_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'widgets/email_input.dart';
part 'widgets/first_name_input.dart';
part 'widgets/last_name_input.dart';

class AddStudentScreen extends StatelessWidget {
  const AddStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Student Data'),
      body: BlocBuilder<AddStudentCubit, AddStudentState>(
        builder: (context, state) {
          if (state is AddStudentInitial) {
            return const _AddStudentScreenContent();
          }
          if (state is AddStudentError) {
            return Center(
              child: Text(
                'Error fetching Student data',
                style: TextStyles.body01,
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class _AddStudentScreenContent extends StatefulWidget {
  const _AddStudentScreenContent();

  @override
  State<_AddStudentScreenContent> createState() => _AddStudentScreenContentState();
}

class _AddStudentScreenContentState extends State<_AddStudentScreenContent> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddStudentCubit, AddStudentState>(
      listener: (context, state) {
        if (state is AddStudentSuccess) {
          context.goNamed(
            GoRouterNames.studentDetails,
            pathParameters: {'studentId': state.studentId},
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
                  child: _EmailInput(
                    focusNode: _emailFocusNode,
                    nextFocusNode: _firstNameFocusNode,
                  ),
                ),
                const _Spacing(),
                SliverToBoxAdapter(
                  child: _FirstNameInput(
                    focusNode: _firstNameFocusNode,
                    nextFocusNode: _lastNameFocusNode,
                  ),
                ),
                const _Spacing(),
                SliverToBoxAdapter(
                  child: _LastNameInput(
                    focusNode: _lastNameFocusNode,
                  ),
                ),
                const _Spacing(),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 80.0),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 8.0,
                left: 8.0,
                right: 8.0,
              ),
              child: CtaButton(
                text: 'Add Student',
                onPressed: () async => context.read<AddStudentCubit>().addStudent(),
              ),
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
