import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/utils/assets_gen/assets.gen.dart';
import '../../../../../../core/utils/assets_gen/fonts.gen.dart';
import '../../../../../../core/utils/extensions/context_extension.dart';
import '../../../../../../core/utils/extensions/string_extensions.dart';
import '../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../../domain/enums/match_status.dart';
import '../../../../../../domain/models/banner/banner.dart';
import '../../../../../../domain/states/match_details_state.dart';
import '../../../../../providers/matches/matches_provider.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/error_cards/something_went_wrong_card.dart';
import '../../../../widgets/shimmer/common_shimmer.dart';
import '../../../../widgets/shimmer/match_details_shimmer.dart';
import '../home/widgets/countdown_timer.dart';
import 'widgets/commentary_tabview.dart';
import 'widgets/match_info_container.dart';
import 'widgets/score_board_container.dart';
import 'widgets/sqaud_tabview.dart';
import 'widgets/stats_tabview.dart';

@RoutePage()
class MatchDetailScreen extends ConsumerStatefulWidget {
  final MatchStatus matchStatus;
  final String matchId;
  final BannerAcf? bannerData;
  const MatchDetailScreen(
      {super.key,
      required this.matchId,
      required this.matchStatus,
      this.bannerData});

  @override
  ConsumerState<MatchDetailScreen> createState() => _MatchDetailScreenState();
}

