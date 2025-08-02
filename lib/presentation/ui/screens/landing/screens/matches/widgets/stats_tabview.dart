import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/utils/assets_gen/assets.gen.dart';
import '../../../../../../../core/utils/extensions/context_extension.dart';
import '../../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../../../domain/models/match_details/match_details.dart';
import '../../../../../../providers/matches/matches_provider.dart';
import '../../../../../widgets/circular_icon.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/shimmer/common_shimmer.dart';
import '../../home/widgets/highlight_container.dart';

class StatsTabview extends ConsumerStatefulWidget {
  final MatchDetails matchDetails;
  const StatsTabview({super.key, required this.matchDetails});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StatsTabviewState();
}

class _StatsTabviewState extends ConsumerState<StatsTabview> {
  int barCount = 0;
  @override
  Widget build(BuildContext context) {
    PlayerOfMatch? player = ref
        .read(matchDetailsNotifierProvider.notifier)
        .getPlayerOfTheMatch(widget.matchDetails);
    MostRuns? mostRunsPlayer = ref
        .read(matchDetailsNotifierProvider.notifier)
        .getPlayerOfMostRuns(widget.matchDetails);
    MostWickets? mostWicketsPlayer = ref
        .read(matchDetailsNotifierProvider.notifier)
        .getPlayerOfMostWickets(widget.matchDetails);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UIDimensions.verticalSpaceMedium,
          if (player != null) ...[
            Padding(
              padding: UIDimensions.symmetricPaddingInsets(
                  vertical: 8, horizontal: 16),
              child: const CustomText.titleLarge("Player of the Match"),
            ),
            UIDimensions.verticalSpaceSmall,
            Padding(
              padding: UIDimensions.symmetricPaddingInsets(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: context.customColors.grey2Color,
                        radius: 20,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl:
                                player.player?.profilePicture?.original?.url ??
                                    "",
                            height: 40,
                            width: 40,
                            placeholder: (context, url) => const CommonShimmer(
                              height: 40,
                              width: 40,
                              cornerRadius: 999,
                            ),
                            errorWidget: (context, url, error) => Assets
                                .images.defaultplayer
                                .image(height: 24, width: 24),
                          ),
                        ),
                      ),
                      UIDimensions.horizontalSpaceSmall,
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText.bodySmall(
                            player.team?.name ?? "",
                            color: context.customColors.secondaryOrange,
                          ),
                          CustomText.titleMedium(
                            player.player?.cardNameF ?? "",
                            height: 0.9,
                          ),
                          UIDimensions.verticalSpace(2),
                          CustomText.labelMedium(
                            ref
                                .read(matchDetailsNotifierProvider.notifier)
                                .getPlayerBattingDescription(player.player),
                            height: 0.9,
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            UIDimensions.verticalSpaceMedium,
          ],
          if (mostRunsPlayer != null) ...[
            Padding(
              padding: UIDimensions.symmetricPaddingInsets(
                  vertical: 8, horizontal: 16),
              child: const CustomText.titleLarge("Most Runs"),
            ),
            UIDimensions.verticalSpaceSmall,
            Padding(
              padding: UIDimensions.symmetricPaddingInsets(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: context.customColors.grey2Color,
                        radius: 20,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: mostRunsPlayer
                                    .player!.profilePicture?.original?.url ??
                                "",
                            height: 40,
                            width: 40,
                            placeholder: (context, url) => const CommonShimmer(
                              height: 40,
                              width: 40,
                              cornerRadius: 999,
                            ),
                            errorWidget: (context, url, error) => Assets
                                .images.defaultplayer
                                .image(height: 24, width: 24),
                          ),
                        ),
                      ),
                      UIDimensions.horizontalSpaceSmall,
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText.bodySmall(
                            mostRunsPlayer.team?.name ?? '',
                            color: context.customColors.secondaryOrange,
                          ),
                          CustomText.titleMedium(
                            mostRunsPlayer.player!.cardNameF ?? "",
                            height: 0.9,
                          ),
                          UIDimensions.verticalSpace(2),
                          CustomText.labelMedium(
                            "${mostRunsPlayer.runsTotal?.toString() ?? '0'} runs",
                            height: 0.9,
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            UIDimensions.verticalSpaceMedium,
          ],
          if (mostWicketsPlayer != null) ...[
            Padding(
              padding: UIDimensions.symmetricPaddingInsets(
                  vertical: 8, horizontal: 16),
              child: const CustomText.titleLarge("Most Wickets"),
            ),
            UIDimensions.verticalSpaceSmall,
            Padding(
              padding: UIDimensions.symmetricPaddingInsets(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: context.customColors.grey2Color,
                        radius: 20,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: mostWicketsPlayer
                                    .player!.profilePicture?.original?.url ??
                                "",
                            height: 40,
                            width: 40,
                            placeholder: (context, url) => const CommonShimmer(
                              height: 40,
                              width: 40,
                              cornerRadius: 999,
                            ),
                            errorWidget: (context, url, error) => Assets
                                .images.defaultplayer
                                .image(height: 24, width: 24),
                          ),
                        ),
                      ),
                      UIDimensions.horizontalSpaceSmall,
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText.bodySmall(
                            mostWicketsPlayer.team?.name ?? '',
                            color: context.customColors.secondaryOrange,
                          ),
                          CustomText.titleMedium(
                            mostWicketsPlayer.player!.cardNameF ?? "",
                            height: 0.9,
                          ),
                          UIDimensions.verticalSpace(2),
                          CustomText.labelMedium(
                            "${mostWicketsPlayer.wicketsTotal?.toString() ?? '0'} wickets",
                            height: 0.9,
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            UIDimensions.verticalSpaceMedium,
          ],
          if (widget.matchDetails.additionalData?.highlightsUrl != null) ...[
            Padding(
              padding: UIDimensions.symmetricPaddingInsets(
                  vertical: 8, horizontal: 16),
              child: const CustomText.titleLarge("Highlights"),
            ),
            HighlightContainer(
              url: widget.matchDetails.additionalData?.highlightsUrl,
            )
          ]

          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       const CustomText.titleLarge("1st Innings"),
          //       RichText(
          //         text: TextSpan(
          //           text: "Barboados",
          //           style: const TextStyle(
          //               fontWeight: FontWeight.w600, fontSize: 16),
          //           children: [
          //             const TextSpan(text: " "),
          //             TextSpan(
          //               text: "230-5",
          //               style: TextStyle(
          //                   color: context.customColors.secondaryYellow,
          //                   fontWeight: FontWeight.w600,
          //                   fontSize: 16),
          //             )
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // UIDimensions.verticalSpaceSmall,
          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: SizedBox(
          //     height: context.screenHeight * 0.5,
          //     width: context.screenWidth * 2,
          //     child: Stack(
          //       children: [
          //         BarChart(
          //           BarChartData(
          //             titlesData: const FlTitlesData(
          //                 show: true,
          //                 topTitles: AxisTitles(),
          //                 rightTitles: AxisTitles()),
          //             barTouchData: BarTouchData(
          //               enabled: false,
          //               touchTooltipData: BarTouchTooltipData(
          //                 getTooltipColor: (group) => Colors.black,
          //                 tooltipRoundedRadius: 999,
          //                 tooltipMargin: 2,
          //                 getTooltipItem: (
          //                   BarChartGroupData group,
          //                   int groupIndex,
          //                   BarChartRodData rod,
          //                   int rodIndex,
          //                 ) {
          //                   return BarTooltipItem(
          //                     rod.toY.round().toString(),
          //                     const TextStyle(
          //                       color: Colors.white,
          //                       fontWeight: FontWeight.bold,
          //                     ),
          //                   );
          //                 },
          //               ),
          //             ),
          //             gridData: const FlGridData(
          //                 drawHorizontalLine: true,
          //                 show: true,
          //                 drawVerticalLine: false),
          //             borderData: FlBorderData(show: false),
          //             barGroups: List.generate(
          //               20,
          //               (i) => makeGroupData(
          //                 i,
          //                 Random().nextInt(20).toDouble(),
          //               ),
          //             ),
          //           ),
          //         ),
          //         const PositionedWidgets(),
          //       ],
          //     ),
          //   ),
          // ),
          // UIDimensions.verticalSpaceMedium,
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       const CustomText.titleLarge("2nd Innings"),
          //       RichText(
          //         text: TextSpan(
          //           text: "Guyana Amazon Warriors",
          //           style: TextStyle(
          //               fontWeight: FontWeight.w600,
          //               fontSize: 16,
          //               color: context.colorScheme.onSurface),
          //           children: [
          //             const TextSpan(text: " "),
          //             TextSpan(
          //               text: "230-5",
          //               style: TextStyle(
          //                   color: context.customColors.secondaryYellow,
          //                   fontWeight: FontWeight.w600,
          //                   fontSize: 16),
          //             )
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // UIDimensions.verticalSpaceSmall,
          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: SizedBox(
          //       height: context.screenHeight * 0.5,
          //       width: context.screenWidth * 2,
          //       child: BarChart(BarChartData(
          //           titlesData: const FlTitlesData(
          //               show: true,
          //               topTitles: AxisTitles(),
          //               rightTitles: AxisTitles()),
          //           barTouchData: BarTouchData(
          //             enabled: false,
          //             handleBuiltInTouches: true,
          //             touchTooltipData: BarTouchTooltipData(
          //               fitInsideHorizontally: true,
          //               getTooltipColor: (group) => Colors.red,
          //               fitInsideVertically: true,
          //               tooltipRoundedRadius: 99,
          //               getTooltipItem: (
          //                 BarChartGroupData group,
          //                 int groupIndex,
          //                 BarChartRodData rod,
          //                 int rodIndex,
          //               ) {
          //                 return BarTooltipItem(
          //                   "2".toString(), //Number of Wickets
          //                   const TextStyle(
          //                     color: Colors.white,
          //                     fontSize: 14,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 );
          //               },
          //             ),
          //           ),
          //           gridData: const FlGridData(
          //               drawHorizontalLine: true,
          //               show: true,
          //               drawVerticalLine: false),
          //           borderData: FlBorderData(show: false),
          //           barGroups: List.generate(
          //             20,
          //             (i) => makeGroupData(
          //               i,
          //               Random().nextInt(20).toDouble(),
          //               numberOFWickets: Random().nextInt(2),
          //             ), //Number of Wickets
          //           )))),
          // ),
          // UIDimensions.verticalSpaceLarge
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y, {int numberOFWickets = 0}) {
    return BarChartGroupData(
      x: x + 1,
      showingTooltipIndicators: numberOFWickets > 0 ? [0] : null,
      barRods: [
        BarChartRodData(
          toY: y,
          color: context.colorScheme.primaryContainer,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          width: 24,
          borderSide: BorderSide(
            color: context.colorScheme.primaryContainer,
            width: 2.0,
          ),
        ),
      ],
    );
  }
}

class PositionedWidgets extends StatelessWidget {
  const PositionedWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double chartWidth = constraints.maxWidth;

        double barWidth = (chartWidth / 20);
        double barSpacing = (barWidth / 4); // Adjust as needed

        return Stack(
          children: [
            Positioned(
              left: (barSpacing + barWidth) + (44),
              bottom: 32, // Adjust based on bar height
              child: Column(
                children: [
                  CircularIcon(
                    height: 10,
                    width: 10,
                    icon: CustomText.bodySmall(
                      "",
                      color: context.primary,
                      height: 1.6,
                    ),
                    bgColor: context.customColors.redColor,
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
