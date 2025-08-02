import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/router/app_router.dart';
import '../../../../../../core/utils/assets_gen/assets.gen.dart';
import '../../../../../../core/utils/assets_gen/fonts.gen.dart';
import '../../../../../../core/utils/extensions/context_extension.dart';
import '../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../../domain/enums/banner_category.dart';
import '../../../../../../domain/models/banner/banner.dart';
import '../../../../../../domain/models/teams/teams.dart';
import '../../../../../../domain/states/banner_state.dart';
import '../../../../../../domain/states/teams_state.dart';
import '../../../../../providers/banners/banner_provider.dart';
import '../../../../../providers/core/router_provider.dart';
import '../../../../../providers/teams_provider.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/error_cards/something_went_wrong_card.dart';
import '../../../../widgets/shimmer/common_shimmer.dart';
import '../../../../widgets/shimmer/teams_shimmer.dart';
import 'widgets/team_container.dart';

@RoutePage()
class TeamsScreen extends ConsumerStatefulWidget {
  const TeamsScreen({super.key});

  @override
  ConsumerState<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends ConsumerState<TeamsScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(teamsNotifierProvider.notifier).getTeams();
      ref
          .read(bannerNotifierProvider(CategoryBanner.teams.val).notifier)
          .getBanner();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final List<String> dropdownValues = [
    //   "2020",
    //   "2021",
    //   "2022",
    //   "2023",
    //   "2024"
    // ];
    final teamsState = ref.watch(teamsNotifierProvider);
    return RefreshIndicator(
      onRefresh: () async {
        ref
            .read(bannerNotifierProvider(CategoryBanner.teams.val).notifier)
            .getBanner();
        ref.read(teamsNotifierProvider.notifier).getTeams();
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            scrolledUnderElevation: 0.0,
            expandedHeight: kToolbarHeight + 100,
            toolbarHeight: kToolbarHeight + 90,
            automaticallyImplyLeading: false,
            flexibleSpace: Stack(
              children: [
                teamsBanner(ref, context),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Assets.images.teamsClip.image(),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: CustomText.displayLarge(
                    "TEAMS",
                    fontSize: 35,
                    fontFamily: FontFamily.cplt20,
                    color: context.colorScheme.secondary,
                  ),
                ),
                // Positioned(
                //   right: 20,
                //   top: 60,
                //   child: SizedBox(
                //     // height: 40,
                //     width: 100,
                //     child: DropdownButtonFormField(
                //       padding: EdgeInsets.zero,
                //       decoration: InputDecoration(
                //           fillColor: context.customColors.black40Color,
                //           focusedBorder: const OutlineInputBorder(
                //               borderRadius:
                //                   BorderRadius.all(Radius.circular(8)),
                //               borderSide: BorderSide(color: Colors.white)),
                //           enabledBorder: const OutlineInputBorder(
                //               borderRadius:
                //                   BorderRadius.all(Radius.circular(8)),
                //               borderSide: BorderSide(color: Colors.white)),
                //           border: const OutlineInputBorder(
                //               borderRadius:
                //                   BorderRadius.all(Radius.circular(8)),
                //               borderSide: BorderSide(color: Colors.white))),
                //       iconSize: 14,
                //       icon: const Icon(Icons.keyboard_arrow_down),
                //       alignment: Alignment.center,
                //       items: dropdownValues
                //           .map((value) => DropdownMenuItem(
                //                 value: value,
                //                 child: Padding(
                //                   padding: const EdgeInsets.only(top: 4),
                //                   child: CustomText.labelMedium(
                //                     value,
                //                     fontWeight: FontWeight.w600,
                //                   ),
                //                 ),
                //               ))
                //           .toList(),
                //       onChanged: (value) {},
                //       isExpanded: false,
                //       value: dropdownValues.first,
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: ColoredBox(
              color: context.colorScheme.primary,
              child: switch (teamsState) {
                TeamsStateInitial() => const TeamsShimmer(),
                TeamsStateLoading() => const TeamsShimmer(),
                TeamsStateLoaded(teams: List<TeamsData> teamsData) => teamsData
                        .isNotEmpty
                    ? GridView.count(
                        primary: false,
                        padding: UIDimensions.allPaddingInsets(20),
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 20,
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        children: <Widget>[
                          ...List.generate(
                              teamsData.length,
                              (index) => InkWell(
                                    onTap: () {
                                      ref.read(appRouterProvider).push(
                                          TeamDetailsRoute(
                                              teamId: teamsData[index].id ?? 0,
                                              teamsData: teamsData[index]));
                                    },
                                    child: TeamContainer(
                                      imageUrl:
                                          teamsData[index].acf?.logo?['url'] ??
                                              "",
                                      title: teamsData[index].title?.rendered ??
                                          "",
                                    ),
                                  )),
                        ],
                      )
                    : const Center(
                        child: CustomText.bodyMedium("No Teams Available"),
                      ),
                TeamsStateError() => Center(
                    child: SomethingWentWrongCard(
                      onPressed: () =>
                          ref.read(teamsNotifierProvider.notifier).getTeams(),
                    ),
                  )
              },
            ),
          )
        ],
      ),
    );
  }
}

Widget teamsBanner(WidgetRef ref, BuildContext context) {
  final teamsBannerState =
      ref.watch(bannerNotifierProvider(CategoryBanner.teams.val));
  switch (teamsBannerState) {
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
        height: kToolbarHeight + 160,
        width: context.screenWidth,
        child: CachedNetworkImage(
          imageUrl: bannerData?.teamsBannerImage?.sizes?.s2048x2048 ?? "",
          fit: BoxFit.fitHeight,
          placeholder: (context, url) {
            return CommonShimmer(
                height: 200, width: context.screenWidth, cornerRadius: 0);
          },
          errorWidget: (context, url, error) {
            return Assets.images.errorImage.image(fit: BoxFit.cover);
          },
        ),
      );
    case BannerStateError():
      return const SizedBox();
  }
}
