import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/utils/assets_gen/assets.gen.dart';
import '../../../../../../core/utils/extensions/context_extension.dart';
import '../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../../domain/enums/banner_category.dart';
import '../../../../../../domain/states/competitions_state.dart';
import '../../../../../providers/banners/banner_provider.dart';
import '../../../../../providers/competitions/competitions_provider.dart';
import '../../../../../providers/marquee_text/marquee_text_provider.dart';
import '../../../../../providers/matches/matches_provider.dart';
import '../../../../../providers/news/news_provider.dart';
import '../../../../../providers/partners/partners_provider.dart';
import '../../../../../providers/points_table.dart/points_table_provider.dart';
import '../../../../../providers/social_media_links_provider.dart';
import '../../../../../providers/sponsors/sponsors_provider.dart';
import '../../../../../providers/teams_provider.dart';
import '../../../../widgets/text_scrollable.dart';
import '../../../splash/sponsors_screen.dart';
import 'widgets/auto_play_carousal.dart';
import 'widgets/footer.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/live_score.dart';
import 'widgets/match_highlights_widget.dart';
import 'widgets/points_table.dart';
import 'widgets/top_stories.dart';
import 'package:flutter_cue_light_show_sdk/flutter_cue_light_show_sdk.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref.read(marqueeNotifierProvider.notifier).getMarqueeText();
      ref.read(topNewsNotifierProvider.notifier).getTopNews();
      await ref.read(competitionsNotifierProvider.notifier).getCompetitions();
      ref.read(homeMatchesNotifierProvider.notifier).getHomeMatches();
      ref.read(pointsTableNotifierProvider.notifier).getPointsTable();
      ref.read(socialMediaLinksNotifierProvider.notifier).getSocialMediaLinks();
      ref.read(sponsorsNotifierProvider.notifier).getSponsors();
      ref.read(partnersNotifierProvider.notifier).getPartners();
      ref
          .read(bannerNotifierProvider(CategoryBanner.matches.val).notifier)
          .getBanner();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.primary,
      body: RefreshIndicator(
        onRefresh: () async {
          ref.read(marqueeNotifierProvider.notifier).getMarqueeText();
          ref.read(topNewsNotifierProvider.notifier).getTopNews();
          await ref
              .read(competitionsNotifierProvider.notifier)
              .getCompetitions();
          ref.read(homeMatchesNotifierProvider.notifier).getHomeMatches();
          ref.read(pointsTableNotifierProvider.notifier).getPointsTable();
          ref
              .read(socialMediaLinksNotifierProvider.notifier)
              .getSocialMediaLinks();
          ref.read(sponsorsNotifierProvider.notifier).getSponsors();
          ref.read(partnersNotifierProvider.notifier).getPartners();
        },
        child: CustomScrollView(
          slivers: [
            const HomeAppBar(),
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const TextScrollableWidget(),
                      UIDimensions.verticalSpaceSmall,
                      const AutoPlayCarousal(),
                      const LiveScore(),
                      const TopStoriesWidget(),
                      const MatchHeighlightsWidget(),
                      const PointsTable(),
                      UIDimensions.verticalSpace(48),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            FlutterCueLightShowSdk.launchCue();
                          },
                          child: const Text(
                            'Launch CUE',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      UIDimensions.verticalSpace(48),
                      Center(child: Assets.icons.cricketPlayedLouder.svg()),
                      UIDimensions.verticalSpace(48),
                      const Footer(),
                      UIDimensions.verticalSpace(48),
                      Column(
                        children: [
                          sponsers(ref, context),
                          partners(ref, context),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void switchCategory(WidgetRef ref) async {
  await ref.read(competitionsNotifierProvider.notifier).getCompetitions();
  if (ref.read(competitionsNotifierProvider) is CompetitionStateLoaded) {
    ref.read(homeMatchesNotifierProvider.notifier).getHomeMatches();
    ref.read(pointsTableNotifierProvider.notifier).getPointsTable();
    ref.read(matchesNotifierProvider.notifier).getMatches();
  }
  ref.read(teamsNotifierProvider.notifier).getTeams();
}
