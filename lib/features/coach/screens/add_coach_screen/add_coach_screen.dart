import 'package:class_cloud/common/widgets/custom_app_bar.dart';
import 'package:class_cloud/core/design_system/text_style.dart';
import 'package:class_cloud/core/go_router/go_router_keys.dart';
import 'package:class_cloud/core/widgets/basic_text_field.dart';
import 'package:class_cloud/core/widgets/cta_button/cta_button.dart';
import 'package:class_cloud/features/coach/screens/add_coach_screen/providers/cubit/add_coach_cubit.dart';
import 'package:class_cloud/features/coach/screens/add_coach_screen/providers/cubit/add_coach_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'widgets/email_input.dart';
part 'widgets/first_name_input.dart';
part 'widgets/last_name_input.dart';

class AddCoachScreen extends StatelessWidget {
  const AddCoachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Coach Data'),
      body: BlocBuilder<AddCoachCubit, AddCoachState>(
        builder: (context, state) {
          if (state is AddCoachInitial) {
            return const _AddCoachScreenContent();
          }
          if (state is AddCoachError) {
            return Center(
              child: Text(
                'Error fetching Coach data',
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

class _AddCoachScreenContent extends StatefulWidget {
  const _AddCoachScreenContent();

  @override
  State<_AddCoachScreenContent> createState() => _AddCoachScreenContentState();
}

class _AddCoachScreenContentState extends State<_AddCoachScreenContent> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddCoachCubit, AddCoachState>(
      listener: (context, state) {
        if (state is AddCoachSuccess) {
          context.goNamed(
            GoRouterNames.coachDetails,
            pathParameters: {'coachId': state.coachId},
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
                text: 'Add Coach',
                onPressed: () async => context.read<AddCoachCubit>().addCoach(),
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
