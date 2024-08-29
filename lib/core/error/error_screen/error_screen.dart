import 'package:class_cloud/core/design_system/text_style.dart';
import 'package:class_cloud/core/go_router/go_router_keys.dart';
import 'package:class_cloud/core/widgets/cta_button/cta_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ErrorScreen extends ConsumerWidget {
  const ErrorScreen({
    this.error = 'Unexpected error, try again later',
    super.key,
  });

  final String? error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Error',
            style: TextStyles.heading03.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 42),
          const SizedBox(height: 42),
          CtaButton(
            text: 'Go Home',
            onPressed: () => context.goNamed(GoRouterNames.home),
          ),
        ],
      ),
    );
  }
}
