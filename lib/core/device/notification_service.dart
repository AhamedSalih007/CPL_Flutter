import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../domain/enums/tab_type.dart';
import '../../presentation/providers/core/app_state_provider.dart';
import '../../presentation/providers/landing_provider.dart';
import '../configs/app_configuration.dart';

class NotificationService {
  final Ref _ref;
  NotificationService(this._ref);
  static Future<void> initPlatformState() async {
    OneSignal.consentRequired(false);

    // NOTE: Replace with your own app ID from https://www.onesignal.com
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

    OneSignal.initialize(AppConfiguration.onesignalAppId);
  }

  Future<void> notificationListeners() async {
    // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    await OneSignal.Notifications.requestPermission(true);
    OneSignal.User.pushSubscription.addObserver((state) {});

    OneSignal.User.addObserver((state) {
      state.jsonRepresentation();
    });

    OneSignal.Notifications.addPermissionObserver((state) {});

    OneSignal.Notifications.addClickListener((event) async {
      if (event.notification.additionalData != null) {
        if (_ref.read(tabIndexNotifierProvider) != TabType.news) {
          _ref.read(appStateNotifierProvider.notifier).tapPushNotification();
          _ref.read(notificationTapNotifierProvider.notifier).updateTo(true);
          _ref.read(tabIndexNotifierProvider.notifier).updateTo(TabType.news);
        }
      }
    });

    OneSignal.Notifications.addForegroundWillDisplayListener((event) {});
  }
}
