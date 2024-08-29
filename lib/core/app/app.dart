
import 'package:class_cloud/core/app/cubits/user_cubit/user_cubit.dart';
import 'package:class_cloud/core/data/auth/repository/auth_repository.dart';
import 'package:class_cloud/core/data/feature_flags/cubit/feature_flag_cubit.dart';
import 'package:class_cloud/core/data/feature_flags/repository/feature_repository_impl.dart';
import 'package:class_cloud/core/data/user/repository/user_repository.dart';
import 'package:class_cloud/core/go_router/go_router_keys.dart';
import 'package:class_cloud/core/go_router/go_router_provider.dart';
import 'package:class_cloud/core/services/logger_service.dart/logger_service.dart';
import 'package:class_cloud/features/logs/cubit/logs_cubit.dart';
import 'package:class_cloud/features/shake_detector/shake_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class App extends ConsumerWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(userRepository);
    ref.read(loggerService).init();

    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(
          lazy: false,
          create: (context) {
            return UserCubit(
              authRepository: ref.read(authRepository),
              userRepository: ref.read(userRepository),
            )..listenUserChanges();
          },
        ),
        BlocProvider<FeatureFlagCubit>(
          create: (context) => FeatureFlagCubit(
            featureRepository: ref.read(featuresRepository),
          )..init(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) =>
              LogsCubit(loggerService: ref.read(loggerService))..init(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: ref.read(goRouterProvider),
        supportedLocales: const [
          Locale('en', 'US'),
        ],
        builder: (context, widget) {
          return ShakeDetector(
            child: widget!,
            onShake: () {
              final currentContext = rootNavigatorKey.currentState?.context;
              if (currentContext != null) {
                currentContext.pushNamed(GoRouterNames.logs);
              }
            },
          );
        },
      ),
    );
  }
}
