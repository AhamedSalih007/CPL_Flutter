import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/utils/extensions/context_extension.dart';
import '../../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../../../domain/enums/delivery_outcome.dart';
import '../../../../../../../domain/models/match_details/match_details.dart';
import '../../../../../../../domain/states/commentary_state.dart';
import '../../../../../../providers/matches/matches_provider.dart';
import '../../../../../widgets/circular_icon.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/error_cards/something_went_wrong_card.dart';
import '../../../../../widgets/shimmer/commentary_shimmer.dart';

class CommentaryTabview extends ConsumerStatefulWidget {
  final String matchId;
  final List<String> inningsId;
  final List<Teams> teams;
  const CommentaryTabview(
      {super.key,
      required this.matchId,
      required this.inningsId,
      required this.teams});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CommentaryTabviewState();
}

class _CommentaryTabviewState extends ConsumerState<CommentaryTabview>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Padding(
            padding:
                UIDimensions.onlyPaddingInsets(left: 16, right: 16, top: 16),
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
                  Tab(text: widget.teams[0].shortName ?? ""),
                  Tab(text: widget.teams[1].shortName ?? ""),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                commentaryContainer(
                    ref, widget.inningsId.first, widget.matchId),
                commentaryContainer(
                  ref,
                  widget.inningsId.last,
                  widget.matchId,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget commentaryContainer(WidgetRef ref, String inningsId, String matchId) {
  final commentaryState = ref.watch(commentaryNotifierProvider(inningsId));
  return switch (commentaryState) {
    CommentaryStateInitial() => const CommentaryShimmer(),
    CommentaryStateLoading() => const CommentaryShimmer(),
    CommentaryStateLoaded(commentary: List<List<Balls>> recentBalls) => Padding(
        padding: UIDimensions.allPaddingInsets(16.0),
        child: recentBalls.isNotEmpty
            ? ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: recentBalls.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: context.dividerColor, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    margin: UIDimensions.onlyPaddingInsets(bottom: 16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: ExpansionTile(
                        trailing: const Icon(
                          Icons.keyboard_arrow_down,
                          size: 16,
                        ),
                        collapsedBackgroundColor: context.colorScheme.primary,
                        backgroundColor: context.colorScheme.background,
                        initiallyExpanded: index == 0,
                        onExpansionChanged: (value) => ref
                            .read(commentaryExpansionNotifierProvider(index)
                                .notifier)
                            .toggle(),
                        // visualDensity: const VisualDensity(horizontal: -4),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText.bodyMedium(
                              "${(recentBalls[index].first.overNumber ?? 0) + 1} Over",
                              color: context.customColors.secondaryYellow,
                            ),
                            UIDimensions.horizontalSpaceSmall,
                            Expanded(
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                spacing: 8,
                                direction: Axis.horizontal,
                                runSpacing: 5,
                                children: [
                                  ...List.generate(
                                    recentBalls[index].length,
                                    (runsIndex) => Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CircularIcon(
                                          icon: CustomText.titleSmall(
                                            recentBalls[index][runsIndex]
                                                    .shortDescription
                                                    ?.toString() ??
                                                "",
                                            color: Color(DeliveryOutcome.values
                                                .firstWhere(
                                                  (element) =>
                                                      element.val ==
                                                      recentBalls[index]
                                                              [runsIndex]
                                                          .shortDescription,
                                                  orElse: () =>
                                                      DeliveryOutcome.other,
                                                )
                                                .foreGroundColor),
                                          ),
                                          borderColor:
                                              Color(DeliveryOutcome.values
                                                  .firstWhere(
                                                    (element) =>
                                                        element.val ==
                                                        recentBalls[index]
                                                                [runsIndex]
                                                            .shortDescription,
                                                    orElse: () =>
                                                        DeliveryOutcome.other,
                                                  )
                                                  .borderColor),
                                          bgColor: Color(DeliveryOutcome.values
                                              .firstWhere(
                                                (element) =>
                                                    element.val ==
                                                    recentBalls[index]
                                                            [runsIndex]
                                                        .shortDescription,
                                                orElse: () =>
                                                    DeliveryOutcome.other,
                                              )
                                              .backgroundColor),
                                          height: 30,
                                          width: 30,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        children: [
                          Padding(
                            padding: UIDimensions.symmetricPaddingInsets(
                                horizontal: 16, vertical: 8),
                            child: const Row(
                              children: [
                                CustomText.bodyMedium("Ball"),
                                UIDimensions.horizontalSpaceMedium,
                                CustomText.bodyMedium("Summary")
                              ],
                            ),
                          ),
                          ...List.generate(
                            recentBalls[index].length,
                            (idx) => CommentaryContent(
                                recentOver: recentBalls[index][idx]),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : const Center(
                child: CustomText.bodyMedium("No Commentary Available"),
              ),
      ),
    CommentaryStateError() => SomethingWentWrongCard(
        onPressed: () => ref
            .read(commentaryNotifierProvider(inningsId).notifier)
            .getCommentary(matchId),
      ),
  };
}

class CommentaryContent extends StatelessWidget {
  final Balls recentOver;
  const CommentaryContent({super.key, required this.recentOver});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UIDimensions.symmetricPaddingInsets(horizontal: 16, vertical: 8),
      child: Container(
        padding: UIDimensions.symmetricPaddingInsets(vertical: 8),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: context.colorScheme.tertiary))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText.bodyMedium(
                  "${recentOver.overNumber?.toString() ?? ""}.${recentOver.ballNumber?.toString() ?? ""}",
                  color: context.customColors.secondaryYellow,
                ),
                UIDimensions.verticalSpace(2),
                CircularIcon(
                  icon: CustomText.titleSmall(
                    recentOver.shortDescription?.toString() ?? "",
                    color: Color(DeliveryOutcome.values
                        .firstWhere(
                          (element) =>
                              element.val == recentOver.shortDescription,
                          orElse: () => DeliveryOutcome.other,
                        )
                        .foreGroundColor),
                  ),
                  borderColor: Color(DeliveryOutcome.values
                      .firstWhere(
                        (element) => element.val == recentOver.shortDescription,
                        orElse: () => DeliveryOutcome.other,
                      )
                      .borderColor),
                  bgColor: Color(DeliveryOutcome.values
                      .firstWhere(
                        (element) => element.val == recentOver.shortDescription,
                        orElse: () => DeliveryOutcome.other,
                      )
                      .backgroundColor),
                  height: 30,
                  width: 30,
                )
              ],
            ),
            UIDimensions.horizontalSpaceMedium,
            Flexible(
              child: CustomText.bodySmall(
                recentOver.description ?? "",
                maxLines: 4,
              ),
            )
          ],
        ),
      ),
    );
  }
}
