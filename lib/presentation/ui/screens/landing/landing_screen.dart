import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/utils/assets_gen/assets.gen.dart';
import '../../../../core/utils/extensions/context_extension.dart';
import '../../../../domain/enums/tab_type.dart';
import '../../../providers/landing_provider.dart';
import '../../widgets/bottom_nav_bar_with_indicator.dart';

@RoutePage()
class LandingScreen extends ConsumerStatefulWidget {
  const LandingScreen({super.key});

  @override
  ConsumerState<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends ConsumerState<LandingScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    super.initState();
  }

  //int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    // final currentIndex = ref.watch(landingScreenIndexProvider);
    // final indexController = useTabController(initialLength: 2);
    //? Using annotated region here only for the reason as when scaffold not having app bar set, the status bar color will not change
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: context.theme.appBarTheme.systemOverlayStyle!,
      child: AutoTabsRouter.tabBar(
          physics: const NeverScrollableScrollPhysics(),
          routes: [
            const HomeRoute(),
            const MatchesRoute(),
            const TeamsRoute(),
            NewsRoute(),
          ],
          builder: (context, child, pageController) {
            final tabsRouter = AutoTabsRouter.of(context);
            return Scaffold(
              body: child,
              bottomNavigationBar: CustomLineIndicatorBottomNavbar(
                selectedColor: Color(ref.watch(tabIndexNotifierProvider).color),
                unSelectedColor: Colors.white,
                currentIndex: ref.watch(tabIndexNotifierProvider).val,
                onTap: (index) {
                  tabsRouter.setActiveIndex(index);
                  ref
                      .read(tabIndexNotifierProvider.notifier)
                      .updateTo(TabType.values.firstWhere(
                        (element) => element.val == index,
                        orElse: () => TabType.homeTab,
                      ));
                },
                enableLineIndicator: true,
                lineIndicatorWidth: 3,
                indicatorType: IndicatorType.top,
                customBottomBarItems: [
                  CustomBottomBarItems(
                    label: 'Home',
                    icon: tabsRouter.activeIndex == 0
                        ? Assets.icons.homeActive.svg()
                        : Assets.icons.home.svg(),
                  ),
                  CustomBottomBarItems(
                    label: 'Matches',
                    icon: tabsRouter.activeIndex == 1
                        ? Assets.icons.matchesActive.svg()
                        : Assets.icons.matches.svg(),
                  ),
                  CustomBottomBarItems(
                    label: 'Teams ',
                    icon: tabsRouter.activeIndex == 2
                        ? Assets.icons.teamsActive.svg()
                        : Assets.icons.team.svg(),
                  ),
                  CustomBottomBarItems(
                    label: 'News',
                    icon: tabsRouter.activeIndex == 3
                        ? Assets.icons.newsActive.svg()
                        : Assets.icons.news.svg(),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
