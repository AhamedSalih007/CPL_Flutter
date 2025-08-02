import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/router/app_router.dart';
import '../../../../../../core/utils/assets_gen/assets.gen.dart';
import '../../../../../../core/utils/assets_gen/fonts.gen.dart';
import '../../../../../../core/utils/extensions/context_extension.dart';
import '../../../../../../core/utils/extensions/string_extensions.dart';
import '../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../../domain/enums/banner_category.dart';
import '../../../../../../domain/enums/competition_filter_type.dart';
import '../../../../../../domain/enums/match_status.dart';
import '../../../../../../domain/models/banner/banner.dart';
import '../../../../../../domain/models/competitions/competitions.dart';
import '../../../../../../domain/models/match_details/match_details.dart';
import '../../../../../../domain/states/competitions_state.dart';
import '../../../../../../domain/states/matches_state.dart';
import '../../../../../../domain/states/banner_state.dart';
import '../../../../../providers/banners/banner_provider.dart';
import '../../../../../providers/competitions/competitions_provider.dart';
import '../../../../../providers/core/router_provider.dart';
import '../../../../../providers/landing_provider.dart';
import '../../../../../providers/matches/matches_provider.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/error_cards/something_went_wrong_card.dart';
import '../../../../widgets/shimmer/common_shimmer.dart';
import '../../../../widgets/shimmer/matches_shimmer.dart';
import '../home/widgets/points_table_container.dart';
import '../home/widgets/match_container.dart';

@RoutePage()
class MatchesScreen extends ConsumerStatefulWidget {
  const MatchesScreen({
    super.key,
  });

  @override
  ConsumerState<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends ConsumerState<MatchesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  CompetitionTeams? selectedTeam;
  String? selectedYear;
  Venues? selectedVenue;
  late final List<String> dropdownValues;