class _MatchDetailScreenState extends ConsumerState<MatchDetailScreen>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  late ScrollController _scrollViewController;
  List<String> inningsIdList = [];

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref.read(scoreCardNotifierProvider.notifier).getScoreCard(widget.matchId);
      await ref
          .read(matchDetailsNotifierProvider.notifier)
          .getMatchDetails(widget.matchId);
      commentaryApis();
      if (widget.matchStatus == MatchStatus.live) {
        _liveSummary();
      }
    });
  }

  void _liveSummary() {
    _timer = Timer.periodic(
      const Duration(seconds: 15),
      (timer) {
        commentaryApis(isLive: true);
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    //tabController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final matchDetails = ref.watch(matchDetailsNotifierProvider);
    return Scaffold(
      backgroundColor: context.colorScheme.primary,
      body: switch (matchDetails) {
        MatchDetailStateInitial() => const MatchDetailsShimmer(),
        MatchDetailStateLoading() => const MatchDetailsShimmer(),
        MatchDetailStateLoaded(
          matchData: var matchData,
        ) =>
          DefaultTabController(
            length: matchData.status != MatchStatus.upcoming.val ? 5 : 2,
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                final matchStartDate =
                    DateTime.parse(matchData.startDate ?? "").toLocal();
                final firstTeamScore = ref
                    .read(matchDetailsNotifierProvider.notifier)
                    .getFirstTeamScore(matchData);
                final secondTeamScore = ref
                    .read(matchDetailsNotifierProvider.notifier)
                    .getSecondTeamScore(matchData);
                final isLessThanOneday =
                    matchStartDate.difference(DateTime.now()).inDays < 1;
                Duration duration = matchStartDate.difference(DateTime.now());
                return <Widget>[
                  SliverAppBar(
                    pinned: true,
                    scrolledUnderElevation: 0.0,
                    expandedHeight: kToolbarHeight + 150,
                    toolbarHeight: kToolbarHeight + context.screenHeight * 0.2,
                    automaticallyImplyLeading: false,
                    backgroundColor: context.colorScheme.background,
                    flexibleSpace: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            color: const Color(0xff050519),
                            height: 100,
                            width: context.screenWidth,
                          ),
                        ),
                        Positioned.fill(
                          top: 100,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: context.customColors.primaryBoxGradient,
                            ),
                            width: context.screenWidth,
                            child: SizedBox(
                              width: context.screenWidth,
                              child: CachedNetworkImage(
                                imageUrl: widget.bannerData?.matchesBannerImage
                                        ?.sizes?.large ??
                                    "",
                                fit: BoxFit.fitWidth,
                                placeholder: (context, url) {
                                  return CommonShimmer(
                                      height: 200,
                                      width: context.screenWidth,
                                      cornerRadius: 0);
                                },
                                errorWidget: (context, url, error) {
                                  return Assets.images.errorImage.image(
                                    fit: BoxFit.fitWidth,
                                    height: 200,
                                    width: context.screenWidth,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Assets.images.teamDeatilAppbar.image(),
                        ),
                        Positioned(
                            top: 50,
                            left: 16,
                            child: InkWell(
                              onTap: () async {
                                await context.maybePop();
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.arrow_back_ios_new,
                                    size: 16,
                                  ),
                                  UIDimensions.horizontalSpaceMedium,
                                  CustomText.headlineLarge(
                                      "${matchData.teams?[0].shortName ?? ""}  vs  ${matchData.teams?[1].shortName ?? ""}"),
                                ],
                              ),
                            )),
                        Positioned(
                          top: 115,
                          left: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: context.screenWidth * 0.9,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText.headlineSmall(
                                        matchData.title ?? ""),
                                    CustomText.headlineSmall(
                                        matchData.startDate?.dDMM.toString() ??
                                            ""),
                                  ],
                                ),
                              ),
                              UIDimensions.verticalSpaceMedium,
                              SizedBox(
                                width: context.screenWidth * 0.9,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              CachedNetworkImage(
                                                height: 47,
                                                width: 47,
                                                imageUrl: matchData.teams?.first
                                                        .logo?.small?.url ??
                                                    "",
                                                placeholder: (context, url) {
                                                  return const CommonShimmer(
                                                    height: 47,
                                                    width: 47,
                                                    cornerRadius: 999,
                                                  );
                                                },
                                                errorWidget:
                                                    (context, url, error) {
                                                  return Assets
                                                      .images.errorImage
                                                      .image(
                                                    height: 47,
                                                    width: 47,
                                                  );
                                                },
                                              ),
                                              CustomText.bodyMedium(
                                                matchData.teams?.first
                                                        .shortName ??
                                                    "",
                                                color: context
                                                    .customColors.textColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ],
                                          ),
                                          UIDimensions.horizontalSpaceSmall,
                                          Visibility(
                                            visible: matchData.status ==
                                                    MatchStatus.live.val ||
                                                matchData.status ==
                                                    MatchStatus.completed.val,
                                            child: Column(
                                              children: [
                                                CustomText.displaySmall(
                                                  ref
                                                                  .read(matchDetailsNotifierProvider
                                                                      .notifier)
                                                                  .getFirstTeamScore(
                                                                      matchData)
                                                                  ?.runs !=
                                                              null &&
                                                          firstTeamScore
                                                                  ?.wickets !=
                                                              null
                                                      ? "${firstTeamScore?.runs ?? ""}-${firstTeamScore?.wickets ?? ""}"
                                                      : "-",
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                CustomText.bodyMedium(
                                                  firstTeamScore?.oversBowled !=
                                                          null
                                                      ? "${firstTeamScore?.oversBowled} Overs"
                                                      : "-",
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    UIDimensions.horizontalSpaceSmall,
                                    (matchData.status ==
                                            MatchStatus.upcoming.val)
                                        ? SizedBox(
                                            width: 200,
                                            child: Column(
                                              children: [
                                                CustomText.bodyMedium(
                                                  isLessThanOneday
                                                      ? "Match starts in "
                                                      : "Match Start on",
                                                ),
                                                isLessThanOneday
                                                    ? CountdownTimer(
                                                        time: duration)
                                                    : CustomText.displaySmall(
                                                        matchStartDate
                                                            .toString()
                                                            .dDMM,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                              ],
                                            ),
                                          )
                                        : (((matchData.status ==
                                                MatchStatus.live.val))
                                            ? Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(99),
                                                  color: matchData.status ==
                                                          MatchStatus.live.val
                                                      ? context.customColors
                                                          .secondaryRed
                                                      : context.customColors
                                                          .white10Color,
                                                ),
                                                child: Padding(
                                                  padding: UIDimensions
                                                      .onlyPaddingInsets(
                                                          left: 25,
                                                          right: 25,
                                                          top: 8,
                                                          bottom: 6),
                                                  child: Text(
                                                    matchData.status
                                                            ?.toUpperCase() ??
                                                        "",
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              )
                                            : const CustomText.bodyMedium(
                                                "V/S",
                                                fontWeight: FontWeight.w600,
                                              )),
                                    UIDimensions.horizontalSpaceSmall,
                                    Row(
                                      children: [
                                        Visibility(
                                          visible: matchData.status ==
                                                  MatchStatus.live.val ||
                                              matchData.status ==
                                                  MatchStatus.completed.val,
                                          child: Column(
                                            children: [
                                              CustomText.displaySmall(
                                                secondTeamScore?.runs != null &&
                                                        secondTeamScore
                                                                ?.wickets !=
                                                            null
                                                    ? "${secondTeamScore?.runs ?? ""}-${secondTeamScore?.wickets ?? ""}"
                                                    : "-",
                                                fontWeight: FontWeight.w700,
                                              ),
                                              CustomText.bodyMedium(
                                                secondTeamScore?.oversBowled !=
                                                        null
                                                    ? "${secondTeamScore?.oversBowled} Overs"
                                                    : "-",
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            UIDimensions.horizontalSpaceSmall,
                                            CachedNetworkImage(
                                              height: 47,
                                              width: 47,
                                              imageUrl: matchData.teams?.last
                                                      .logo?.small?.url ??
                                                  "",
                                              placeholder: (context, url) {
                                                return const CommonShimmer(
                                                  height: 47,
                                                  width: 47,
                                                  cornerRadius: 999,
                                                );
                                              },
                                              errorWidget:
                                                  (context, url, error) {
                                                return Assets.images.errorImage
                                                    .image(
                                                  height: 47,
                                                  width: 47,
                                                );
                                              },
                                            ),
                                            CustomText.bodyMedium(
                                              matchData.teams?.last.shortName ??
                                                  "",
                                              fontWeight: FontWeight.w600,
                                              color: context
                                                  .customColors.textColor,
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          child: SizedBox(
                            width: context.screenWidth,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText.bodySmall(
                                  matchData.description ?? "",
                                  fontWeight: FontWeight.w600,
                                  color: context.customColors.textColor,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SliverPersistentHeader(
                    delegate: _SliverAppBarDelegate(
                      TabBar(
                          unselectedLabelColor: context.customColors.grey3Color,
                          labelColor: context.colorScheme.tertiary,
                          indicatorColor: context.colorScheme.tertiary,
                          dividerColor: Colors.transparent,
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
                          unselectedLabelStyle: const TextStyle(
                              fontSize: 14,
                              fontFamily: FontFamily.anekOdia,
                              fontWeight: FontWeight.w600),
                          labelStyle: const TextStyle(
                              fontSize: 14,
                              fontFamily: FontFamily.anekOdia,
                              fontWeight: FontWeight.w600),
                          tabs: (matchData.status != MatchStatus.upcoming.val)
                              ? [
                                  const Tab(text: "Info"),
                                  const Tab(text: ("Scoreboard")),
                                  const Tab(text: ("Commentary")),
                                  const Tab(text: ("Squad")),
                                  const Tab(text: ("Stats"))
                                ]
                              : [
                                  const Tab(text: "Info"),
                                  const Tab(text: ("Squad")),
                                ]),
                    ),
                    pinned: true, // Header stays pinned while scrolling
                  )
                ];
              },
              body: TabBarView(
                children: (matchData.status != MatchStatus.upcoming.val)
                    ? <Widget>[
                        MatchInfoContainer(
                          matchDetails: matchData,
                        ),
                        ScoreBoardContainer(
                          matchId: widget.matchId,
                        ),
                        CommentaryTabview(
                          inningsId: inningsIdList,
                          teams: matchData.teams ?? [],
                          matchId: widget.matchId,
                        ),
                        SquadTabView(
                          teamsData: matchData.teams ?? [],
                          isCompletedMatch: true,
                        ),
                        StatsTabview(
                          matchDetails: matchData,
                        )
                      ]
                    : [
                        MatchInfoContainer(
                          matchDetails: matchData,
                        ),
                        SquadTabView(
                          teamsData: matchData.teams ?? [],
                        ),
                      ],
              ),
            ),
          ),
        MatchDetailStateError() => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SomethingWentWrongCard(
                  onPressed: () async {
                    await ref
                        .read(matchDetailsNotifierProvider.notifier)
                        .getMatchDetails(widget.matchId);
                    commentaryApis();
                  },
                ),
              ),
            ],
          ),
      },
    );
  }

  void commentaryApis({bool isLive = false}) async {
    await ref
        .read(matchDetailsNotifierProvider.notifier)
        .getMatchDetails(widget.matchId, isRefresh: isLive);
    final matchDetailsState = ref.read(matchDetailsNotifierProvider);
    if (matchDetailsState is MatchDetailStateLoaded) {
      //commentary api's
      inningsIdList = [
        ref.read(matchDetailsNotifierProvider.notifier).getFirstInningsId(),
        ref.read(matchDetailsNotifierProvider.notifier).getSecondInningsId()
      ];
      ref
          .read(commentaryNotifierProvider(inningsIdList.first).notifier)
          .getCommentary(widget.matchId, isRefresh: isLive);
      ref
          .read(commentaryNotifierProvider(inningsIdList.last).notifier)
          .getCommentary(widget.matchId, isRefresh: isLive);
    }
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: context.colorScheme.background, // Background color of the header
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return true;
  }
}
