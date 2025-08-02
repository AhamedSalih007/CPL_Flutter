import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/utils/assets_gen/assets.gen.dart';
import '../../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../../../domain/models/players/player.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/shimmer/common_shimmer.dart';

class PlayerCard extends StatelessWidget {
  final PlayerData player;
  const PlayerCard({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedNetworkImage(
          imageUrl: player.acf?.photo ?? "",
          height: 30,
          width: 30,
          fit: BoxFit.contain,
          placeholder: (context, url) {
            return const CommonShimmer(
              height: 30,
              width: 30,
              cornerRadius: 999,
            );
          },
          errorWidget: (context, url, error) =>
              Assets.images.defaultplayer.image(
            height: 30,
            width: 30,
            fit: BoxFit.fitHeight,
          ),
        ),
        UIDimensions.horizontalSpaceSmall,
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText.bodySmall("Captain"),
            UIDimensions.verticalSpace(4),
            CustomText.headlineSmall(player.acf?.fullName ?? "")
          ],
        )
      ],
    );
  }
}
