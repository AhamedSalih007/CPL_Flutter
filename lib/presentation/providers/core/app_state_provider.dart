import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/app_bootstrapper.dart';
import '../../../data/data_service_providers.dart';
import '../../../data/models/result/data_state.dart';
import '../../../domain/enums/category.dart';
import '../../../domain/models/user/user.dart';
import '../../../domain/states/core/app_state.dart';
import '../../../domain/usecases/storage/category/category_usecases.dart';
import '../../../domain/usecases/storage/onboarding/onboarding_usecases.dart';
import '../../../domain/usecases/user/user_usecases.dart';
import '../home/home_provider.dart';
import '../landing_provider.dart';
import '../partners/partners_provider.dart';
import '../sponsors/sponsors_provider.dart';

part 'app_state_provider.g.dart';

@Riverpod(keepAlive: true)
class AppStateNotifier extends _$AppStateNotifier {
  late final ReadUser _readUserUseCase = ref.watch(readUserUseCaseProvider);
  // late final ReadJwt _readJwtUseCase = _read(readJwtTokenUseCaseProvider);

  // late final ReadOnboarding _readOnboardingUseCase =
  //     _ref.watch(readOnboardingUseCaseProvider);
  late final WriteOnboarding _writeOnboardingUseCase =
      ref.watch(writeOnboardingUseCaseProvider);

  late final ReadCategory _readCategory =
      ref.watch(readCategoryUseCaseProvider);

  @override
  AppState build() {
    return const AppStateInitial();
  }

  Future<void> init() async {
    state = const AppStateSplash();
    final category = await _readCategory();
    if (category.isNotEmpty) {
      ref
          .read(selectedCategoryNotifierProvider.notifier)
          .updateTo(CategoryType.values.firstWhere(
            (element) => element.name == category,
            orElse: () => CategoryType.cpl,
          ));
    }
    await Future.delayed(const Duration(seconds: 11, milliseconds: 60));
    await ref.read(connectivityServiceProvider).checkConnectivity();
    if (ref.read(notificationTapNotifierProvider)) {
      state = const AppStatePushNotification();
      ref.read(notificationTapNotifierProvider.notifier).updateTo(false);
    } else {
      state = const AppStateSponsership();
      await Future.wait([
        ref.read(sponsorsNotifierProvider.notifier).getSponsors(),
        ref.read(partnersNotifierProvider.notifier).getPartners()
      ]);
      await Future.delayed(const Duration(seconds: 3));
      final dataState = await _readUserUseCase();
      switch (dataState) {
        case DataStateSuccess<User>(data: var user):
          state = AppStateAuthenticated(user: user);
        case DataStateError<User>():
          state = const AppStateUnAuthenticated();
      }
    }
    SplashFactory.remove();
  }

  Future<void> completeOnboarding() async {
    await _writeOnboardingUseCase(true);
    state = const AppStateUnAuthenticated();
  }

  Future<void> authenticateState(User user) async {
    state = AppStateAuthenticated(user: user);
  }

  Future<void> unAuthenticateState() async {
    state = const AppStateUnAuthenticated();
  }

  Future<void> tapPushNotification() async {
    state = const AppStatePushNotification();
  }
}
