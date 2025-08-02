import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/utils/extensions/context_extension.dart';
import '../../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../../../domain/models/match_details/match_details.dart';
import '../../../../../widgets/custom_text.dart';
import '../../home/widgets/points_table.dart';

class ScoreBoardTabView extends ConsumerWidget {
  final MatchDetails scoreboard;
  final String battingTeamId;
  final String bowlingTeamId;
  const ScoreBoardTabView(
      {super.key,
      required this.scoreboard,
      required this.battingTeamId,
      required this.bowlingTeamId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final yetToBatPlayers = scoreboard.inningsScorecards
            ?.where((element) => element.battingTeamId == battingTeamId)
            .firstWhere((element) => element.battingPerformances != null,
                orElse: () => const InningsScores())
            .battingPerformances
            ?.where((element) => element.didNotBat == true)
            .toList() ??
        [];
    final battingPerformances = scoreboard.inningsScorecards
            ?.where((element) => element.battingTeamId == battingTeamId)
            .firstWhere((element) => element.battingPerformances != null,
                orElse: () => const InningsScores())
            .battingPerformances ??
        [];
    final bowlingPerformances = scoreboard.inningsScorecards
            ?.where((element) => element.bowlingTeamId == bowlingTeamId)
            .firstWhere((element) => element.bowlingPerformances != null,
                orElse: () => const InningsScores())
            .bowlingPerformances ??
        [];
    final ProgressiveScores? progressiveScores = scoreboard.inningsScorecards
        ?.where((element) => element.battingTeamId == battingTeamId)
        .firstWhere((element) => element.progressiveScores != null,
            orElse: () => const InningsScores())
        .progressiveScores;

    return Padding(
      padding: UIDimensions.symmetricPaddingInsets(horizontal: 16),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: UIDimensions.onlyPaddingInsets(top: 24),
        children: [
          CustomText.titleLarge(
            "Batting",
            color: context.customColors.secondaryOrange,
          ),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(5),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(1),
              4: FlexColumnWidth(1),
              5: FlexColumnWidth(2),
            },
            children: [
              const TableRow(
                children: [
                  TableRowContent(content: "Batting"),
                  TableRowContent(content: "R"),
                  TableRowContent(content: "B"),
                  TableRowContent(content: "4s"),
                  TableRowContent(content: "6s"),
                  TableRowContent(content: "SR")
                ],
              ),
              ...battingPerformances.map(
                (e) => TableRow(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: context.customColors.secondaryOrange ??
                                  context.colorScheme.background))),
                  children: [
                    Padding(
                      padding:
                          UIDimensions.symmetricPaddingInsets(vertical: 12),
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText.titleMedium(
                              "${e.firstName?.toString()} ${e.lastName?.toString()}",
                            ),
                            UIDimensions.horizontalSpaceSmall,
                            CustomText.titleSmall(
                              e.text ?? "",
                              color: context.customColors.grey4Color,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                    ),
                    TableRowContent(
                      content: e.runs?.toString() ?? "",
                    ),
                    TableRowContent(
                      content: e.balls?.toString() ?? "",
                    ),
                    TableRowContent(
                      content: e.fours?.toString() ?? "",
                    ),
                    TableRowContent(
                      content: e.sixes?.toString() ?? "",
                    ),
                    TableRowContent(
                      content: e.strikeRate?.toString() ?? "",
                    ),
                  ],
                ),
              ),
              TableRow(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: context.customColors.secondaryOrange ??
                                context.colorScheme.background))),
                children: [
                  const TableRowContent(content: "Extras"),
                  TableRowContent(
                      content: progressiveScores?.extras?.toString() ?? ""),
                  const TableRowContent(content: ""),
                  const TableRowContent(content: ""),
                  const TableRowContent(content: ""),
                  const TableRowContent(content: "")
                ],
              ),
              TableRow(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: context.customColors.secondaryOrange ??
                                context.colorScheme.background))),
                children: [
                  const TableRowContent(content: "Total Runs"),
                  TableRowContent(
                      content: progressiveScores?.runs?.toString() ?? ""),
                  const TableRowContent(content: ""),
                  const TableRowContent(content: ""),
                  const TableRowContent(content: ""),
                  const TableRowContent(content: "")
                ],
              )
            ],
          ),
          if (yetToBatPlayers.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: context.customColors.secondaryOrange ??
                          context.colorScheme.background),
                ),
              ),
              child: Padding(
                padding: UIDimensions.symmetricPaddingInsets(vertical: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText.titleMedium("Yet to bat"),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      runSpacing: 5,
                      spacing: 5,
                      children: yetToBatPlayers.asMap().entries.map((entry) {
                        int index = entry.key;
                        var player = entry.value;
                        return DotWidget(
                          name: player.firstName ?? "",
                          isDotVisible: !(index == yetToBatPlayers.length - 1),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          UIDimensions.verticalSpaceLarge,
          CustomText.titleLarge(
            "Bowling",
            color: context.colorScheme.tertiary,
          ),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(5),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(1),
              4: FlexColumnWidth(1),
              5: FlexColumnWidth(2),
            },
            children: [
              const TableRow(
                children: [
                  TableRowContent(content: "Bowling"),
                  TableRowContent(content: "O"),
                  TableRowContent(content: "M"),
                  TableRowContent(content: "R"),
                  TableRowContent(content: "W"),
                  TableRowContent(content: "Econ.")
                ],
              ),
              ...bowlingPerformances.map(
                (e) => TableRow(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: context.colorScheme.tertiary))),
                  children: [
                    Padding(
                      padding:
                          UIDimensions.symmetricPaddingInsets(vertical: 12),
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText.titleMedium(
                              "${e.firstName.toString()} ${e.lastName.toString()} ",
                            ),
                          ],
                        ),
                      ),
                    ),
                    TableRowContent(
                      content: e.overs?.toString() ?? "",
                    ),
                    TableRowContent(
                      content: e.maidens?.toString() ?? "",
                    ),
                    TableRowContent(
                      content: e.runs?.toString() ?? "",
                    ),
                    TableRowContent(
                      content: e.wickets?.toString() ?? "",
                    ),
                    TableRowContent(
                      content: e.economy?.toString() ?? "",
                    ),
                  ],
                ),
              ),
            ],
          ),
          UIDimensions.verticalSpaceMedium,
        ],
      ),
    );
  }
}

class DotWidget extends StatelessWidget {
  final String name;
  final bool isDotVisible;
  const DotWidget({super.key, required this.name, this.isDotVisible = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText.titleSmall(
          name,
          color: context.customColors.grey4Color,
          fontWeight: FontWeight.w400,
        ),
        UIDimensions.horizontalSpaceSmall,
        Visibility(
          visible: isDotVisible,
          child: Padding(
            padding: UIDimensions.onlyPaddingInsets(bottom: 4),
            child: Container(
              width: 4.0,
              height: 4.0,
              decoration: BoxDecoration(
                color: context.customColors.grey4Color,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
