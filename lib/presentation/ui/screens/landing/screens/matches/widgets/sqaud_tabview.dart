import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/utils/assets_gen/assets.gen.dart';
import '../../../../../../../core/utils/extensions/context_extension.dart';
import '../../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../../../domain/models/match_details/match_details.dart';
import '../../../../../../providers/matches/matches_provider.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/shimmer/common_shimmer.dart';

class SquadTabView extends ConsumerWidget {
  final List<Teams?> teamsData;
  final bool isCompletedMatch;
  const SquadTabView(
      {super.key, required this.teamsData, this.isCompletedMatch = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: UIDimensions.allPaddingInsets(16),
      child: ((!isCompletedMatch &&
                  teamsData.isNotEmpty &&
                  ((teamsData.first?.squad?.isNotEmpty ?? false) ||
                      (teamsData.last?.squad?.isNotEmpty ?? false))) ||
              (isCompletedMatch &&
                  teamsData.isNotEmpty &&
                  ((teamsData.first?.players?.isNotEmpty ?? false) ||
                      (teamsData.last?.players?.isNotEmpty ?? false))))
          ? ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: context.customColors.grey2Color,
                          radius: 20,
                          child: CachedNetworkImage(
                            imageUrl:
                                teamsData.first?.logo?.original?.url ?? "",
                            height: 24,
                            width: 24,
                            placeholder: (context, url) => const CommonShimmer(
                              height: 24,
                              width: 24,
                              cornerRadius: 999,
                            ),
                            errorWidget: (context, url, error) => Assets
                                .images.defaultplayer
                                .image(height: 24, width: 24),
                          ),
                        ),
                        UIDimensions.horizontalSpaceSmall,
                        CustomText.titleMedium(teamsData.first?.shortName ?? "")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomText.titleMedium(teamsData.last?.shortName ?? ""),
                        UIDimensions.horizontalSpaceSmall,
                        CircleAvatar(
                          backgroundColor: context.customColors.grey2Color,
                          radius: 20,
                          child: CachedNetworkImage(
                            imageUrl: teamsData.last?.logo?.original?.url ?? "",
                            height: 24,
                            width: 24,
                            placeholder: (context, url) => const CommonShimmer(
                              height: 24,
                              width: 24,
                              cornerRadius: 999,
                            ),
                            errorWidget: (context, url, error) => Assets
                                .images.defaultplayer
                                .image(height: 24, width: 24),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                UIDimensions.verticalSpaceMedium,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: firstTeam(
                          context: context,
                          players: teamsData.first?.players ?? [],
                          squad: teamsData.first?.squad ?? [],
                          ref: ref),
                    ),
                    Expanded(
                      child: secondTeam(
                          context: context,
                          players: teamsData.last?.players ?? [],
                          squad: teamsData.last?.squad ?? [],
                          ref: ref),
                    ),
                  ],
                )
              ],
            )
          : const Center(child: CustomText.bodyMedium("No Squad Available")),
    );
  }
}

Widget firstTeam(
    {required BuildContext context,
    List<Players>? players,
    List<Squad>? squad,
    required WidgetRef ref}) {
  return ((players != null && players.isNotEmpty) ||
          (squad != null && squad.isNotEmpty))
      ? Column(
          children: [
            ...List.generate(
              (players != null && players.isNotEmpty)
                  ? players.length
                  : squad!.length,
              (index) => Padding(
                padding: UIDimensions.onlyPaddingInsets(bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: ((players != null && players.isNotEmpty)
                                  ? players[index].profilePicture?.original?.url
                                  : squad![index]
                                      .profilePicture
                                      ?.original
                                      ?.url) ??
                              "",
                          height: 44,
                          width: 44,
                          placeholder: (context, url) => const CommonShimmer(
                            height: 44,
                            width: 44,
                            cornerRadius: 999,
                          ),
                          errorWidget: (context, url, error) => Assets
                              .images.defaultplayer
                              .image(height: 44, width: 44),
                        ),
                      ),
                    ),
                    UIDimensions.horizontalSpaceSmall,
                    SizedBox(
                      width: context.screenWidth * 0.25,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if ((players != null && players.isNotEmpty))
                            CustomText.titleSmall(
                              "${ref.read(matchDetailsNotifierProvider.notifier).getSkill(players[index])}",
                              color: context.customColors.secondaryOrange,
                              fontWeight: FontWeight.w500,
                            ),
                          CustomText.titleSmall(
                            (players != null && players.isNotEmpty)
                                ? "${players[index].cardNameF} ${ref.read(matchDetailsNotifierProvider.notifier).getPlayerRole(players[index])}"
                                : "${squad![index].cardNameF}",
                            color: context.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                            maxLines: 2,
                          ),
                          if (players != null && players.isNotEmpty)
                            CustomText.titleSmall(
                              "${ref.read(matchDetailsNotifierProvider.notifier).getPlayerBattingDescription(players[index])}",
                              color: context.customColors.grey5Color,
                              fontWeight: FontWeight.w500,
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      : const Align(
          alignment: Alignment.center, child: Text('No squad available'));
}

Widget secondTeam(
    {required BuildContext context,
    List<Players>? players,
    List<Squad>? squad,
    required WidgetRef ref}) {
  return ((players != null && players.isNotEmpty) ||
          (squad != null && squad.isNotEmpty))
      ? Column(
          children: [
            ...List.generate(
              (players != null && players.isNotEmpty)
                  ? players.length
                  : squad!.length,
              (index) => Padding(
                padding: UIDimensions.onlyPaddingInsets(bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: context.screenWidth * 0.25,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if ((players != null && players.isNotEmpty))
                            CustomText.titleSmall(
                              "${ref.read(matchDetailsNotifierProvider.notifier).getSkill(players[index])}",
                              color: context.customColors.secondaryOrange,
                              fontWeight: FontWeight.w500,
                            ),
                          CustomText.titleSmall(
                            (players != null && players.isNotEmpty)
                                ? "${players[index].cardNameF} ${ref.read(matchDetailsNotifierProvider.notifier).getPlayerRole(players[index])}"
                                : "${squad![index].cardNameF}",
                            color: context.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                            maxLines: 2,
                          ),
                          if (players != null && players.isNotEmpty)
                            CustomText.titleSmall(
                              "${ref.read(matchDetailsNotifierProvider.notifier).getPlayerBattingDescription(players[index])}",
                              color: context.customColors.grey5Color,
                              fontWeight: FontWeight.w500,
                            ),
                        ],
                      ),
                    ),
                    UIDimensions.horizontalSpaceSmall,
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: ((players != null && players.isNotEmpty)
                                  ? players[index].profilePicture?.original?.url
                                  : squad![index]
                                      .profilePicture
                                      ?.original
                                      ?.url) ??
                              "",
                          height: 44,
                          width: 44,
                          placeholder: (context, url) => const CommonShimmer(
                            height: 44,
                            width: 44,
                            cornerRadius: 999,
                          ),
                          errorWidget: (context, url, error) => Assets
                              .images.defaultplayer
                              .image(height: 44, width: 44),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      : const Align(
          alignment: Alignment.center, child: Text('No squad available'));
}
