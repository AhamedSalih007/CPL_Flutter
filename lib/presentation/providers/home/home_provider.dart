import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/data_service_providers.dart';
import '../../../domain/enums/category.dart';
import '../../../domain/states/home_state.dart';
import '../../../domain/states/user_state.dart';
import '../../../domain/usecases/auth/auth_usecases.dart';
import '../core/app_state_provider.dart';
import '../core/router_provider.dart';
import '../core/user_state_provider.dart';

part 'home_provider.g.dart';

@riverpod
class HomeNotifier extends _$HomeNotifier {
  late final LogoutUser _logoutUserUseCase =
      ref.watch(logoutUserUseCaseProvider);

  @override
  HomeState build() {
    return const HomeStateInitial();
  }

  Future<void> logout() async {
    switch (ref.read(userStateNotifierProvider)) {
      case UserStateAvailable(user: var user):
        _logoutUserUseCase(user.accountType);
      default:
    }
    ref.read(appRouterProvider).maybePop();
    await ref.read(appStateNotifierProvider.notifier).unAuthenticateState();
    // state = const HomeState.loggedOut();
    ref.read(loggerServiceProvider).infoLog(
          "logout user",
          className: "Home",
        );
  }
}

@riverpod
class CategorySelectionNotifier extends _$CategorySelectionNotifier {
  @override
  bool build() {
    return false;
  }

  void updateTo() {
    state = !state;
  }
}

@Riverpod(keepAlive: true)
class SelectedCategoryNotifier extends _$SelectedCategoryNotifier {
  @override
  CategoryType build() {
    return CategoryType.cpl;
  }

  void updateTo(CategoryType categoryType) {
    state = categoryType;
  }
}
