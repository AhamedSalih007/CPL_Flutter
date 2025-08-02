import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/assets_gen/assets.gen.dart';
import '../../../../core/utils/extensions/context_extension.dart';
import '../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../domain/enums/competition_filter_type.dart';
import '../../../../domain/models/competitions/competitions.dart';
import '../../../providers/competitions/competitions_provider.dart';
import '../../../providers/matches/matches_provider.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/shimmer/common_shimmer.dart';

@RoutePage(name: "TeamVenueBottomSheetRoute")
class TeamVenueBottommSheet extends ConsumerWidget {
  final String title;
  final List<Venues>? venues;
  final List<CompetitionTeams>? teams;
  final List<String>? years;
  final CompetitionFilterType type;
  const TeamVenueBottommSheet(
      {super.key,
      required this.title,
      this.teams,
      this.venues,
      this.years,
      required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: UIDimensions.onlyPaddingInsets(
          left: 16, right: 16, top: 36, bottom: 16),
      child: Container(
        width: context.screenWidth,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16), topLeft: Radius.circular(16))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText.displaySmall(title,
                    color: context.colorScheme.tertiary,
                    fontWeight: FontWeight.w700),
                InkWell(
                  onTap: () async {
                    type == CompetitionFilterType.year
                        ? ref
                            .read(yeaFilterNotifierProvider.notifier)
                            .update(null)
                        : type == CompetitionFilterType.team
                            ? ref
                                .read(teamFilterNotifierProvider.notifier)
                                .update(null)
                            : ref
                                .read(venueFilterNotifierProvider.notifier)
                                .update(null);
                    if (type != CompetitionFilterType.year) {
                      ref.read(matchesNotifierProvider.notifier).getMatches(
                          teamId: ref.read(teamFilterNotifierProvider)?.teamId,
                          venueId:
                              ref.read(venueFilterNotifierProvider)?.venueId);
                    }
                    await context.maybePop();
                  },
                  child: CustomText.titleMedium(
                    "Clear".toUpperCase(),
                    color: context.colorScheme.onSurface,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                  ),
                )
              ],
            ),
            ...List.generate(
              type == CompetitionFilterType.year
                  ? (years?.length ?? 0)
                  : type == CompetitionFilterType.team
                      ? (teams?.length ?? 0)
                      : (venues?.length ?? 0),
              (index) => InkWell(
                onTap: () async {
                  type == CompetitionFilterType.year
                      ? ref
                          .read(yeaFilterNotifierProvider.notifier)
                          .update(years?[index] ?? "")
                      : type == CompetitionFilterType.team
                          ? ref
                              .read(teamFilterNotifierProvider.notifier)
                              .update(teams?[index] ?? const CompetitionTeams())
                          : ref
                              .read(venueFilterNotifierProvider.notifier)
                              .update(venues?[index] ?? const Venues());
                  //change the code if year filter is added
                  if (type != CompetitionFilterType.year) {
                    ref.read(matchesNotifierProvider.notifier).getMatches(
                          teamId: ref.read(teamFilterNotifierProvider)?.teamId,
                          venueId:
                              ref.read(venueFilterNotifierProvider)?.venueId,
                        );
                  }
                  await context.maybePop();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    UIDimensions.verticalSpaceSmall,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            if (type == CompetitionFilterType.team) ...[
                              CachedNetworkImage(
                                imageUrl: teams?[index].logo?.small?.url ?? "",
                                width: 24,
                                height: 24,
                                placeholder: (context, url) {
                                  return const CommonShimmer(
                                    height: 24,
                                    width: 24,
                                    cornerRadius: 999,
                                  );
                                },
                                errorWidget: (context, url, error) {
                                  return Assets.images.errorImage.image(
                                    height: 24,
                                    width: 24,
                                  );
                                },
                              ),
                              UIDimensions.horizontalSpaceSmall,
                            ],
                            Padding(
                              padding: UIDimensions.onlyPaddingInsets(top: 6),
                              child: SizedBox(
                                width: type == CompetitionFilterType.team
                                    ? context.screenWidth * 0.5
                                    : context.screenWidth * 0.6,
                                child: CustomText.bodyMedium(
                                  type == CompetitionFilterType.year
                                      ? (years?[index] ?? "")
                                      : type == CompetitionFilterType.team
                                          ? (teams?[index].name ?? "")
                                          : (venues?[index].name ?? ""),
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                            visible: type == CompetitionFilterType.year
                                ? ref.watch(yeaFilterNotifierProvider) ==
                                    (years?[index])
                                : type == CompetitionFilterType.team
                                    ? ref.watch(teamFilterNotifierProvider) ==
                                        (teams?[index])
                                    : ref.watch(venueFilterNotifierProvider) ==
                                        (venues?[index]),
                            child: Assets.icons.check.svg(
                              width: 24,
                              height: 24,
                            )),
                      ],
                    ),
                    UIDimensions.verticalSpaceSmall,
                  ],
                ),
              ),
            )
          ],
        ),
        // Positioned(
        //   top: -28, // Adjust based on your requirement
        //   left: MediaQuery.of(context).size.width / 2 -
        //       28, // Center the FAB
        //   child: FloatingActionButton(
        //     onPressed: () {
        //       // Add your onPressed code here!
        //     },
        //     child: const Icon(Icons.add),
        //   ),
        // ),
      ),
    );
  }
}
