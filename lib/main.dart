import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_cue_light_show_sdk/flutter_cue_light_show_sdk.dart';
import 'core/app_bootstrapper.dart';
import 'core/logger/riverpod_observer_log.dart';
import 'data/data_service_providers.dart';
import 'presentation/ui/app.dart';

Future<void> main() async {
  final container = ProviderContainer();
  final loggerService = container.read(loggerServiceProvider);

  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterCueLightShowSdk.fetchTheme();
    await AppBootStrapper.initialize();
    runApp(
      ProviderScope(
        observers: [
          RiverpodObserverLog(loggerService),
        ],
        child: const App(),
      ),
    );
  }, (ex, s) {
    loggerService.errorLog(ex, s);
  });
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
