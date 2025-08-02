import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/utils/assets_gen/assets.gen.dart';
import '../../../../../../core/utils/extensions/context_extension.dart';
import '../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../../domain/models/players/player.dart';
import '../../../../../../domain/models/teams/teams.dart';
import '../../../../../../domain/states/players_state.dart';
import '../../../../../providers/players_provider.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/error_cards/something_went_wrong_card.dart';
import '../../../../widgets/shimmer/common_shimmer.dart';
import '../../../../widgets/shimmer/teams_shimmer.dart';
import '../../../../widgets/text_html.dart';
import 'widgets/player_card.dart';
import 'widgets/player_container.dart';

@RoutePage()
class TeamDetailsScreen extends ConsumerStatefulWidget {
  const TeamDetailsScreen(
      {super.key, required this.teamId, required this.teamsData});
  final int teamId;
  final TeamsData teamsData;

  @override
  ConsumerState<TeamDetailsScreen> createState() => _TeamDetailsScreenState();
}

class _TeamDetailsScreenState extends ConsumerState<TeamDetailsScreen> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(playersNotifierProvider.notifier).getPlayers(widget.teamId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final playersState = ref.watch(playersNotifierProvider);
    final isCaptainAvailable = (ref.watch(playersNotifierProvider).captain !=
            null &&
        ref.watch(playersNotifierProvider).captain!.acf != null &&
        ref.watch(playersNotifierProvider).captain!.acf!.fullName != null &&
        ref.watch(playersNotifierProvider).captain!.acf!.fullName!.isNotEmpty);
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          scrolledUnderElevation: 0.0,
          expandedHeight: kToolbarHeight + 130,
          toolbarHeight:
              kToolbarHeight + (isCaptainAvailable ? kToolbarHeight : 130),
          automaticallyImplyLeading: false,
          backgroundColor: context.colorScheme.background,
          flexibleSpace: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  color: const Color(0xff050519),
                  height: 100,
                  width: context.screenWidth,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Assets.images.teamDetailsClip.image(),
              ),
              Positioned(
                  top: 50,
                  left: 16,
                  child: InkWell(
                    onTap: () async {
                      await context.maybePop();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_outlined,
                      size: 16,
                    ),
                  )),
              Positioned(
                top: isCaptainAvailable ? 90 : 130,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: context.screenWidth * 0.8,
                        child: TextHtml(
                          text:
                              "<p>${widget.teamsData.title?.rendered ?? ""}</p>",
                          style: {
                            "p": Style(
                              color: context.colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                              maxLines: 3,
                              fontSize: FontSize(UIDimensions.font20),
                            )
                          },
                        )),
                    if (isCaptainAvailable) ...[
                      //UIDimensions.verticalSpaceMedium,
                      PlayerCard(
                        player: ref.watch(playersNotifierProvider).captain ??
                            const PlayerData(),
                      ),
                    ]
                  ],
                ),
              ),
              Positioned(
                top: 100,
                right: 20,
                child: CachedNetworkImage(
                  imageUrl: widget.teamsData.acf?.logo?['url'] ?? "",
                  height: 100,
                  width: 80,
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return const CommonShimmer(
                      height: 100,
                      width: 80,
                      cornerRadius: 8,
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Assets.images.errorImage.image(
                      height: 100,
                      width: 80,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: true,
          child: ColoredBox(
            color: context.colorScheme.primary,
            child: switch (playersState) {
              PlayersStateInitial() => const TeamsShimmer(),
              PlayersStateLoading() => const TeamsShimmer(),
              PlayersStateLoaded(players: List<PlayerData> playersData) =>
                (playersData.isNotEmpty)
                    ? GridView.count(
                        // physics: const NeverScrollableScrollPhysics(),
                        primary: false,
                        padding: UIDimensions.allPaddingInsets(20),
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 20,
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                        children: <Widget>[
                          ...List.generate(
                              playersData.length,
                              (index) => PlayerContainer(
                                    playerData: playersData[index],
                                  )),
                        ],
                      )
                    : const Center(
                        child: CustomText.bodyLarge(
                          "No Players Available",
                        ),
                      ),
              PlayersStateError() => Center(
                  child: SomethingWentWrongCard(
                    onPressed: () => ref
                        .read(playersNotifierProvider.notifier)
                        .getPlayers(widget.teamId),
                  ),
                )
            },
          ),
        )
      ],
    );
  }
}
