import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/utils/extensions/context_extension.dart';
import '../../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../../../domain/models/match_details/match_details.dart';
import '../../../../../../../domain/states/score_card_state.dart';
import '../../../../../../providers/matches/matches_provider.dart';
import '../../../../../widgets/error_cards/something_went_wrong_card.dart';
import '../../../../../widgets/shimmer/common_shimmer.dart';
import 'score_board_tabview.dart';

class ScoreBoardContainer extends ConsumerStatefulWidget {
  final String matchId;
  const ScoreBoardContainer({super.key, required this.matchId});

  @override
  ConsumerState<ScoreBoardContainer> createState() =>
      _ScoreBoardContainerState();
}

class _ScoreBoardContainerState extends ConsumerState<ScoreBoardContainer>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int index = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scoreCardState = ref.watch(scoreCardNotifierProvider);
    return switch (scoreCardState) {
      ScoreCardStateInitial() => Center(
          child: CommonShimmer(height: 500, width: context.screenWidth * 0.9),
        ),
      ScoreCardStateLoading() => Center(
            child: CommonShimmer(
          height: 500,
          width: context.screenWidth * 0.9,
        )),
      ScoreCardStateLoaded(scoreCard: MatchDetails scoreboard) =>
        RefreshIndicator(
          onRefresh: () => ref
              .read(scoreCardNotifierProvider.notifier)
              .getScoreCard(widget.matchId),
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Padding(
                  padding: UIDimensions.onlyPaddingInsets(
                      left: 16, right: 16, top: 16),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: context.colorScheme.primary,
                      border: Border.all(color: context.colorScheme.tertiary),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: context.colorScheme.tertiary),
                      dividerColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: context.colorScheme.primary,
                      unselectedLabelColor: context.customColors.grey4Color,
                      tabs: [
                        Tab(text: scoreboard.teams?[0].shortName ?? ""),
                        Tab(text: scoreboard.teams?[1].shortName ?? ""),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ScoreBoardTabView(
                        scoreboard: scoreboard,
                        battingTeamId: scoreboard.teams?.first.teamId ?? "",
                        bowlingTeamId: scoreboard.teams?.last.teamId ?? "",
                      ),
                      ScoreBoardTabView(
                          scoreboard: scoreboard,
                          battingTeamId: scoreboard.teams?.last.teamId ?? "",
                          bowlingTeamId: scoreboard.teams?.first.teamId ?? ""),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ScoreCardStateError() => SomethingWentWrongCard(
          onPressed: () => ref
              .read(scoreCardNotifierProvider.notifier)
              .getScoreCard(widget.matchId),
        ),
    };
  }
}
