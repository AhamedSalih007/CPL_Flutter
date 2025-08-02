import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/router/app_router.dart';
import '../../../../../../../core/utils/extensions/context_extension.dart';
import '../../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../../../domain/enums/banner_category.dart';
import '../../../../../../../domain/enums/match_status.dart';
import '../../../../../../../domain/enums/match_tab_type.dart';
import '../../../../../../../domain/enums/tab_type.dart';
import '../../../../../../../domain/models/match_details/match_details.dart';
import '../../../../../../../domain/states/banner_state.dart';
import '../../../../../../../domain/states/matches_state.dart';
import '../../../../../../providers/banners/banner_provider.dart';
import '../../../../../../providers/core/router_provider.dart';
import '../../../../../../providers/landing_provider.dart';
import '../../../../../../providers/matches/matches_provider.dart';
import '../../../../../widgets/error_cards/something_went_wrong_card.dart';
import '../../../../../widgets/header.dart';
import '../../../../../widgets/shimmer/matches_shimmer.dart';
import 'match_container.dart';

class LiveScore extends ConsumerStatefulWidget {
  const LiveScore({super.key});

  @override
  ConsumerState<LiveScore> createState() => _LiveScoreState();
}

class _LiveScoreState extends ConsumerState<LiveScore> {
  Timer? _timer;
  @override
  void initState() {
    //uncomment for live summary
    _liveSummary();
    super.initState();
  }

  void _liveSummary() {
    _timer = Timer.periodic(
      const Duration(seconds: 10),
      (timer) {
        final homeMatcheState = ref.read(homeMatchesNotifierProvider);
        if (homeMatcheState is MatchesStateLoaded) {
          if (ref.read(tabIndexNotifierProvider) == TabType.homeTab) {
            ref
                .read(homeMatchesNotifierProvider.notifier)
                .getHomeMatches(isRefresh: true);
          }
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final matchesState = ref.watch(homeMatchesNotifierProvider);
    final bannerData =
        ref.watch(bannerNotifierProvider(CategoryBanner.matches.val)).banner;
    return switch (matchesState) {
      MatchesStateInitial() => const Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: MatchesShimmer(
            scrollDirection: Axis.horizontal,
          ),
        ),
      MatchesStateLoading() => const Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: MatchesShimmer(
            scrollDirection: Axis.horizontal,
          ),
        ),
      MatchesStateLoaded(
        matchData: List<MatchDetails> _,
        liveMatches: var liveMatches
      ) =>
        liveMatches.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  UIDimensions.verticalSpace(24),
                  Header(
                    title: "Matches",
                    arrowCount: 5,
                    titleColor: context.colorScheme.tertiary,
                    subTitleColor: context.colorScheme.onSurface,
                    arrowColor: context.colorScheme.tertiary,
                    onTap: () {
                      ref
                          .read(matchTabIndexNotifierProvider.notifier)
                          .updateTo(MatchesTabType.upcomingMatches);
                      AutoTabsRouter.of(context)
                          .setActiveIndex(TabType.matches.index);
                      ref
                          .read(tabIndexNotifierProvider.notifier)
                          .updateTo(TabType.matches);
                    },
                  ),
                  SizedBox(
                    width: context.screenWidth,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: [
                          ...List.generate(
                            liveMatches.length > 4 ? 4 : liveMatches.length,
                            (index) => InkWell(
                                onTap: () => ref.read(appRouterProvider).push(
                                    MatchDetailRoute(
                                        matchId:
                                            liveMatches[index].matchId ?? "",
                                        matchStatus:
                                            MatchStatus.values.firstWhere(
                                          (element) =>
                                              element.val ==
                                              liveMatches[index].status,
                                          orElse: () => MatchStatus.upcoming,
                                        ),
                                        bannerData: bannerData)),
                                child: MatchContainer(
                                  matchData: liveMatches[index],
                                  totalMatches: liveMatches.length,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  UIDimensions.verticalSpace(12),
                ],
              )
            : const SizedBox.shrink(),
      MatchesStateError() => SomethingWentWrongCard(
          onPressed: () =>
              ref.read(matchesNotifierProvider.notifier).getMatches(),
        ),
    };
  }
}
