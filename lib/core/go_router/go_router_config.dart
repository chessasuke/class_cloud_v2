import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

final routerRefreshListenableProvider =
    Provider<RouterListenable>((ref) => RouterListenable());

class RouterListenable extends ChangeNotifier {
  RouterListenable() {
    subscription = refreshStream.asBroadcastStream().listen((_) {
      notifyListeners();
    });
  }

  final refreshStream = BehaviorSubject<GoRouterRefreshEvent>();
  late final StreamSubscription<GoRouterRefreshEvent>? subscription;

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }
}

abstract class GoRouterRefreshEvent extends Equatable {
  const GoRouterRefreshEvent();
  @override
  List<Object> get props => [];
}

class GoRouterRefreshAuthEvent extends GoRouterRefreshEvent {
  const GoRouterRefreshAuthEvent();
}

class GoRouterRefreshMessageEvent extends GoRouterRefreshEvent {
  const GoRouterRefreshMessageEvent();
}
