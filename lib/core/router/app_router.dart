import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../presentation/ui/modals/alert_dialogs/custom_alert_dialog.dart';
import '../../presentation/ui/modals/alert_dialogs/loading_alert_dialog.dart';
import '../../presentation/ui/modals/bottom_sheets/logout/logout_bottom_sheet.dart';
import '../../presentation/ui/modals/bottom_sheets/team_venue_bottom_sheet.dart';
import '../../presentation/ui/modals/modals_factory.dart';
import '../../presentation/ui/screens/landing/landing_screen.dart';
import '../../presentation/ui/screens/landing/screens/home/home_screen.dart';
import '../../presentation/ui/screens/landing/screens/home/search_news_screen.dart';
import '../../presentation/ui/screens/landing/screens/home/videos_screen.dart';
import '../../presentation/ui/screens/landing/screens/teams/teams_screen.dart';
import '../../presentation/ui/screens/landing/screens/teams/team_details_screen.dart';
import '../../presentation/ui/screens/landing/screens/matches/matches_screen.dart';
import '../../presentation/ui/screens/landing/screens/matches/match_detail_screen.dart';
import '../../presentation/ui/screens/landing/screens/settings/settings_screen.dart';
import '../../presentation/ui/screens/landing/screens/news/news_screen.dart';
import '../../presentation/ui/screens/landing/screens/news/news_details_screen.dart';
import '../../presentation/ui/screens/language_selection/language_selection_screen.dart';
import '../../presentation/ui/screens/login/login_screen.dart';
import '../../presentation/ui/screens/onboarding/onboarding_screen.dart';
import '../../presentation/ui/screens/splash/splash_screen.dart';
import '../../presentation/ui/screens/splash/sponsors_screen.dart';
import '../../domain/models/teams/teams.dart';
import '../logger/logger_service.dart';
import '../utils/local_storage/secure/secure_storage_manager.dart';
import 'guards/auth_guard.dart';
import '../../domain/models/competitions/competitions.dart';
import '../../domain/enums/competition_filter_type.dart';
import '../../domain/enums/match_status.dart';
import '../../domain/models/banner/banner.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  final SecureStorageManager _secureStorageManager;
  final LoggerService _logger;

  late final AuthGuard _authGuard = AuthGuard(_secureStorageManager, _logger);

  AppRouter(
    this._secureStorageManager,
    this._logger,
  );

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(initial: true, page: SplashRoute.page),
        AutoRoute(page: SponsorsRoute.page),
        AutoRoute(page: OnboardingRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(
          page: LandingRoute.page,
          children: [
            AutoRoute(
              page: HomeRoute.page,
              initial: true,
            ),
            AutoRoute(page: MatchesRoute.page),
            AutoRoute(page: TeamsRoute.page),
            AutoRoute(page: SponsorsRoute.page),
            AutoRoute(page: NewsRoute.page, children: [
              AutoRoute(
                page: NewsDetailRoute.page,
              ),
            ]),
          ],
        ),
        AutoRoute(
          page: NewsDetailRoute.page,
        ),
        AutoRoute(
          page: TeamDetailsRoute.page,
        ),
        AutoRoute(
          page: MatchDetailRoute.page,
        ),
        AutoRoute(
          page: VideosRoute.page,
        ),
        AutoRoute(
          page: SearchRoute.page,
        ),
        AutoRoute(
          guards: [_authGuard],
          page: LanguageSelectionRoute.page,
        ),
        //? Add bottom sheets here
        CustomRoute(
          guards: [_authGuard],
          page: LogoutBottomSheetRoute.page,
          customRouteBuilder: ModalsFactory.closeButtonModalBottomSheetBuilder,
          fullscreenDialog: true,
        ),
        CustomRoute(
          page: TeamVenueBottomSheetRoute.page,
          customRouteBuilder: ModalsFactory.closeButtonModalBottomSheetBuilder,
          fullscreenDialog: false,
        ),
        //? Add alert dialogs here
        CustomRoute(
          page: CustomAlertDialogRoute.page,
          customRouteBuilder: ModalsFactory.customAlertDialogBuilder,
        ),
        CustomRoute(
          page: LoadingAlertDialogRoute.page,
          customRouteBuilder: ModalsFactory.loadingAlertDialogBuilder,
        ),
      ];
}