  @override
  void initState() {
    dropdownValues = ["2020", "2021", "2022", "2023", "2024"];
    _controller = TabController(length: 3, vsync: this);
    _controller.index = ref.read(matchTabIndexNotifierProvider).val;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref.read(matchesNotifierProvider.notifier).getMatches(
            teamId: ref.read(teamFilterNotifierProvider)?.teamId,
            venueId: ref.read(venueFilterNotifierProvider)?.venueId,
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _controller.index = ref.watch(matchTabIndexNotifierProvider).val;
    ref.watch(competitionsNotifierProvider);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                  pinned: true,
                  scrolledUnderElevation: 0.0,
                  expandedHeight: kToolbarHeight + 100,
                  toolbarHeight: kToolbarHeight + 90,
                  automaticallyImplyLeading: false,
                  flexibleSpace: Stack(
                    children: [
                      matchesBanner(ref, context),
                      Positioned(
                          top: 0,
                          right: 0,
                          child: Assets.images.matchClip.image()),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: CustomText.displayLarge(
                          "MATCHES",
                          fontSize: 35,
                          fontFamily: FontFamily.cplt20,
                          color: context.colorScheme.tertiary,
                        ),
                      ),
                      Positioned(
                        left: 20,
                        top: 56,
                        child: competitons(
                            ref: ref,
                            competitionType: CompetitionFilterType.team,
                            context: context),
                      ),
                      Positioned(
                        left: (context.screenWidth * 0.3) + 40,
                        top: 56,
                        child: competitons(
                          ref: ref,
                          competitionType: CompetitionFilterType.venue,
                          context: context,
                        ),
                      ),
                      // Positioned(
                      //   right: 20,
                      //   top: 60,
                      //   child: competitons(
                      //       ref: ref,
                      //       competitionType: CompetitionFilterType.year,
                      //       context: context,
                      //       yearsList: dropdownValues),
                      // ),
                    ],
                  )),
              const SliverToBoxAdapter(
                child: UIDimensions.verticalSpaceMedium,
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: _controller,
                    unselectedLabelColor: context.customColors.grey3Color,
                    labelColor: context.colorScheme.tertiary,
                    indicatorColor: Colors.transparent,
                    dividerColor: Colors.transparent,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    unselectedLabelStyle: const TextStyle(
                        fontSize: 18,
                        fontFamily: FontFamily.anekOdia,
                        fontWeight: FontWeight.w700),
                    labelStyle: const TextStyle(
                        fontSize: 18,
                        fontFamily: FontFamily.anekOdia,
                        fontWeight: FontWeight.w700),
                    tabs: const [
                      Tab(text: "Upcoming"),
                      Tab(text: ("Result")),
                      Tab(text: ("Points Table")),
                    ],
                  ),
                ),
                pinned: true, // Header stays pinned while scrolling
              ),
            ];
          },
          body: TabBarView(
            controller: _controller,
            children: [
              upcomingMatches(ref, context),
              completedMatches(ref, context),
              ListView(
                padding: UIDimensions.onlyPaddingInsets(top: 20),
                children: [
                  PointsTableContainer(
                    borderColor: context.colorScheme.tertiary,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
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

Widget upcomingMatches(WidgetRef ref, BuildContext context) {
  final matchesState = ref.watch(matchesNotifierProvider);
  final bannerData =
      ref.watch(bannerNotifierProvider(CategoryBanner.matches.val)).banner;
  switch (matchesState) {
    case MatchesStateInitial():
      {
        return const MatchesShimmer();
      }
    case MatchesStateLoading():
      {
        return const MatchesShimmer();
      }
    case MatchesStateLoaded(
        matchData: List<MatchDetails> _,
        upcomingMatches: List<MatchDetails> upcomingMatches
      ):
      {
        return RefreshIndicator(
          onRefresh: () async {
            await ref
                .read(competitionsNotifierProvider.notifier)
                .getCompetitions();
            ref.read(matchesNotifierProvider.notifier).getMatches(
                teamId: ref.read(teamFilterNotifierProvider)?.teamId,
                venueId: ref.read(venueFilterNotifierProvider)?.venueId);
          },
          child: upcomingMatches.isNotEmpty
              ? SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                        upcomingMatches.length,
                        (index) => Padding(
                              padding: UIDimensions.symmetricPaddingInsets(
                                  vertical: 8, horizontal: 16),
                              child: InkWell(
                                onTap: () => ref.read(appRouterProvider).push(
                                      MatchDetailRoute(
                                        matchId:
                                            upcomingMatches[index].matchId ??
                                                "",
                                        matchStatus: MatchStatus.upcoming,
                                        bannerData: bannerData,
                                      ),
                                    ),
                                child: MatchContainer(
                                  width: context.screenWidth,
                                  leftPadding: 0.0,
                                  matchData: upcomingMatches[index],
                                  totalMatches: upcomingMatches.length,
                                ),
                              ),
                            )).toList(),
                  ))
              : const Center(
                  child: CustomText.bodyMedium("No Matches Available"),
                ),
        );
      }
    case MatchesStateError():
      {
        return SomethingWentWrongCard(onPressed: () async {
          await ref
              .read(competitionsNotifierProvider.notifier)
              .getCompetitions();
          ref.read(matchesNotifierProvider.notifier).getMatches(
              teamId: ref.read(teamFilterNotifierProvider)?.teamId,
              venueId: ref.read(venueFilterNotifierProvider)?.venueId);
        });
      }
  }
}

Widget completedMatches(WidgetRef ref, BuildContext context) {
  final matchesState = ref.watch(matchesNotifierProvider);
  ref.watch(competitionsNotifierProvider);
  final bannerData =
      ref.watch(bannerNotifierProvider(CategoryBanner.matches.val)).banner;
  switch (matchesState) {
    case MatchesStateInitial():
      {
        return const MatchesShimmer();
      }
    case MatchesStateLoading():
      {
        return const MatchesShimmer();
      }
    case MatchesStateLoaded(
        matchData: List<MatchDetails> _,
        completedMatches: List<MatchDetails> completedMatches
      ):
      {
        if (completedMatches.isNotEmpty) {
          completedMatches.sort((a, b) {
            if (a.startDate != null && b.startDate != null) {
              return DateTime.parse(b.startDate!)
                  .compareTo(DateTime.parse(a.startDate!));
            }
            return 0;
          });
        }
        return RefreshIndicator(
          onRefresh: () async {
            await ref
                .read(competitionsNotifierProvider.notifier)
                .getCompetitions();
            ref.read(matchesNotifierProvider.notifier).getMatches(
                teamId: ref.read(teamFilterNotifierProvider)?.teamId,
                venueId: ref.read(venueFilterNotifierProvider)?.venueId);
          },
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: completedMatches.isNotEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                        completedMatches.length,
                        (index) => Padding(
                              padding: UIDimensions.symmetricPaddingInsets(
                                  vertical: 8, horizontal: 16),
                              child: InkWell(
                                onTap: () => ref.read(appRouterProvider).push(
                                    MatchDetailRoute(
                                        matchId:
                                            completedMatches[index].matchId ??
                                                "",
                                        matchStatus: MatchStatus.completed,
                                        bannerData: bannerData)),
                                child: MatchContainer(
                                  width: context.screenWidth,
                                  leftPadding: 0.0,
                                  matchData: completedMatches[index],
                                  totalMatches: completedMatches.length,
                                ),
                              ),
                            )).toList(),
                  )
                : const Center(
                    child: CustomText.bodyMedium("No Matches Available"),
                  ),
          ),
        );
      }
    case MatchesStateError():
      {
        return SomethingWentWrongCard(onPressed: () async {
          await ref
              .read(competitionsNotifierProvider.notifier)
              .getCompetitions();
          ref.read(matchesNotifierProvider.notifier).getMatches(
              teamId: ref.read(teamFilterNotifierProvider)?.teamId,
              venueId: ref.read(venueFilterNotifierProvider)?.venueId);
        });
      }
  }
}

