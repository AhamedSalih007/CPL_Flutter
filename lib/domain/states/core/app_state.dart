import 'package:flutter/foundation.dart';

import '../../models/user/user.dart';

@immutable
sealed class AppState {
  const AppState();
}

final class AppStateInitial extends AppState {
  const AppStateInitial();
}

final class AppStateSplash extends AppState {
  const AppStateSplash();
}

final class AppStateSponsership extends AppState {
  const AppStateSponsership();
}

final class AppStateOnboarding extends AppState {
  const AppStateOnboarding();
}

final class AppStateUnAuthenticated extends AppState {
  const AppStateUnAuthenticated();
}

final class AppStatePushNotification extends AppState {
  const AppStatePushNotification();
}

final class AppStateAuthenticated extends AppState {
  final User user;
  const AppStateAuthenticated({required this.user});
}
