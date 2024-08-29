
import 'package:class_cloud/common/constants/app_colors.dart';
import 'package:class_cloud/common/widgets/consecutive_taps_detector.dart';
import 'package:class_cloud/core/go_router/go_router_keys.dart';
import 'package:class_cloud/core/services/environment_service/environment_service.dart';
import 'package:class_cloud/core/services/package_info_service/package_info_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AppVersion extends ConsumerWidget {
  const AppVersion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final env = ref.watch(environmentService);
    final packageInfo = ref.watch(packageInfoService);

    return ConsecutiveTapsDetector(
      onTarget: () {
        // context.pushNamed(GoRouterNames.featureSwitcher);
      },
      child: Text(
        getVerionAndBuildNumber(packageInfo, env),
        style: const TextStyle(
          color: AppColors.primaryColor,
          decoration: TextDecoration.underline,
          fontSize: 13,
        ),
      ),
    );
  }

  String getVerionAndBuildNumber(
    CairdioPackageInfo packageInfo,
    Environment env,
  ) {
    final append = env.environmentType == EnvironmentType.dev
        ? '- [${env.environmentType.name}]'
        : '';
    return 'Version ${packageInfo.version} - Build ${packageInfo.buildNumber} $append';
  }
}