Widget competitons<T>({
  required WidgetRef ref,
  required CompetitionFilterType competitionType,
  required BuildContext context,
  List<String>? yearsList,
}) {
  final competitionState = ref.watch(competitionsNotifierProvider);
  switch (competitionState) {
    case CompetitionStateInitial():
      return const CommonShimmer(
        height: 40,
        width: 80,
      );
    case CompetitionStateLoading():
      return const CommonShimmer(
        height: 40,
        width: 80,
      );
    case CompetitionStateLoaded(
        competitionData: List<CompetitionData> competitionData
      ):
      return competitionData.isNotEmpty
          ? InkWell(
              onTap: () {
                competitionType == CompetitionFilterType.year
                    ? ref.read(appRouterProvider).push(
                          TeamVenueBottomSheetRoute(
                              title: "Season",
                              type: CompetitionFilterType.year,
                              years: yearsList),
                        )
                    : competitionType == CompetitionFilterType.team
                        ? ref.read(appRouterProvider).push(
                              TeamVenueBottomSheetRoute(
                                  title: "Teams",
                                  type: CompetitionFilterType.team,
                                  teams: competitionData.first.teams),
                            )
                        : ref.read(appRouterProvider).push(
                              TeamVenueBottomSheetRoute(
                                title: "Venues",
                                type: CompetitionFilterType.venue,
                                venues: competitionData.first.venues,
                              ),
                            );
              },
              child: teamVenueContainer(ref, context, competitionType))
          : const SizedBox.shrink();
    case CompetitionStateError():
      return const SizedBox(
        child: Text("error"),
      );
  }
}

Widget teamVenueContainer(
    WidgetRef ref, BuildContext context, CompetitionFilterType filterType) {
  return Container(
    padding: UIDimensions.symmetricPaddingInsets(horizontal: 8),
    decoration: BoxDecoration(
      color: context.customColors.black40Color,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      border: Border.all(
        color: Colors.white,
      ),
    ),
    height: context.screenHeight * 0.04,
    width: context.screenWidth * 0.3,
    child: SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: context.screenWidth * 0.18,
            child: Padding(
              padding: UIDimensions.onlyPaddingInsets(top: 4.0),
              child: CustomText.bodyMedium(filterType ==
                      CompetitionFilterType.year
                  ? ref.watch(yeaFilterNotifierProvider) ?? "Year"
                  : filterType == CompetitionFilterType.team
                      ? ref.watch(teamFilterNotifierProvider)?.name ?? "Team"
                      : ref.watch(venueFilterNotifierProvider)?.name ??
                          "Venue"),
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            size: 16,
          )
        ],
      ),
    ),
  );
}

Widget matchesBanner(WidgetRef ref, BuildContext context) {
  final matchessBannerState =
      ref.watch(bannerNotifierProvider(CategoryBanner.matches.val));
  switch (matchessBannerState) {
    case BannerStateInitial():
      return SizedBox(
        child: CommonShimmer(
          height: 200,
          width: context.screenWidth,
          cornerRadius: 0,
        ),
      );
    case BannerStateLoading():
      return CommonShimmer(
          height: 200, width: context.screenWidth, cornerRadius: 0);
    case BannerStateLoaded(teamsBanner: BannerAcf? bannerData):
      return SizedBox(
        width: context.screenWidth,
        child: CachedNetworkImage(
          imageUrl: bannerData?.matchesBannerImage?.sizes?.large ?? "",
          fit: BoxFit.fitWidth,
          placeholder: (context, url) {
            return CommonShimmer(
                height: 200, width: context.screenWidth, cornerRadius: 0);
          },
          errorWidget: (context, url, error) {
            return Assets.images.errorImage.image(
              fit: BoxFit.fitWidth,
              height: 200,
              width: context.screenWidth,
            );
          },
        ),
      );
    case BannerStateError():
      return const SizedBox();
  }
}
