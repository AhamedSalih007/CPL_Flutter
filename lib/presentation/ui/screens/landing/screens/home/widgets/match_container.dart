import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../../core/utils/assets_gen/assets.gen.dart';
import '../../../../../../../core/utils/extensions/context_extension.dart';
import '../../../../../../../core/utils/extensions/string_extensions.dart';
import '../../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../../../domain/enums/match_status.dart';
import '../../../../../../../domain/models/match_details/match_details.dart';
import '../../../../../../providers/matches/matches_provider.dart';
import '../../../../../modals/snack_bar/snack_bar_factory.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/shimmer/common_shimmer.dart';
import 'countdown_timer.dart';

class MatchContainer extends ConsumerWidget {
  final double? width;
  final MatchDetails matchData;
  final int totalMatches;
  final double? leftPadding;
  const MatchContainer(
      {super.key,
      required this.matchData,
      this.width,
      this.leftPadding,
      required this.totalMatches});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchStartDate = DateTime.parse(matchData.startDate ?? "").toLocal();
    final firstTeamScore = ref
        .read(matchDetailsNotifierProvider.notifier)
        .getFirstTeamScore(matchData);
    final secondTeamScore = ref
        .read(matchDetailsNotifierProvider.notifier)
        .getSecondTeamScore(matchData);
    final isLessThanOneday =
        matchStartDate.difference(DateTime.now()).inDays < 1;
    Duration duration = matchStartDate.difference(DateTime.now());
    return Padding(
      padding: UIDimensions.onlyPaddingInsets(left: leftPadding ?? 16),
      child: Container(
        width: width ?? context.screenWidth * 0.85,
        decoration: BoxDecoration(
          //color: context.customColors.black40Color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: context.colorScheme.tertiary,
          ),
        ),
        child: Padding(
          padding: UIDimensions.allPaddingInsets(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText.titleMedium(
                    "${matchData.title}",
                    fontWeight: FontWeight.bold,
                    color: context.customColors.grey4Color,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(99),
                      color: matchData.status == MatchStatus.live.val
                          ? context.customColors.secondaryRed
                          : context.customColors.white10Color,
                    ),
                    child: Padding(
                      padding: UIDimensions.onlyPaddingInsets(
                          left: 25, right: 25, top: 8, bottom: 6),
                      child: Text(
                        matchData.status?.toUpperCase() ?? "",
                        style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  )
                ],
              ),
              UIDimensions.verticalSpaceMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: SizedBox(
                      width: context.screenWidth * 0.32,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              CachedNetworkImage(
                                height: 47,
                                width: 47,
                                imageUrl:
                                    matchData.teams?.first.logo?.small?.url ??
                                        "",
                                placeholder: (context, url) {
                                  return const CommonShimmer(
                                    height: 47,
                                    width: 47,
                                    cornerRadius: 999,
                                  );
                                },
                                errorWidget: (context, url, error) {
                                  return Assets.images.errorImage.image(
                                      fit: BoxFit.fill, height: 47, width: 47);
                                },
                              ),
                              CustomText.bodyMedium(
                                matchData.teams?.first.shortName ?? "",
                                color: context.customColors.textColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          UIDimensions.horizontalSpaceSmall,
                          Visibility(
                            visible: matchData.status == MatchStatus.live.val ||
                                matchData.status == MatchStatus.completed.val,
                            child: Column(
                              children: [
                                CustomText.displaySmall(
                                  firstTeamScore?.runs != null &&
                                          firstTeamScore?.wickets != null
                                      ? "${firstTeamScore?.runs ?? ""}-${firstTeamScore?.wickets ?? ""}"
                                      : "-",
                                  fontWeight: FontWeight.w700,
                                ),
                                CustomText.bodyMedium(
                                  firstTeamScore?.oversBowled != null
                                      ? "${firstTeamScore?.oversBowled} Overs"
                                      : "-",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  (matchData.status == MatchStatus.upcoming.val)
                      ? Flexible(
                          child: Column(
                            children: [
                              CustomText.bodyMedium(
                                isLessThanOneday
                                    ? "Match starts in "
                                    : "Match Start on",
                              ),
                              isLessThanOneday
                                  ? CountdownTimer(
                                      time: duration,
                                    )
                                  : CustomText.displaySmall(
                                      matchData.startDate!.dDMM,
                                      fontWeight: FontWeight.w700,
                                    ),
                            ],
                          ),
                        )
                      : const CustomText.bodyMedium(
                          "V/S",
                          fontWeight: FontWeight.w600,
                        ),
                  Flexible(
                    child: SizedBox(
                      width: context.screenWidth * 0.32,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Visibility(
                            visible: matchData.status == MatchStatus.live.val ||
                                matchData.status == MatchStatus.completed.val,
                            child: Expanded(
                              child: matchData.status ==
                                          MatchStatus.completed.val ||
                                      matchData.status == MatchStatus.live.val
                                  ? Column(
                                      children: [
                                        CustomText.displaySmall(
                                          secondTeamScore?.runs != null &&
                                                  secondTeamScore?.wickets !=
                                                      null
                                              ? "${secondTeamScore?.runs}-${secondTeamScore?.wickets}"
                                              : "-",
                                          fontWeight: FontWeight.w700,
                                        ),
                                        CustomText.bodyMedium(
                                          secondTeamScore?.oversBowled != null
                                              ? "${secondTeamScore?.oversBowled} Overs"
                                              : "-",
                                        ),
                                      ],
                                    )
                                  : const CustomText.bodyMedium(
                                      "Yet to bat",
                                    ),
                            ),
                          ),
                          UIDimensions.horizontalSpaceSmall,
                          Column(
                            children: [
                              CachedNetworkImage(
                                height: 47,
                                width: 47,
                                imageUrl:
                                    matchData.teams?.last.logo?.small?.url ??
                                        "",
                                placeholder: (context, url) {
                                  return const CommonShimmer(
                                    height: 47,
                                    width: 47,
                                    cornerRadius: 999,
                                  );
                                },
                                errorWidget: (context, url, error) {
                                  return Assets.images.errorImage.image(
                                      fit: BoxFit.fill, height: 47, width: 47);
                                },
                              ),
                              CustomText.bodyMedium(
                                matchData.teams?.last.shortName ?? "",
                                fontWeight: FontWeight.w600,
                                color: context.customColors.textColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              UIDimensions.verticalSpaceSmall,
              const Divider(
                color: Color.fromRGBO(255, 255, 255, 0.3),
              ),
              UIDimensions.verticalSpaceSmall,
              (matchData.status == MatchStatus.live.val)
                  ? CustomText.bodyMedium(
                      matchData.description ?? "",
                      fontWeight: FontWeight.w500,
                      maxLines: 2,
                    )
                  : (matchData.status == MatchStatus.completed.val)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText.bodyMedium(
                              matchData.description ?? "",
                              fontWeight: FontWeight.w500,
                            ),
                            if (matchData.venue != null &&
                                matchData.venue!.fullName != null &&
                                matchData.venue!.fullName!.isNotEmpty)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Assets.icons.location.svg(
                                    height: 20,
                                    width: 20,
                                  ),
                                  UIDimensions.horizontalSpace(2),
                                  Expanded(
                                    child: CustomText.titleSmall(
                                      "${matchData.venue?.fullName}",
                                      color: context.customColors.textColor,
                                      fontWeight: FontWeight.w500,
                                      maxLines: 2,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: SizedBox(
                                //width: context.screenWidth * 0.5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText.bodyMedium(
                                      "Starts at ${matchStartDate.toString().gmtTime}",
                                      color: context.customColors.textColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    if (matchData.venue != null &&
                                        matchData.venue!.fullName != null &&
                                        matchData.venue!.fullName!.isNotEmpty)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Assets.icons.location.svg(
                                            height: 20,
                                            width: 20,
                                          ),
                                          UIDimensions.horizontalSpace(2),
                                          Expanded(
                                            child: CustomText.titleSmall(
                                              "${matchData.venue?.fullName}",
                                              color: context
                                                  .customColors.textColor,
                                              fontWeight: FontWeight.w500,
                                              maxLines: 2,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            if (matchData.additionalData?.ticketingUrl != null)
                              Flexible(
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(8),
                                  onTap: () async {
                                    final Uri url = Uri.parse(matchData
                                            .additionalData?.ticketingUrl ??
                                        "");
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(url);
                                    } else {
                                      if (context.mounted) {
                                        SnackbarFactory.showError(
                                            "Can not launch URL");
                                      }
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: context.customColors.primaryPurple,
                                    ),
                                    child: Padding(
                                      padding: UIDimensions.onlyPaddingInsets(
                                          left: 25,
                                          right: 25,
                                          top: 8,
                                          bottom: 6),
                                      child: const CustomText.bodySmall(
                                        "Buy Tickets",
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
