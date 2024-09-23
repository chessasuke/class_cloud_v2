import 'package:class_cloud/core/app/cubits/user_cubit/user_cubit.dart';
import 'package:class_cloud/core/go_router/go_router_keys.dart';
import 'package:class_cloud/core/widgets/cta_button/cta_button.dart';
import 'package:class_cloud/core/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// The first screen in the bottom navigation bar.
class HomeScreen extends StatelessWidget {
  /// Constructs a [HomeScreen] widget.
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      // appBar: AppBar(),
      content: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 8),
            CtaButton(
              text: 'Coaches',
              onPressed: () async {
                context.goNamed(GoRouterNames.coaches);
              },
            ),
            const SizedBox(height: 8),
            CtaButton(
              text: 'Students',
              onPressed: () async {
                context.goNamed(GoRouterNames.students);
              },
            ),
            const SizedBox(height: 8),
            CtaButton(
              text: 'Courses',
              onPressed: () async {
                context.goNamed(GoRouterNames.courses);
              },
            ),
            const SizedBox(height: 8),
            CtaButton(
              text: 'Sign Out',
              onPressed: () async {
                await context.read<UserCubit>().logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
