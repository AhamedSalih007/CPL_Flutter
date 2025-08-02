import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../core/utils/assets_gen/assets.gen.dart';
import '../../../../../../../core/utils/extensions/context_extension.dart';
import '../../../../../../../core/utils/extensions/date_time_extension.dart';
import '../../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../../../core/utils/extensions/string_extensions.dart';
import '../../../../../../../domain/models/players/player.dart';
import '../../../../../../providers/players_provider.dart';
import '../../../../../modals/snack_bar/snack_bar_factory.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/shimmer/common_shimmer.dart';

class PlayerContainer extends ConsumerWidget {
  final PlayerData playerData;
  const PlayerContainer({super.key, required this.playerData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        var url = playerData.acf?.crickinfoUrl;
        if (url != null && url.isNotEmpty) {
          final Uri uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          } else {
            if (context.mounted) {
              SnackbarFactory.showError("Can not launch URL");
            }
          }
        }
      },
      child: Container(
        padding: UIDimensions.allPaddingInsets(16),
        decoration: BoxDecoration(
          color: context.customColors.purpleVariant,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: context.colorScheme.secondary,
          ),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: CachedNetworkImage(
                  imageUrl: playerData.acf?.photo.runtimeType == String
                      ? playerData.acf?.photo ?? ""
                      : "",
                  //height: context.screenHeight * 0.16,
                  width: context.screenWidth * 0.26,
                  fit: BoxFit.contain,
                  placeholder: (context, url) {
                    return const CommonShimmer(
                      height: 65,
                      width: 65,
                      cornerRadius: 8,
                    );
                  },
                  errorWidget: (context, url, error) =>
                      Assets.images.defaultplayer.image(
                    height: 120,
                    width: 90,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              UIDimensions.verticalSpace(20),
              Flexible(
                child: Column(
                  children: [
                    SizedBox(
                      width: context.screenWidth * 0.4,
                      child: CustomText.titleMedium(
                        ref
                            .read(playersNotifierProvider.notifier)
                            .getPlayerPosition(playerData),
                        color: context.customColors.grey5Color,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                      ),
                    ),
                    SizedBox(
                      width: context.screenWidth * 0.4,
                      child: CustomText.headlineSmall(
                        playerData.acf?.fullName ?? "",
                        color: context.colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                    if (playerData.acf?.dob != null &&
                        (playerData.acf?.dob?.toDate?.age ?? 0) > 0)
                      SizedBox(
                        width: context.screenWidth * 0.4,
                        child: CustomText.titleMedium(
                          "${playerData.acf?.dob?.toDate?.age.toString() ?? 0} Years",
                          color: context.customColors.grey5Color,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                        ),
                      ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
