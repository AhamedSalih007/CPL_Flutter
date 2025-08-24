import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../core/utils/assets_gen/assets.gen.dart';
import '../../../../../../core/utils/assets_gen/fonts.gen.dart';
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
import 'package:new_version_plus/new_version_plus.dart';
import 'dart:io';
import 'package:pub_semver/pub_semver.dart';

import 'widgets/tracker.dart';

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
    // Check version
    _checkVersion();
    super.initState();
  }

  void _checkVersion() async {
    final newVersionPlus = NewVersionPlus();
    final status = await newVersionPlus.getVersionStatus();
    if (status != null) {
      print("Local: ${status.localVersion}");
      print("Store: ${status.storeVersion}");
      print("Can update: ${status.canUpdate}");
      print("Store link: ${status.appStoreLink}");

      if (status.canUpdate) {
        _showCustomUpdateDialog(status);
      }
    }
  }

  void _showCustomUpdateDialog(VersionStatus status) {
    showDialog(
      context: context,
      barrierDismissible: true, // Prevent tap outside to close
      builder: (context) {
        return AlertDialog(
          // titlePadding:
          //     const EdgeInsets.only(top: 8, right: 8, left: 16, bottom: 8),
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Update Available")],
          ),
          content: const Text(
            "A new version is available.\n"
            "You're currently on older version .\n"
            "Please update to continue.",
          ),
          actions: [
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white, // White background
                  foregroundColor: Colors.black, // Black text
                  // padding: EdgeInsets.symmetric(
                  //     horizontal: MediaQuery.of(context).size.width * 0.04,
                  //     vertical: MediaQuery.of(context).size.width * 0.02),
                ),
                onPressed: () async {
                  final uri = Uri.parse(status.appStoreLink);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  }
                },
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.004),
                    child: const Text(
                      'Update Now',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: FontFamily.cplt20,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
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
                      UIDimensions.verticalSpace(18),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
                            onPressed: () async {
                              final Uri url = Uri.parse(
                                'https://cplt20.cuelive.com/?clientId=cplt20&gameId=arcade&configurationId=689bb4eaab270e9f40db760a&engagement=bouncer-dash-side-runner#/sign-up/questions',
                              );

                              if (await canLaunchUrl(url)) {
                                await launchUrl(url,
                                    mode: LaunchMode.externalApplication);
                              } else {
                                // Handle error if URL can't be opened
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Could not open the link')),
                                );
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.004),
                              child: const Text(
                                'Bouncer Dash',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: FontFamily.cplt20,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      UIDimensions.verticalSpace(18),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width *
                              0.6, // 60% of screen width
                          height: MediaQuery.of(context).size.height * 0.05,

                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.cyan),
                            onPressed: () {
                              FlutterCueLightShowSdk.launchCue();
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.004),
                              child: const Text(
                                'CPL Light Show',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: FontFamily.cplt20,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const LiveScore(),
                      const TopStoriesWidget(),
                      const MatchHeighlightsWidget(),
                      const PointsTable(),
                      UIDimensions.verticalSpace(10),
                      const Tracker(),
                      UIDimensions.verticalSpace(38),
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
