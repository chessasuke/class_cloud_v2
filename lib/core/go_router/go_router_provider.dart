import 'package:class_cloud/core/data/auth/repository/auth_repository.dart';
import 'package:class_cloud/core/error/error_screen/error_screen.dart';
import 'package:class_cloud/core/go_router/go_router_config.dart';
import 'package:class_cloud/core/go_router/go_router_keys.dart';
import 'package:class_cloud/core/go_router/go_router_routes.dart';
import 'package:class_cloud/core/services/logger_service.dart/logger_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  // Register triggers for [refreshListenable]
  final refreshRouterStreamProvider =
      ref.watch(routerRefreshListenableProvider).refreshStream;

  ref.watch(authRepository).authChanges.distinct().listen((user) {
    Logger(LoggerConstants.user).info('Auth changes: $user');
    return refreshRouterStreamProvider.add(const GoRouterRefreshAuthEvent());
  });

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    errorBuilder: (context, state) => const ErrorScreen(),
    refreshListenable: ref.read(routerRefreshListenableProvider),
    redirect: (context, state) async {
      String? route;

      /// Redirection conditions
      final isLoggedIn =
          (await ref.watch(authRepository).authChanges.first) != null;

      if (!isLoggedIn) {
        route = GoRouterPath.signIn;
      }

      return route;
    },
    routes: getGoRouterRoutes(ref),
  );
});
